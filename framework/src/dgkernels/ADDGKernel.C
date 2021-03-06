//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADDGKernel.h"
#include "Assembly.h"
#include "MooseVariable.h"
#include "Problem.h"
#include "SubProblem.h"
#include "NonlinearSystemBase.h"

// libmesh includes
#include "libmesh/threads.h"

InputParameters
ADDGKernel::validParams()
{
  InputParameters params = DGKernelBase::validParams();
  return params;
}

ADDGKernel::ADDGKernel(const InputParameters & parameters)
  : DGKernelBase(parameters),
    NeighborMooseVariableInterface(
        this, false, Moose::VarKindType::VAR_NONLINEAR, Moose::VarFieldType::VAR_FIELD_STANDARD),
    _var(*mooseVariable()),
    _phi(_assembly.phiFace(_var)),
    _grad_phi(_assembly.gradPhiFace(_var)),

    _test(_var.phiFace()),
    _grad_test(_var.gradPhiFace()),

    _phi_neighbor(_assembly.phiFaceNeighbor(_var)),
    _grad_phi_neighbor(_assembly.gradPhiFaceNeighbor(_var)),

    _test_neighbor(_var.phiFaceNeighbor()),
    _grad_test_neighbor(_var.gradPhiFaceNeighbor()),

    _u(_var.adSln()),
    _grad_u(_var.adGradSln()),
    _u_neighbor(_var.adSlnNeighbor()),
    _grad_u_neighbor(_var.adGradSlnNeighbor())
{
  _subproblem.haveADObjects(true);

  addMooseVariableDependency(mooseVariable());

  _save_in.resize(_save_in_strings.size());
  _diag_save_in.resize(_diag_save_in_strings.size());

  for (unsigned int i = 0; i < _save_in_strings.size(); i++)
  {
    MooseVariableFEBase * var = &_subproblem.getVariable(_tid,
                                                         _save_in_strings[i],
                                                         Moose::VarKindType::VAR_AUXILIARY,
                                                         Moose::VarFieldType::VAR_FIELD_STANDARD);

    if (_sys.hasVariable(_save_in_strings[i]))
      mooseError("Trying to use solution variable " + _save_in_strings[i] +
                 " as a save_in variable in " + name());

    if (var->feType() != _var.feType())
      paramError(
          "save_in",
          "saved-in auxiliary variable is incompatible with the object's nonlinear variable: ",
          moose::internal::incompatVarMsg(*var, _var));

    _save_in[i] = var;
    var->sys().addVariableToZeroOnResidual(_save_in_strings[i]);
    addMooseVariableDependency(var);
  }

  _has_save_in = _save_in.size() > 0;

  for (unsigned int i = 0; i < _diag_save_in_strings.size(); i++)
  {
    MooseVariableFEBase * var = &_subproblem.getVariable(_tid,
                                                         _diag_save_in_strings[i],
                                                         Moose::VarKindType::VAR_NONLINEAR,
                                                         Moose::VarFieldType::VAR_FIELD_STANDARD);

    if (_sys.hasVariable(_diag_save_in_strings[i]))
      mooseError("Trying to use solution variable " + _diag_save_in_strings[i] +
                 " as a diag_save_in variable in " + name());

    if (var->feType() != _var.feType())
      paramError(
          "diag_save_in",
          "saved-in auxiliary variable is incompatible with the object's nonlinear variable: ",
          moose::internal::incompatVarMsg(*var, _var));

    _diag_save_in[i] = var;
    var->sys().addVariableToZeroOnJacobian(_diag_save_in_strings[i]);
    addMooseVariableDependency(var);
  }

  _has_diag_save_in = _diag_save_in.size() > 0;
}

ADDGKernel::~ADDGKernel() {}

void
ADDGKernel::computeElemNeighResidual(Moose::DGResidualType type)
{
  bool is_elem;
  if (type == Moose::Element)
    is_elem = true;
  else
    is_elem = false;

  const VariableTestValue & test_space = is_elem ? _test : _test_neighbor;

  if (is_elem)
    prepareVectorTag(_assembly, _var.number());
  else
    prepareVectorTagNeighbor(_assembly, _var.number());

  for (_qp = 0; _qp < _qrule->n_points(); _qp++)
    for (_i = 0; _i < test_space.size(); _i++)
      _local_re(_i) += raw_value(_JxW[_qp] * _coord[_qp] * computeQpResidual(type));

  accumulateTaggedLocalResidual();

  if (_has_save_in)
  {
    Threads::spin_mutex::scoped_lock lock(_resid_vars_mutex);
    for (const auto & var : _save_in)
    {
      const std::vector<dof_id_type> & dof_indices =
          is_elem ? var->dofIndices() : var->dofIndicesNeighbor();
      var->sys().solution().add_vector(_local_re, dof_indices);
    }
  }
}

void
ADDGKernel::computeElemNeighJacobian(Moose::DGJacobianType type)
{
  const VariableTestValue & test_space =
      (type == Moose::ElementElement || type == Moose::ElementNeighbor) ? _test : _test_neighbor;
  const VariableTestValue & loc_phi =
      (type == Moose::ElementElement || type == Moose::NeighborElement) ? _phi : _phi_neighbor;

  if (type == Moose::ElementElement)
    prepareMatrixTag(_assembly, _var.number(), _var.number());
  else
    prepareMatrixTagNeighbor(_assembly, _var.number(), _var.number(), type);

  size_t ad_offset = 0;
  if (type == Moose::ElementElement || type == Moose::NeighborElement)
    ad_offset = _var.number() * _sys.getMaxVarNDofsPerElem();
  else
    ad_offset = _var.number() * _sys.getMaxVarNDofsPerElem() +
                (_sys.system().n_vars() * _sys.getMaxVarNDofsPerElem());

  for (_qp = 0; _qp < _qrule->n_points(); _qp++)
    for (_i = 0; _i < test_space.size(); _i++)
    {
      DualReal residual = computeQpResidual(
          (type == Moose::ElementElement || type == Moose::ElementNeighbor) ? Moose::Element
                                                                            : Moose::Neighbor);
      for (_j = 0; _j < loc_phi.size(); _j++)
        _local_ke(_i, _j) += _JxW[_qp] * _coord[_qp] * residual.derivatives()[ad_offset + _j];
    }

  accumulateTaggedLocalMatrix();

  if (_has_diag_save_in && (type == Moose::ElementElement || type == Moose::NeighborNeighbor))
  {
    unsigned int rows = _local_ke.m();
    DenseVector<Number> diag(rows);
    for (unsigned int i = 0; i < rows; i++)
      diag(i) = _local_ke(i, i);

    Threads::spin_mutex::scoped_lock lock(_jacoby_vars_mutex);
    for (const auto & var : _diag_save_in)
    {
      if (type == Moose::ElementElement)
        var->sys().solution().add_vector(diag, var->dofIndices());
      else
        var->sys().solution().add_vector(diag, var->dofIndicesNeighbor());
    }
  }
}

void
ADDGKernel::computeOffDiagElemNeighJacobian(Moose::DGJacobianType type, unsigned int jvar)
{
  const VariableTestValue & test_space =
      (type == Moose::ElementElement || type == Moose::ElementNeighbor) ? _test : _test_neighbor;
  const VariableTestValue & loc_phi =
      (type == Moose::ElementElement || type == Moose::NeighborElement) ? _phi : _phi_neighbor;

  if (type == Moose::ElementElement)
    prepareMatrixTag(_assembly, _var.number(), jvar);
  else
    prepareMatrixTagNeighbor(_assembly, _var.number(), jvar, type);

  size_t ad_offset = 0;
  if (type == Moose::ElementElement || type == Moose::NeighborElement)
    ad_offset = jvar * _sys.getMaxVarNDofsPerElem();
  else
    ad_offset = jvar * _sys.getMaxVarNDofsPerElem() +
                (_sys.system().n_vars() * _sys.getMaxVarNDofsPerElem());

  for (_qp = 0; _qp < _qrule->n_points(); _qp++)
    for (_i = 0; _i < test_space.size(); _i++)
    {
      DualReal residual = computeQpResidual(
          (type == Moose::ElementElement || type == Moose::ElementNeighbor) ? Moose::Element
                                                                            : Moose::Neighbor);
      for (_j = 0; _j < loc_phi.size(); _j++)
        _local_ke(_i, _j) += _JxW[_qp] * _coord[_qp] * residual.derivatives()[ad_offset + _j];
    }

  accumulateTaggedLocalMatrix();
}

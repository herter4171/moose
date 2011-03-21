#ifndef SUBPROBLEM_H_
#define SUBPROBLEM_H_

#include "Mesh.h"
#include "Variable.h"
#include "InitialCondition.h"
#include "MaterialProperty.h"
#include "Function.h"
#include "ParallelUniqueId.h"
#include "Problem.h"
#include "MaterialWarehouse.h"
#include "PostprocessorData.h"
#include "PostprocessorWarehouse.h"
#include "FormattedTable.h"

// libMesh include
#include "equation_systems.h"
#include "transient_system.h"
#include "nonlinear_implicit_system.h"
#include "numeric_vector.h"
#include "sparse_matrix.h"

namespace Moose {

class ImplicitSystem;

/**
 * Generic class for solving nonlinear problems
 *
 */
class SubProblem : public Problem
{
public:
  SubProblem(Mesh &mesh, Problem * parent = NULL);
  virtual ~SubProblem();

  virtual Problem * parent() { return _parent; }

  virtual ImplicitSystem & getNonlinearSystem() = 0;

  /**
   * Get reference to all-purpose parameters
   */
  Parameters & parameters() { return _pars; }

  EquationSystems & es() { return _eq; }
  Mesh & mesh() { return _mesh; }

  virtual bool hasVariable(const std::string & var_name);
  virtual Variable & getVariable(THREAD_ID tid, const std::string & var_name);

  // Solve /////
  virtual void init();

  virtual void update();
  virtual void solve();
  virtual bool converged() = 0;

  // Time stepping /////

  /**
   *
   */
  virtual void onTimestepBegin() = 0;
  virtual void onTimestepEnd() = 0;

  virtual void copySolutionsBackwards();

  virtual Real & time() { return _time; }
  virtual int & timeStep() { return _t_step; }
  virtual Real & dt() { return _dt; }
  virtual Real & dtOld() { return _dt_old; }

  void transient(bool trans) { _transient = trans; }
  bool transient() { return _transient; }

  //
  virtual QBase * & qRule(THREAD_ID tid) = 0;
  virtual const std::vector<Point> & points(THREAD_ID tid) = 0;
  virtual const std::vector<Real> & JxW(THREAD_ID tid) = 0;
  virtual QBase * & qRuleFace(THREAD_ID tid) = 0;
  virtual const std::vector<Point> & pointsFace(THREAD_ID tid) = 0;
  virtual const std::vector<Real> & JxWFace(THREAD_ID tid) = 0;

  virtual FEBase * & getFE(THREAD_ID tid, const FEType & fe_type) = 0;
  virtual FEBase * & getFEFace(THREAD_ID tid, const FEType & fe_type) = 0;
  virtual const Elem * & elem(THREAD_ID tid) = 0;
  virtual unsigned int & side(THREAD_ID tid) = 0;
  virtual const Elem * & sideElem(THREAD_ID tid) = 0;
  virtual const Node * & node(THREAD_ID tid) = 0;

  // ICs /////
  void addInitialCondition(const std::string & ic_name, const std::string & name, InputParameters parameters, std::string var_name);
  void addInitialCondition(const std::string & var_name, Real value); 

  Number initialValue (const Point & p, const Parameters & parameters, const std::string & /*sys_name*/, const std::string & var_name);
  Gradient initialGradient (const Point & p, const Parameters & /*parameters*/, const std::string & /*sys_name*/, const std::string & var_name);

  void initialCondition(EquationSystems & es, const std::string & system_name);

  // Functions /////
  void addFunction(std::string type, const std::string & name, InputParameters parameters);
  Function & getFunction(const std::string & name, THREAD_ID tid = 0);

  // Materials /////
  void addMaterial(const std::string & kernel_name, const std::string & name, InputParameters parameters);

  virtual void updateMaterials();
  virtual void reinitMaterials(unsigned int blk_id, THREAD_ID tid);
  virtual void reinitMaterialsFace(unsigned int blk_id, unsigned int side, THREAD_ID tid);

  // Postprocessors /////
  virtual void addPostprocessor(std::string pp_name, const std::string & name, InputParameters parameters, Moose::PostprocessorType pps_type = Moose::PPS_TIMESTEP);
  /**
   * Get a reference to the value associated with the postprocessor.
   */
  Real & getPostprocessorValue(const std::string & name, THREAD_ID tid = 0);
  virtual void computePostprocessors(int pps_type = Moose::PPS_TIMESTEP);
  virtual void outputPostprocessors();

  virtual void dump();

  // Output /////
  virtual Output & out() { return _out; }
  virtual void output();

protected:
  Problem * _parent;
  Mesh & _mesh;
  EquationSystems _eq;

  bool _transient;
  Real & _time;
  int & _t_step;
  Real & _dt;
  Real _dt_old;

  // Output system
  Output _out;

  /**
   * For storing all-purpose global params 
   */
  Parameters _pars;

  /**
   * List of systems being solved. Allocations/deallocations are responsibilities of derived classes
   */
  std::vector<System *> _sys;

  // Initial conditions
  std::map<std::string, InitialCondition *> _ics;

public:
  // material properties
  std::vector<MaterialData *> _material_data;
  std::vector<MaterialData *> _bnd_material_data;

protected:
  // materials
  std::vector<MaterialWarehouse> _materials;

  // functions
  std::vector<std::map<std::string, Function *> > _functions;


  // postprocessors
  std::vector<PostprocessorData> _pps_data;
  std::vector<PostprocessorWarehouse> _pps;             // pps calculated every time step
  std::vector<PostprocessorWarehouse> _pps_residual;    // pps calculated every residual evaluation
  std::vector<PostprocessorWarehouse> _pps_jacobian;    // pps calculated every jacobian evaluation
  std::vector<PostprocessorWarehouse> _pps_newtonit;    // pps calculated every newton iteration
  FormattedTable _pps_output_table;

  void computePostprocessorsInternal(std::vector<PostprocessorWarehouse> & pps);

  // TODO: PPS output subsystem, and this will go away
  // postprocessor output
public:
  bool _postprocessor_screen_output;
  bool _postprocessor_csv_output;
  bool _postprocessor_ensight_output;
  bool _postprocessor_gnuplot_output;
  std::string _gnuplot_format;


};


void initial_condition(EquationSystems& es, const std::string& system_name);

} // namespace

#endif /* SUBPROBLEM_H_ */

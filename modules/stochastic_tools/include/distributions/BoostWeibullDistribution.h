//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "BoostDistribution.h"

/**
 * A class used to generate Weibull distribution via Boost
 */
class BoostWeibullDistribution : public BoostDistribution<boost::math::weibull_distribution<Real>>
{
public:
  static InputParameters validParams();

  BoostWeibullDistribution(const InputParameters & parameters);
};

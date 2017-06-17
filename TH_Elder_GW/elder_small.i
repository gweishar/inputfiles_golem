# Set up for the Elder problem
[Mesh]
  file = ic/ic_small_out.e
[]

[Variables]
  [./pore_pressure]
    initial_from_file_var = pore_pressure
    initial_from_file_timestep = 2
  [../]
  [./temperature]
    initial_condition = 10
  [../]
[]

[AuxVariables]
  [./darcy_vx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./darcy_vy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./darcy_vz]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  gravity_acceleration = 9.80665
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  permeability_uo = permeability
  porosity_uo = porosity
[]

[BCs]
  [./p_top]
    type = PresetBC
    variable = pore_pressure
    boundary =  top
    value = 101325
  [../]
  [./T_top]
    type = PresetBC
    variable = temperature
    boundary = top
    value =  10
  [../]
  [./T_bottom]
    type = PresetBC
    variable = temperature
    boundary = bottom
    value =  25
  [../]
[]

[Kernels]
  [./p_time]
    type = GolemKernelTimeH
    variable = pore_pressure
  [../]
  [./darcy]
    type = GolemKernelH
    variable = pore_pressure
  [../]
  [./T_time]
    type = GolemKernelTimeT
    variable = temperature
  [../]
  [./T_adv]
    type = GolemKernelTH
    variable = temperature
    is_conservative= true
  [../]
[]

[AuxKernels]
  [./darcy_vx]
    type = GolemDarcyVelocity
    variable = darcy_vx
    component = 0
    execute_on = timestep_end
  [../]
  [./darcy_vy]
    type = GolemDarcyVelocity
    variable = darcy_vy
    component = 1
    execute_on = timestep_end
  [../]
  [./darcy_vz]
    type = GolemDarcyVelocity
    variable = darcy_vz
    component = 2
    execute_on = timestep_end
  [../]
[]

[Materials]
  [./unit_non_adaptive]
    type = GolemMaterialTH
    block = 0
    initial_density_fluid = 999.526088
    initial_density_solid = 2480
    initial_porosity = 0.4
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 1.233333
    initial_heat_capacity_fluid = 4180
    initial_heat_capacity_solid = 920
    initial_permeability = 1.0e-13
    initial_fluid_viscosity = 0.0012389
    fluid_modulus = 4e+09
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
 [../]
[]

[UserObjects]
  [./fluid_density]
    type = GolemFluidDensityIAPWS
  [../]
  [./fluid_viscosity]
    type = GolemFluidViscosityIAPWS
  [../]
  [./porosity]
    type = GolemPorosityConstant
  [../]
  [./permeability]
    type = GolemPermeabilityConstant
  [../]
[]

[Preconditioning]
  [./FSP]
    type = FSP
    topsplit = 'HT'
     [./HT]
       splitting = 'H T'
       splitting_type = multiplicative
       petsc_options = '-snes_ksp_ew
                        -snes_monitor -snes_linesearch_monitor -snes_converged_reason'
       petsc_options_iname = '-ksp_type
                              -ksp_rtol -ksp_max_it
                              -snes_type -snes_linesearch_type
                              -snes_atol -snes_stol -snes_max_it'
       petsc_options_value = 'fgmres
                              1.0e-12 100
                              newtonls cp
                              1 0 1000'
     [../]
     [./H]
       vars = 'pore_pressure'
       petsc_options = '-ksp_converged_reason
                        -snes_ksp_ew'
       petsc_options_iname = '-ksp_type
                              -pc_type -pc_hypre_type
                              -ksp_rtol -ksp_max_it'
       petsc_options_value = 'preonly
                              hypre boomeramg
                              1.0e-04 500'
     [../]
     [./T]
       vars = 'temperature'
       petsc_options = '-ksp_converged_reason
                        -snes_ksp_ew'
       petsc_options_iname = '-ksp_type
                              -pc_type -sub_pc_type -sub_pc_factor_levels
                              -ksp_rtol -ksp_max_it'
       petsc_options_value = 'fgmres
                              asm ilu 1
                              1.0e-04 500'
     [../]
  [../]
[]

[Executioner]
  type = Transient
  solve_type =  'NEWTON' # 'PJFNK'
  num_steps  = 500
  dt = 6.15576e+07
  l_max_its = 250
  nl_max_its = 100
  nl_abs_tol = 1e-05
  nl_rel_tol = 1e-10
[]

[Outputs]
  interval = 10
  [./out]
    type = Exodus
  [../]
  [./console]
    type = Console
    perf_log = true
    output_linear = true
    output_nonlinear = true
  [../]
[]

####  Golem Simple Geomodel ####

[Mesh]
  file = H_2D_steady_out.e
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  has_T_source_sink = true

  #has_lumped_mass_matrix = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
  initial_thermal_conductivity_fluid = 0.65
  initial_heat_capacity_fluid = 4.18e+03
  initial_fluid_viscosity = 1.0e-03
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
  #supg_uo = supg
  #scaling_uo = scaling
[]

[Variables]
  [./pore_pressure]
    initial_from_file_var = pore_pressure
    initial_from_file_timestep = 2
  [../]
  [./temperature]
    initial_condition = 19
  [../]
[]

[Kernels]
  [./darcy]
    type = GolemKernelH
    variable = pore_pressure
  [../]
  [./P_time]
    type = GolemKernelTimeH
    variable = pore_pressure
  [../]
  [./T_time]
    type = GolemKernelTimeT
    variable = temperature
  [../]
  [./T_dif]
    type = GolemKernelT
    variable = temperature
  [../]
  [./T_adv]
    type = GolemKernelTH
    variable = temperature
  [../]
[]


[BCs]
  [./p0_top]
    type = PresetBC
    variable = pore_pressure
    boundary = top
    value = 101325
  [../]
  [./T0_top]
    type = PresetBC
    variable = temperature
    boundary = bottom
    value = 19
  [../]
  [./T0_bottom]
    type = PresetBC
    variable = temperature
    boundary = bottom
    value = 50
  [../]
[]

[Materials]
  [./middle]
    type = GolemMaterialTH
    block = 0
    initial_porosity = 0.4
    initial_permeability = 2.0e-13
    initial_density_solid = 2650
    initial_thermal_conductivity_solid = 6.27
    initial_heat_capacity_solid = 0.900
    T_source_sink = 5e-07
    fluid_modulus = 14285714.29
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
                              1.0e-04 0 1000'
     [../]
     [./H]
       vars = 'pore_pressure'
       petsc_options = '-ksp_converged_reason'
       petsc_options_iname = '-ksp_type
                              -pc_type -pc_hypre_type
                              -ksp_rtol -ksp_max_it'
       petsc_options_value = 'preonly
                              hypre boomeramg
                              1.0e-04 500'
     [../]
     [./T]
       vars = 'temperature'
       petsc_options = '-ksp_converged_reason'
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
  solve_type = Newton
  num_steps  = 100
  dt = 86400
  #3.15576e+07 # 1 year
 # [./TimeStepper]
 #  type = IterationAdaptiveDT
 #  optimal_iterations = 6
 #iteration_window = 1
 #  dt = 86400
 #  growth_factor = 2
 #cutback_factor = 0.5
 #[../]
[]

[Outputs]
  [./out]
    type = Exodus
  [../]
  [./console]
    type = Console
    perf_log = true
    output_linear = false
    output_nonlinear = true
  [../]
[]

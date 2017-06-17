####  Golem Simple Geomodel ####

[Mesh]
  file = ic/ic_out.e
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  #has_lumped_mass_matrix = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
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
    initial_from_file_var = temperature
    initial_from_file_timestep = 2
  [../]
[]

[AuxVariables]
  [./vx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vz]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./darcy]
    type = GolemKernelH
    variable = pore_pressure
  [../]
  #[./P_time]
  #  type = GolemKernelTimeH
  #  variable = pore_pressure
  #[../]
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

[AuxKernels]
  [./darcyx]
    type = GolemDarcyVelocity
    variable = vx
    component = 0
  [../]
  [./darcyy]
    type = GolemDarcyVelocity
    variable = vy
    component = 1
  [../]
  [./darcyz]
    type = GolemDarcyVelocity
    variable = vz
    component = 2
  [../]
[]

[BCs]
  [./p0_top]
    type = PresetBC
    variable = pore_pressure
    boundary = front
    value = 101325
  [../]
  [./T0_top]
    type = PresetBC
    variable = temperature
    boundary = front
    value = 25
  [../]
  [./T_bottom]
    type = NeumannBC
    variable = temperature
    boundary = back
    value = 0.03
  [../]
[]

[Materials]
  [./middle_sup_aquifer]
    type = GolemMaterialTH
    block = 0
    initial_porosity = 0.3
    initial_permeability = 1.2e-11
    initial_density_solid = 2100
    initial_thermal_conductivity_solid = 1.6
    initial_thermal_conductivity_fluid = 0.53 #calculated by hand see notes on day 16(05)
    initial_heat_capacity_solid = 800
    T_source_sink = 2.5e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./bottom_basement]
    type = GolemMaterialTH
    block = 1
    initial_porosity = 0.01
    initial_permeability = 1.0e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    initial_thermal_conductivity_fluid = 3.2 #calculated by hand
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./top_South_Perth_Shale]
    type = GolemMaterialTH
    block = 2
    initial_porosity = 0.1
    initial_permeability = 1.0e-11
    initial_density_solid = 2100
    initial_thermal_conductivity_solid = 1.8
    initial_thermal_conductivity_fluid = 1.5
    initial_heat_capacity_solid = 1000
    T_source_sink = 8e-07
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
  num_steps  = 1000
  dt = 5e7
[]

[Outputs]
  [./out]
    type = Exodus
    interval = 10
  [../]
  [./console]
    type = Console
    perf_log = true
    output_linear = false
    output_nonlinear = true
  [../]
[]

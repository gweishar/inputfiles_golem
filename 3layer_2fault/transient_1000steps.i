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
  initial_thermal_conductivity_fluid = 0.65
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
    value = 19
  [../]
  [./T_bottom]
    type = NeumannBC
    variable = temperature
    boundary = back
    value = 0.03
  [../]
[]

[Materials]
  [./bottom]
    type = GolemMaterialTH
    block = 0
    initial_porosity = 0.01
    initial_permeability = 1.0e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./middle_layer]
    type = GolemMaterialTH
    block = 1
    initial_porosity = 0.1
    initial_permeability = 1.2e-17
    initial_density_solid = 2360
    initial_thermal_conductivity_solid = 4.1
    initial_heat_capacity_solid = 1000
    T_source_sink = 5e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./top_layer]
    type = GolemMaterialTH
    block = 2
    initial_porosity = 0.06
    initial_permeability = 1.2e-13
    initial_density_solid = 2520
    initial_thermal_conductivity_solid = 2.75
    initial_heat_capacity_solid = 775
    T_source_sink = 6e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./Fault_1]
    type = GolemMaterialTH
    block = 3
    material_type = frac
    initial_scaling_factor = 1.0
    initial_permeability = 5e-14
    initial_porosity = 1.0
    initial_density_solid = 2717.0
    initial_thermal_conductivity_solid = 2.4
    initial_heat_capacity_solid = 755.0
    T_source_sink = 1.8e-06
  [../]
  [./Fault_2]
    type = GolemMaterialTH
    block = 4
    material_type = frac
    initial_scaling_factor = 1.0
    initial_permeability = 5e-14
    initial_porosity = 1.0
    initial_density_solid = 2747.0
    initial_thermal_conductivity_solid = 2.5
    initial_heat_capacity_solid = 900.0
    T_source_sink = 2.5e-06
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
  dt = 604800 # 1 week
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

[Debug]
  show_var_residual_norms = true
[]

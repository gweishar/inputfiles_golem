[Mesh]
  file = TH_2D_steady_out.e
[]

[MeshModifiers]
  [./POINT0]
    type = AddExtraNodeset
    new_boundary = 'point_0'
    coord = '100.0 0.0 0.0'
  [../]
  [./POINT1]
    type = AddExtraNodeset
    new_boundary = 'point_1'
    coord = '100.0 0.0 100.0'
  [../]
  [./POINT2]
    type = AddExtraNodeset
    new_boundary = 'point_2'
    coord = '0.0 0.0 100.0'
  [../]
  [./POINT3]
    type = AddExtraNodeset
    new_boundary = 'point_3'
    coord = '0.0 0.0 0.0'
  [../]
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
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

[BCs]
  [./p0_top]
    type = PresetBC
    variable = pore_pressure
    boundary = front
    value = 101325
  [../]
  [./T0_bottom]
    type = PresetBC
    variable = temperature
    boundary = front
    value = 20
  [../]
  [./T0_top]
    type = PresetBC
    variable = temperature
    boundary = front
    value = 10
  [../]
  [./p_bc]
    type = PresetBC
    variable = pore_pressure
    boundary = 'point_0 point_1'
    value = 0.0
  [../]
  [./T_no_bc]
    type = GolemConvectiveTHBC
    variable = temperature
    boundary = 'right left top bottom'
  [../]
[]

[Materials]
  [./THMaterial]
    type = GolemMaterialTH
    block = 0
    initial_porosity = 0.1
    initial_permeability = 1.0e-13
    initial_fluid_viscosity = 1.0e-03
    initial_density_fluid = 1000
    initial_density_solid = 2650
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 5
    initial_heat_capacity_fluid = 2000
    initial_heat_capacity_solid = 1000
    porosity_uo = porosity
    fluid_density_uo = fluid_density
    fluid_viscosity_uo = fluid_viscosity
    permeability_uo = permeability
  [../]
[]

[UserObjects]
  [./porosity]
    type = GolemPorosityConstant
  [../]
  [./fluid_density]
    type = GolemFluidDensityIAPWS
  [../]
  [./fluid_viscosity]
    type = GolemFluidViscosityIAPWS
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
  start_time = 0.0
  dt = 86400
  num_steps = 50
[]

[Outputs]
  #interval = 5
  print_linear_residuals = true
  print_perf_log = true
  exodus = true
[]

[Mesh]
  file = ../mesh/mesh.e
  boundary_id =  '1 2 3 4 5 6'
  boundary_name = 'back front left right bottom top'
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  #has_lumped_mass_matrix = true
  has_T_source_sink = true
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
    initial_condition = 101325
  [../]
  [./temperature]
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
  [./T_dif]
    type = GolemKernelT
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
  active = 'p0_top T0_top T0_bottom'
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
  [./T0_bottom]
    type = PresetBC
    variable = temperature
    boundary = back
    value = 150
  [../]
  [./T_bottom_neumann]
    type = NeumannBC
    variable = temperature
    boundary = back
    value = 0.03
  [../]
[]

[Materials]
  [./middle]
    type = GolemMaterialTH
    block = 0
    initial_porosity = 0.4
    initial_permeability = 1.0e-11
    initial_density_solid = 2650
    initial_thermal_conductivity_solid = 6.27
    initial_heat_capacity_solid = 790
    T_source_sink = 5e-07
    fluid_modulus = 14285714.29
  [../]
  [./bottom]
    type = GolemMaterialTH
    block = 1
    initial_porosity = 0.3
    initial_permeability = 1.0e-11
    initial_density_solid = 2360
    initial_thermal_conductivity_solid = 3.73
    initial_heat_capacity_solid = 1000
    T_source_sink = 4e-06
    fluid_modulus = 14285714.29
  [../]
  [./top]
    type = GolemMaterialTH
    block = 2
    initial_porosity = 0.2
    initial_permeability = 1.0e-11
    initial_density_solid = 2650
    initial_thermal_conductivity_solid = 2.09
    initial_heat_capacity_solid = 900
    T_source_sink = 6e-07
    fluid_modulus = 14285714.29
  [../]
[]

[UserObjects]
  [./fluid_density]
    type = GolemFluidDensityConstant
  [../]
  [./fluid_viscosity]
    type = GolemFluidViscosityConstant
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
  type = Steady
  solve_type = Newton
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

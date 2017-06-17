####  Golem Simple Geomodel ####

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 10
  ny = 1
  nz = 10
  xmin = 0
  xmax = 100
  ymin = 0
  ymax = 2.5
  zmin = 0
  zmax = 100
[]

[GlobalParams]
  pore_pressure = pore_pressure
  has_gravity = true
  temperature = temperature
  #has_lumped_mass_matrix = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
  initial_fluid_viscosity = 1.0e-03
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
[]

[Variables]
  [./pore_pressure]
    initial_condition = 101325
  [../]
  [./temperature]
    initial_condition = 15
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
    value = 10
  [../]
  [./T0_bottom]
    type = PresetBC
    variable = temperature
    boundary = back
    value = 20
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
  [./precond]
    type = SMP
    full = true
    petsc_options = '-snes_ksp_ew'
    petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it -ksp_max_it -sub_pc_type -sub_pc_factor_shift_type'
    petsc_options_value = 'gmres asm 1E-10 1E-10 200 500 lu NONZERO'
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

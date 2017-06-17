#### TEMPLATE Golem Simple Geomodel ####
### Heat conduction only ####

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 27
  ny = 18
  nz = 24
  #block_id = '0 1 2'
  #block_name = 'gneiss steel ice'
  xmax = 1000 # m
  ymax = 1000 # m
  zmax = 1000 # m
[]


[Variables]
  [./pore_pressure]
    order = FIRST
    family = LAGRANGE
  [../]
  [./temperature]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
[]

[Kernels]
  [./heat_conduction]
    type = GolemKernelT
    variable = temperature
  [../]
  [./pore_kernel]
    type = GolemKernelH
    variable = pore_pressure
  [../]
[]


[BCs]
  [./T0_top]
    type = DirichletBC
    variable = temperature
    boundary = front
    value = 298.15 # (K) surface temperature at 25 ºC
  [../]
  [./T_bottom]
    type = NeumannBC
    variable = temperature
    boundary = back
    value = 0.03
  [../]
[]

[Materials]
  [./THMaterial_gneiss]
    type = GolemMaterialTH
    block = 0
    initial_porosity = 0.1
    initial_permeability = 1.0e-11
    initial_fluid_viscosity = 1.0e-03
    initial_density_fluid = 1000
    initial_density_solid = 2650
    initial_thermal_conductivity_fluid = 10
    initial_thermal_conductivity_solid = 6.27
    initial_heat_capacity_fluid = 1100
    initial_heat_capacity_solid = 790
    porosity_uo = porosity
    fluid_density_uo = fluid_density
    fluid_viscosity_uo = fluid_viscosity
    permeability_uo = permeability
  [../]
  [./THMaterial_Coal]
    type = GolemMaterialTH
    block = 1
    initial_porosity = 0.1
    initial_permeability = 1.0e-11
    initial_fluid_viscosity = 1.0e-03
    initial_density_fluid = 1000
    initial_density_solid = 2360
    initial_thermal_conductivity_fluid = 10
    initial_thermal_conductivity_solid = 3.73
    initial_heat_capacity_fluid = 1100
    initial_heat_capacity_solid = 1000
    porosity_uo = porosity
    fluid_density_uo = fluid_density
    fluid_viscosity_uo = fluid_viscosity
    permeability_uo = permeability
  [../]
  [./THMaterial_Shale]
    type = GolemMaterialTH
    block = 2
    initial_porosity = 0.1
    initial_permeability = 1.0e-11
    initial_fluid_viscosity = 1.0e-03
    initial_density_fluid = 1000
    initial_density_solid = 2650
    initial_thermal_conductivity_fluid = 10
    initial_thermal_conductivity_solid = 2.09
    initial_heat_capacity_fluid = 1100
    initial_heat_capacity_solid = 900
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
    type = GolemFluidDensityConstant
  [../]
  [./fluid_viscosity]
    type = GolemFluidViscosityConstant
  [../]
  [./permeability]
    type = GolemPermeabilityConstant
  [../]
[]

[Preconditioning]
  [./fieldsplit]
    type = FSP
    topsplit = pT
    [./pT]
      splitting = 'p T'
      splitting_type = multiplicative
      petsc_options_iname = '-ksp_type
                             -ksp_rtol -ksp_max_it
                             -snes_type -snes_linesearch_type
                             -snes_atol -snes_rtol -snes_max_it'
      petsc_options_value = 'fgmres
                             1.0e-12 50
                             newtonls cp
                             1.0e-05 1.0e-12 25'
    [../]
    [./p]
     vars = 'pore_pressure'
     petsc_options_iname = '-ksp_type -pc_type -sub_pc_type -sub_pc_factor_levels -ksp_rtol -ksp_max_it'
     petsc_options_value = 'fgmres asm ilu 1 1e-12 500'
    [../]
    [./T]
     vars = 'temperature'
     petsc_options_iname = '-ksp_type -pc_type -pc_hypre_type -ksp_rtol -ksp_max_it'
     petsc_options_value = 'preonly hypre boomeramg 1e-12 500'
    [../]
  [../]
[]

[Executioner]
    type = Steady
    solve_type = NEWTON
[]

[Outputs]
  exodus = true
[]

[MeshModifiers]
	[./simple_geomodel]
  		type = AssignElementSubdomainID
  		subdomain_ids = [magic_key]
  	[../]
[]

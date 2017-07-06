####  Golem Simple Geomodel ####
### Heat conduction only ####

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 10
  ny = 10
  nz = 10
  ymin=0
  xmin=0
  zmin= -10
  xmax = 10
  ymax = 10
  zmax = 0
  parallel_type = replicated
[]

[MeshModifiers]
  [./bottom_m]
    type = BoundingBoxNodeSet
    new_boundary = bottom_m
    top_right = '8 8.0 -10'
    bottom_left = '2.0 2 -10'
  [../]
  [./bottom_l]
    type = BoundingBoxNodeSet
    new_boundary = bottom_l
    top_right = '2 10 -10'
    bottom_left = '0 0 -50'
  [../]
  [./bottom_mb]
    type = BoundingBoxNodeSet
    new_boundary = bottom_mb
    top_right = '8 2 -10'
    bottom_left = '2 0 -10'
  [../]
  [./bottom_mf]
    type = BoundingBoxNodeSet
    new_boundary = bottom_mf
    top_right = '8 10 -10'
    bottom_left = '2 8 -10'
  [../]
  [./bottom_r]
    type = BoundingBoxNodeSet
    new_boundary = bottom_r
    top_right = '10 10 -10'
    bottom_left = '8 0 -10'
  [../]
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
    value = 25 # (K) surface temperature at 25 ºC
  [../]
  [./T_bottom]
    type = PresetBC
    variable = temperature
    boundary = back
    value = 50
  [../]
[]

[Materials]
  [./THMaterial_Shale]
    type = GolemMaterialTH
    block = 0
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
  file_base = mesh/mesh_refined
[]

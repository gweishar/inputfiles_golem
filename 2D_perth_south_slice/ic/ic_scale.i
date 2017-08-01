[Mesh]
  type = FileMesh
  file = ../mesh/mesh_fine.msh
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
  initial_heat_capacity_fluid = 4.18e+03
  initial_fluid_viscosity = 0.89
  initial_thermal_conductivity_fluid = 0.65
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
  scaling_uo = scaling
[]

[Variables]
  [./pore_pressure]
    initial_condition = 0.101325
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
[]

[BCs]
  [./p0_top]
    type = DirichletBC
    variable = pore_pressure
    boundary = top
    value = 0.101325
  [../]
  [./T0_top]
    type = DirichletBC
    variable = temperature
    boundary = top
    value = 19
  [../]
  [./T_bottom]
    type = GolemHeatFlowBC
    variable = temperature
    boundary = bottom
    value = 0.03
  [../]
[]

[Materials]
  [./basement]
    type = GolemMaterialTH
    block = 'basement'
    initial_porosity = 0.01
    initial_permeability = 1.0e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
  [../]
  [./cattamarra_Coal_Measures]
    type = GolemMaterialTH
    block = 'coal_layer'
    initial_porosity = 0.1
    initial_permeability = 1.2e-17
    initial_density_solid = 2360
    initial_thermal_conductivity_solid = 4.1
    initial_heat_capacity_solid = 1000
    T_source_sink = 5e-07
    fluid_modulus = 142857142.9
  [../]
  [./west_block] # lesueur_Ss
    type = GolemMaterialTH
    block = 'west_block'
    initial_porosity = 0.04
    initial_permeability = 1.3e-16
    initial_density_solid = 2650
    initial_thermal_conductivity_solid = 3.85
    initial_heat_capacity_solid = 775
    T_source_sink = 6e-07
    fluid_modulus = 142857142.9
  [../]
  [./aquifer_near_surface] # superficial aquifer in doc
    type = GolemMaterialTH
    block = 'aquifer_near_surface'
    initial_porosity = 0.3
    initial_permeability = 1.2e-12
    initial_density_solid = 2100
    initial_thermal_conductivity_solid = 1.6
    #initial_thermal_conductivity_fluid = 3.2 #calculated by hand
    initial_heat_capacity_solid = 800
    T_source_sink = 6e-07
    fluid_modulus = 285714285.7
  [../]
  [./surface_layers] #neocomian uncorformity
    type = GolemMaterialTH
    block = 'surface_layers'
    initial_porosity = 0.1
    initial_permeability = 1.2e-12
    initial_density_solid = 2360
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    fluid_modulus = 142857142.9
  [../]
  [./aquifer_subsurface] # Yarragadee
    type = GolemMaterialTH
    block = 'aquifer_subsurface'
    initial_porosity = 0.2
    initial_permeability = 1.2e-13
    initial_density_solid = 2180
    initial_thermal_conductivity_solid = 4.3
    initial_thermal_conductivity_fluid = 3.2 #calculated by hand
    initial_heat_capacity_solid = 775
    T_source_sink = 6e-07
    fluid_modulus = 142857142.9
  [../]
  [./moho] # lower crust aka yilgarn
    type = GolemMaterialTH
    block = 'moho'
    initial_porosity = 0.01
    initial_permeability = 1.2e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    fluid_modulus = 14285714.29
  [../]
  #[./faults]
  #  block = 'fault1 fault2 fault3 fault4 fault5 fault6'
  #  material_type = frac
  #  initial_scaling_factor = 1.0
  #  initial_permeability = 1e-10
  #  initial_porosity = 1.0
  #  initial_density_solid = 2717.0
  #  initial_thermal_conductivity_solid = 2.4
  #  initial_heat_capacity_solid = 755.0
  #  fluid_modulus = 2.5e+9
  #[../]
[]

[UserObjects]
  [./scaling]
    type = GolemScaling
    characteristic_time = 1.0
    characteristic_length = 1.0
    characteristic_temperature = 1.0
    characteristic_stress = 1.0e+06
  [../]
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
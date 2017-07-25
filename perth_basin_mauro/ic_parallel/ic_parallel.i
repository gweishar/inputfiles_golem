[Mesh]
  type = FileMesh
  file = ../mesh/mesh.e
  nemesis = true
  boundary_id = '0 1 2 3 4 5'
  boundary_name = 'back bottom right top left front'
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  #has_lumped_mass_matrix = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
  initial_heat_capacity_fluid = 4.18e+03
  initial_fluid_viscosity = 0.89
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
  #[./T_adv]
  #  type = GolemKernelTH
  #  variable = temperature
  #[../]
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
  [./basement]
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
  #[./middle_sup_aquifer]
  #  type = GolemMaterialTH
  #  block = 1
  #  initial_porosity = 0.3
  #  initial_permeability = 1.2e-11
  #  initial_density_solid = 2100
  #  initial_thermal_conductivity_solid = 1.6
  #  initial_heat_capacity_solid = 800
  #  T_source_sink = 2.5e-07
  #  output_properties = 'fluid_density fluid_viscosity'
  #  outputs = out
  #[../]
  #[./South_Perth_Shale]
  #  type = GolemMaterialTH
  #  block = 2
  #  initial_porosity = 0.1
  #  initial_permeability = 1.0e-11
  #  initial_density_solid = 2100
  #  initial_thermal_conductivity_solid = 1.8
  #  initial_thermal_conductivity_fluid = 1.5
  #  initial_heat_capacity_solid = 1000
  #  T_source_sink = 8e-07
  #  output_properties = 'fluid_density fluid_viscosity'
  #  outputs = out
  #[../]
  [./cattamarra_Coal_Measures]
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
  [./defaultCover] #CHECK VALUES
    type = GolemMaterialTH
    block = 2
    initial_porosity = 0.1
    initial_permeability = 1.2e-12
    initial_density_solid = 2360
    initial_thermal_conductivity_solid = 3.73
    initial_heat_capacity_solid = 1000
    T_source_sink = 4e-06
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./eneabba_Fm]
    type = GolemMaterialTH
    block = 3
    initial_porosity = 0.06
    initial_permeability = 1.2e-13
    initial_density_solid = 2520
    initial_thermal_conductivity_solid = 2.75
    initial_heat_capacity_solid = 775
    T_source_sink = 6e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./kockatea_Shale]
    type = GolemMaterialTH
    block = 4
    initial_porosity = 0.12
    initial_permeability = 1.5e-15
    initial_density_solid = 2650
    initial_thermal_conductivity_solid = 2.29
    initial_heat_capacity_solid = 900
    T_source_sink = 1.5e-06
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./late_Permian]
    type = GolemMaterialTH
    block = 5
    initial_porosity = 0.05
    initial_permeability = 1.2e-14
    initial_density_solid = 2650
    initial_thermal_conductivity_solid = 3.13
    initial_heat_capacity_solid = 900
    T_source_sink = 5e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./lesueur_Ss]
    type = GolemMaterialTH
    block = 6
    initial_porosity = 0.04
    initial_permeability = 1.3e-16
    initial_density_solid = 2650
    initial_thermal_conductivity_solid = 3.85
    initial_heat_capacity_solid = 775
    T_source_sink = 6e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./neocomian_Unc] #CHECK THESE VALUES
    type = GolemMaterialTH
    block = 7
    initial_porosity = 0.1
    initial_permeability = 1.2e-12
    initial_density_solid = 2360
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./topo_and_bathy] # CHECK THESE VALUES
    type = GolemMaterialTH
    block = 8
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
  [./woodada_Fm]
    type = GolemMaterialTH
    block = 9
    initial_porosity = 0.04
    initial_permeability = 1.3e-16
    initial_density_solid = 2180
    initial_thermal_conductivity_solid = 2.88
    initial_heat_capacity_solid = 775
    T_source_sink = 1.5e-06
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./yarragadee_Fm]
    type = GolemMaterialTH
    block = 10
    initial_porosity = 0.2
    initial_permeability = 1.2e-13
    initial_density_solid = 2180
    initial_thermal_conductivity_solid = 4.3
    initial_thermal_conductivity_fluid = 3.2 #calculated by hand
    initial_heat_capacity_solid = 775
    T_source_sink = 6e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./yigarn]
    type = GolemMaterialTH
    block = 11
    initial_porosity = 0.2
    initial_permeability = 1.2e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
  [../]
  [./out] #CHECK VALUES
    type = GolemMaterialTH
    block = 12
    initial_porosity = 0.1
    initial_permeability = 1.0e-6
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 12
    initial_heat_capacity_solid = 775
    T_source_sink = 4e-07
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
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
    type = Nemesis
  [../]
  [./console]
    type = Console
    perf_log = true
    output_linear = false
    output_nonlinear = true
  [../]
[]

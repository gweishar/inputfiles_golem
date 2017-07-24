####  Golem Simple Geomodel ####

[Mesh]
  type = FileMesh
  file = ic_parallel/ic_parallel_out.e
  nemesis = true
  boundary_id = '0 1 2 3 4 5'
  boundary_name = 'back bottom right top left front'
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  has_T_source_sink = true
  has_lumped_mass_matrix = true
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
  scaling_uo = scaling
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
  #[./entropy_production]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
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
 # [./entropy_production]
 #  type = EntropyProduction
 #  variable = entropy_production
 #  execute_on = timestep_end
 #  temp = temperature
 #[../]
[]

[BCs]
  [./p0_top]
    type = PresetBC
    variable = pore_pressure
    boundary = front
    value = 0.101325
  [../]
  [./T0_top]
    type = PresetBC
    variable = temperature
    boundary = front
    value = 19
  [../]
  [./T_bottom]
    type = GolemHeatFlowBC
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
    fluid_modulus = 14285714.29
  [../]
  [./cattamarra_Coal_Measures]
    type = GolemMaterialTH
    block = 1
    initial_porosity = 0.1
    initial_permeability = 1.2e-17
    initial_density_solid = 2360
    initial_thermal_conductivity_solid = 4.1
    initial_heat_capacity_solid = 1000
    T_source_sink = 5e-07
    fluid_modulus = 142857142.9
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
    fluid_modulus = 142857142.9
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
    fluid_modulus = 85714285.71
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
    fluid_modulus = 171428571.4
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
    fluid_modulus = 71428571.43
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
    fluid_modulus = 57142857.14
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
    fluid_modulus = 142857142.9
  [../]
  [./topo_and_bathy] # CHECK THESE VALUES
    type = GolemMaterialTH
    block = 8
    initial_porosity = 0.01
    initial_permeability = 1.0e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    #initial_thermal_conductivity_fluid = 3.2 #calculated by hand
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    fluid_modulus = 14285714.29
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
    fluid_modulus = 57142857.14
  [../]
  [./yarragadee_Fm]
    type = GolemMaterialTH
    block = 10
    initial_porosity = 0.2
    initial_permeability = 1.2e-13
    initial_density_solid = 2180
    initial_thermal_conductivity_solid = 4.3
    #initial_thermal_conductivity_fluid = 3.2 #calculated by hand
    initial_heat_capacity_solid = 775
    T_source_sink = 6e-07
    fluid_modulus = 285714285.7
  [../]
  [./yilgarn]
    type = GolemMaterialTH
    block = 11
    initial_porosity = 0.01
    initial_permeability = 1.2e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    fluid_modulus = 14285714.29
  [../]
  [./out_material] #CHECK VALUES
    type = GolemMaterialTH
    block = 12
    initial_porosity = 0.01
    initial_permeability = 1.2e-18
    initial_density_solid = 2700
    initial_thermal_conductivity_solid = 3.2
    initial_heat_capacity_solid = 980
    T_source_sink = 4e-06
    fluid_modulus = 14285714.29
  [../]
[]

[UserObjects]
  [./scaling]
    type = GolemScaling
    characteristic_time = 3.15576e+07
    characteristic_length = 1.0
    characteristic_temperature = 1.0
    characteristic_stress = 1.0e+06
  [../]
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
                              1.0e-04 0 1000' # basic instead of linesearch cp
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
  num_steps  = 10000
  dt = 1 # 1 year
[]

[Outputs]
  [./out]
    type = Exodus
    interval = 10
    #file_base = transient_parallel
  [../]
  [./console]
    type = Console
    perf_log = true
    output_linear = false
    output_nonlinear = true
  [../]
[]

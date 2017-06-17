# Set up for the Elder problem
[Mesh]
  file = mesh/ic_cor_12.e
[]

[MeshModifiers]
  [./refine_domain]
    type = SubdomainBoundingBox
    location = inside
    bottom_left = '-250 -75 0'
    top_right = '250 75 0'
    block_id = 0
  [../]
[]

[Variables]
  [./pore_pressure]
    initial_from_file_var = pore_pressure
    initial_from_file_timestep = 2
  [../]
  [./temperature]
    initial_condition = 12
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

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_density_coupling = true
  has_gravity = true
  density_type = 'EOS' # MooseEnum("constant=1 EOS=2");
  viscosity_type = 'EOS' # MooseEnum("constant=1 EOS=2");
  gravity_acceleration = 9.80665
[]

[BCs]
  [./p_top_left]
    type = PresetBC
    variable = pore_pressure
    boundary = line_tl
    value = 101325
  [../]
  [./p_top_middle]
    type = PresetBC
    variable = pore_pressure
    boundary = line_tm
    value = 101325
  [../]
  [./p_top_right]
    type = PresetBC
    variable = pore_pressure
    boundary = line_tr
    value = 101325
  [../]
  [./T_top_left]
    type = PresetBC
    variable = temperature
    boundary = line_tl
    value =  12
  [../]
  [./T_top_middle]
    type = PresetBC
    variable = temperature
    boundary = line_tm
    value = 12
  [../]
  [./T_top_right]
    type = PresetBC
    variable = temperature
    boundary = line_tr
    value =  12
  [../]
  [./T_bottom_left]
    type = PresetBC
    variable = temperature
    boundary = line_bl
    value =  12
  [../]
  [./T_bottom_middle]
    type = PresetBC
    variable = temperature
    boundary = line_bm
    value = 20
  [../]
  [./T_bottom_right]
    type = PresetBC
    variable = temperature
    boundary = line_br
    value = 12
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

[AuxKernels]
  [./darcyx]
    type = GolemDarcyVelocity
    variable = vx
    component = 0
    execute_on = timestep_end
  [../]
  [./darcyy]
    type = GolemDarcyVelocity
    variable = vy
    component = 1
    execute_on = timestep_end
  [../]
  [./darcyz]
    type = GolemDarcyVelocity
    variable = vz
    component = 2
    execute_on = timestep_end
  [../]
[]

[Materials]
  [./unit_non_adaptive]
    type = GolemMaterialTH
    block = 'domain'
    initial_density_fluid = 999.526088
    initial_density_solid = 2480
    initial_porosity = 0.4
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 1.233333
    initial_heat_capacity_fluid = 4180
    initial_heat_capacity_solid = 920
    initial_permeability = 1.0e-10
    initial_fluid_viscosity = 0.0012389
    fluid_modulus = 4e+09
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
 [../]
 [./unit_adaptive]
   type = GolemMaterialTH
   block = 0
   initial_density_fluid = 999.526088
   initial_density_solid =2480
   initial_porosity = 0.4
   initial_thermal_conductivity_fluid = 0.65
   initial_thermal_conductivity_solid = 1.233333
   initial_heat_capacity_fluid = 4180
   initial_heat_capacity_solid = 920
   initial_permeability = 1.0e-10
   initial_fluid_viscosity = 0.0012389
   fluid_modulus = 4e+09
   output_properties = 'fluid_density fluid_viscosity'
   outputs = out
[../]
[]

[Preconditioning]
  [./FSP]
    type = FSP
    topsplit = 'pT'
     [./pT]
       splitting = 'p T'
       splitting_type = multiplicative
       #petsc_options = '-snes_monitor -snes_linesearch_monitor -snes_converged_reason'
       petsc_options_iname = '-ksp_type
                              -ksp_rtol -ksp_max_it
                              -snes_type -snes_linesearch_type
                              -snes_atol -snes_stol -snes_max_it'
       petsc_options_value = 'fgmres
                              1.0e-12 100
                              newtonls cp
                              1 0 1000'
     [../]
     [./p]
       vars = 'pore_pressure'
       #petsc_options = '-ksp_converged_reason'
       petsc_options_iname = '-ksp_type
                              -pc_type -pc_hypre_type
                              -ksp_rtol -ksp_max_it'
       petsc_options_value = 'preonly
                              hypre boomeramg
                              1.0e-04 500'
     [../]
     [./T]
       vars = 'temperature'
      # petsc_options = '-ksp_converged_reason'
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
  solve_type =  'Newton' #
  num_steps  = 50000
  dt         = 10000
  l_max_its = 250
  nl_max_its = 100
  nl_abs_tol = 1e-05
  nl_rel_tol = 1e-10
[]

[Adaptivity]
  initial_steps = 2
  cycles_per_step = 2
  marker = temperature_marker_fraction
  initial_marker = temperature_marker_fraction
  max_h_level = 10
  [./Indicators]
    [./temperature_jump]
      type = GradientJumpIndicator
      variable = temperature
      scale_by_flux_faces = true
    [../]
  [../]
  [./Markers]
    [./temperature_marker_fraction]
      type = ErrorFractionMarker
      block = 0
      refine = 0.8
      coarsen = 1e-3
      indicator = temperature_jump
    [../]
  [../]
[]

[Outputs]
  file_base = thermal_adaptive_EOS
  interval = 100
  [./out]
    type = Exodus
  [../]
  [./console]
    type = Console
    perf_log = false
    output_linear = true
    output_nonlinear = true
  [../]
[]

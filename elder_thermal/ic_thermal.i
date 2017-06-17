[Mesh]
  type = FileMesh
  file = 'mesh/mesh_ref.msh'
[]

[Variables]
  [./pore_pressure]
    initial_condition = 101325
  [../]
[]

[GlobalParams]
  pore_pressure = pore_pressure
  has_gravity = true
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
[]

[Kernels]
  active = 'darcy'
  [./p_time]
    type = TimeDerivativeKernel
    variable = pore_pressure
  [../]
  [./darcy]
    type = GolemKernelH
    variable = pore_pressure
  [../]
  [./T_time]
    type = TimeDerivativeKernel
    variable = temperature
  [../]
  [./T_dif]
    type = TKernel
    variable = temperature
  [../]
  [./T_adv]
    type = THKernel
    variable = temperature
	  is_conservative = true
  [../]
[]

[Materials]
  [./unit]
    type = GolemMaterialH
    block = domain
    initial_density_fluid = 999.526088
    initial_density_solid =2480
    initial_porosity = 0.4
    #ininital_thermal_conductivity_fluid = 0.65
    #initial_thermal_conductivity_solid = 1.233333
    #heat_capacity_fluid = 4180
    #heat_capacity_solid = 920
    initial_permeability = 1.0e-10
    initial_fluid_viscosity = 0.0012389
    fluid_modulus = 4e+09
    porosity_uo = porosity
    fluid_density_uo = fluid_density
    fluid_viscosity_uo = fluid_viscosity
    permeability_uo = permeability
  [../]

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
  solve_type = 'PJFNK' # default = PJFNK | NEWTON
  petsc_options_iname = '-pc_type -pc_hypre_type
                         -ksp_gmres_restart -snes_ls
                         -pc_hypre_boomeramg_strong_threshold'
  petsc_options_value = 'hypre boomeramg 201 cubic 0.7'
  l_max_its  = 400
  l_tol      = 1e-12
  nl_max_its = 15
  nl_rel_tol = 1e-5
  nl_abs_tol = 1e-7
[]

[Outputs]
  print_linear_residuals = true
  print_perf_log = true
  file_base      = ic_thermal
  exodus         = true
  #[./console]
  #  type = Console
  #  perf_log = false
  #  output_linear = true
  #  output_nonlinear = true
  #[../]
[]

[Debug]
  show_var_residual_norms = true
[]

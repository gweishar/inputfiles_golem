[Mesh]
  type = FileMesh
  file = ../mesh/mesh_ref.msh
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
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
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
    type = HKernel
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
    type = THMaterial
    block = domain
    initial_density_fluid = 999.526088
    initial_density_solid = 2480
    initial_porosity = 0.4
    thermal_conductivity_fluid = 0.65
    thermal_conductivity_solid = 1.233333
    heat_capacity_fluid = 4180
    heat_capacity_solid = 920
    initial_permeability = 1.0e-10
    fluid_viscosity = 0.0012389
    fluid_modulus = 4e+09
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
[./peremeability]
  type = GolemPermeabilityConstant
[../]

[]

[Preconditioning]
  [./ASM]
    type = SMP
    full = true
    petsc_options = '-snes_ksp_ew'
    petsc_options_iname = '-ksp_type
                           -pc_type
                           -snes_atol -snes_rtol -snes_max_it
                           -ksp_max_it
                           -sub_pc_type -sub_pc_factor_shift_type'
    petsc_options_value = 'gmres
                           asm
                           1e-10 1e-10 200
                           500
                           lu NONZERO'
  [../]
  [./HYPRE]
    type = SMP
    full = true
    petsc_options = '-snes_ksp_ew'
    petsc_options_iname = '-ksp_type
                           -pc_type -pc_hypre_type
                           -snes_atol -snes_rtol -snes_max_it
                           -ksp_gmres_restart
                           -ksp_max_it
                           -sub_pc_type -sub_pc_factor_shift_type
                           -snes_ls
                           -pc_hypre_boomeramg_strong_threshold'
    petsc_options_value = 'gmres
                           hypre boomeramg
                           1e-10 1e-10 200
                           201
                           500
                           lu NONZERO
                           cubic
                           0.7'
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'PJFNK' # 'NEWTON'
  l_max_its  = 400
  l_tol      = 1e-12
  nl_max_its = 15
  nl_rel_tol = 1e-5
  nl_abs_tol = 1e-7
[]

[Outputs]
  print_linear_residuals = true
  print_perf_log = true
  exodus         = true
[]

[Debug]
  show_var_residual_norms = true
[]

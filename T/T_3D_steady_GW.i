[Mesh]
  file='ic.e'
[]

[Variables]
  [./temperature]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./TKernel]
    type = GolemKernelT
    variable = temperature
  [../]
[]

[BCs]
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
[]

[Materials]
  [./thermal]
    type = GolemMaterialT
    block = 0
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 6.27
    porosity_uo = porosity
  [../]
[]

[UserObjects]
  [./porosity]
    type = GolemPorosityConstant
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
  print_linear_residuals = true
  print_perf_log = true
  exodus = true
[]

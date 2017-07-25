[Mesh]
  file= ../mesh/mesh_small.e
[]

[Variables]
  [./pore_pressure]
    initial_condition = 101325
  [../]
  [./temperature]
    initial_condition = 19
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
  temperature = temperature
[]

[BCs]
  [./p_top]
    type = PresetBC
    variable = pore_pressure
    boundary = top
    value = 101325
  [../]
  [./T_top]
    type = PresetBC
    variable = temperature
    boundary = top
    value =  19
  [../]
  [./T_bottom]
    type = PresetBC
    variable = temperature
    boundary = bottom
    value = 50
  [../]
[]

[Kernels]
  [./darcy]
    type = GolemKernelH
    variable = pore_pressure
  [../]
  [./T_cond]
    type = GolemKernelT
    variable = temperature
  [../]
[]

[Materials]
  [./unit_non_adaptive]
    type = GolemMaterialTH
    block = 0
    initial_density_fluid = 999.526088
    initial_density_solid = 2480
    initial_porosity = 0.1
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 2.7 # was 2.7 before
    initial_heat_capacity_fluid = 4180
    initial_heat_capacity_solid = 920
    initial_permeability = 2.0e-13
    initial_fluid_viscosity = 0.0012389
    fluid_modulus = 14285714.29
    # fluid_modulus = 14285.71429
    # output_properties = 'fluid_density fluid_viscosity'
    # outputs = out
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
  active = 'HYPRE'
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
  solve_type = 'NEWTON'
[]

[Outputs]
  print_linear_residuals = true
  print_perf_log = true
  exodus         = true
[]

[Debug]
  show_var_residual_norms = true
[]

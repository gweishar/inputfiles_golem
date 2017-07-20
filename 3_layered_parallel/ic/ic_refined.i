[Mesh]
  type = FileMesh
  file = ../mesh/mesh_refined.e
  boundary_id =  '1 2 3 4 5 6'
  boundary_name = 'back front left right bottom top'
[]

[GlobalParams]
  pore_pressure = pore_pressure
  has_gravity = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
  initial_fluid_viscosity = 1.0e-03
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
[]

[Variables]
  [./pore_pressure]
    initial_condition = 101325
  [../]
[]


[Kernels]
  [./darcy]
    type = GolemKernelH
    variable = pore_pressure
  [../]
[]

[BCs]
  [./p0_top]
    type = PresetBC
    variable = pore_pressure
    boundary = front
    value = 101325
  [../]
[]

[Materials]
  [./middle]
    type = GolemMaterialH
    block = 0
    initial_porosity = 0.21
    initial_permeability = 3.0e-14
    initial_density_solid = 2650
    fluid_modulus = 14285714.29
  [../]
  [./bottom]
    type = GolemMaterialH
    block = 1
    initial_porosity = 0.2
    initial_permeability = 3.0e-14
    initial_density_solid = 2360
    fluid_modulus = 14285714.29
  [../]
  [./top]
    type = GolemMaterialH
    block = 2
    initial_porosity = 0.15
    initial_permeability = 3.0e-14
    initial_density_solid = 2650
    fluid_modulus = 14285714.29
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

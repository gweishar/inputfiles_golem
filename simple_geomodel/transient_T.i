[Mesh]
  file = ic/ic_out.e
[]

#[GlobalParams]
#  temperature = temperature
#  has_gravity = true
#  #has_lumped_mass_matrix = true
#  gravity_acceleration = 9.8065
#  initial_density_fluid = 1000.0
#  initial_heat_capacity_fluid = 4.18e+03
#  initial_fluid_viscosity = 1.0e-03
#  initial_thermal_conductivity_fluid = 0.65
#  fluid_density_uo = fluid_density
#  fluid_viscosity_uo = fluid_viscosity
#  porosity_uo = porosity
#  permeability_uo = permeability
#  #supg_uo = supg
#  #scaling_uo = scaling
#[]

[Variables]
  [./temperature]
  [../]
[]

[Kernels]
  [./T_time]
    type = GolemKernelTimeT
    variable = temperature
  [../]
  [./TKernel]
    type = GolemKernelT
    variable = temperature
  [../]
[]


[BCs]
  active = 'T0_top T0_bottom'

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
    value = 100
  [../]
  [./T_bottom_neumann]
    type = NeumannBC
    variable = temperature
    boundary = back
    value = 0.03
  [../]
[]

[Materials]
  [./middle]
    type = GolemMaterialT
    block = 0
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 4.4
    initial_heat_capacity_solid = 790
    initial_density_solid = 2800
    porosity_uo = porosity
    fluid_density_uo = fluid_density
  [../]
  [./bottom]
    type = GolemMaterialT
    block = 1
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 1.2
    initial_heat_capacity_solid = 1000
    initial_density_solid = 2000
    porosity_uo = porosity
    fluid_density_uo = fluid_density
  [../]
  [./top]
    type = GolemMaterialT
    block = 2
    initial_thermal_conductivity_fluid = 0.65
    initial_thermal_conductivity_solid = 0.5
    initial_heat_capacity_solid = 1000
    initial_density_solid = 2000
    porosity_uo = porosity
    fluid_density_uo = fluid_density
  [../]
[]

[UserObjects]
  [./porosity]
    type = GolemPorosityConstant
  [../]
  [./fluid_density]
    type = GolemFluidDensityConstant
  [../]
[]

#[Preconditioning]
#  [./precond]
#    type = SMP
#    full = true
#    petsc_options = '-snes_ksp_ew'
#    petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it -ksp_max_it -sub_pc_type -sub_pc_factor_shift_type'
#    petsc_options_value = 'gmres asm 1E-10 1E-10 200 500 lu NONZERO'
#  [../]
#[]

[Executioner]
  type = Transient
  solve_type = Newton
  num_steps  = 100
  dt = 1 # 1 year
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

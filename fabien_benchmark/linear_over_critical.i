[Mesh]
  type = FileMesh
  file = mesh/coarse_in.e
[]

[MeshModifiers]
  [./POINT0]
    type = AddExtraNodeset
    new_boundary = 'point_0'
    coord = '0.0 -5500.0 0.0'
  [../]
  [./POINT1]
    type = AddExtraNodeset
    new_boundary = 'point_1'
    coord = '5500.0 -5500.0 0.0'
  [../]
  [./POINT2]
    type = AddExtraNodeset
    new_boundary = 'point_2'
    coord = '5500.0 0.0 0.0'
  [../]
  [./POINT3]
    type = AddExtraNodeset
    new_boundary = 'point_3'
    coord = '0.0 0.0 0.0'
  [../]
[]

[Variables]
  [./pore_pressure]
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
  [./entropy_production]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  gravity_acceleration = 9.8065
  #has_lumped_mass_matrix = true
  # fluid properties
  initial_density_fluid = 1022.4
  initial_fluid_viscosity = 1.17e-3
  initial_thermal_conductivity_fluid = 0.65
  initial_heat_capacity_fluid = 4200.0
  # solid properties
  initial_density_solid = 2500.0
  initial_thermal_conductivity_solid = 2.0
  initial_heat_capacity_solid = 1000.0
  # user objects
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
  #supg_uo = supg
[]

[Functions]
  [./P_ic_func]
    type = ParsedFunction
    value = rho*g*z+p
    vars = 'rho g p'
    vals = '1022.4 -9.8065 0.0'
  [../]
  [./T_ic_func_unit]
    type = ParsedFunction
    value = 'a-(b-a)/c*z'
    vars = 'a b c'
    vals = '20 170 5500'
  [../]
  [./T_ic_func_frac]
    type = ParsedFunction
    value = 'a-(b-a)/c*z+sin(pi*z/c)*cos(pi*y/c)'
    vars = 'a b c'
    vals = '20 170 5500'
  [../]
[]

[ICs]
  [./P_ic]
    type = FunctionIC
    variable = pore_pressure
    function = P_ic_func
  [../]
  [./T_unit_ic_1]
     type = FunctionIC
     variable = temperature
     block = 0
     function = T_ic_func_unit
  [../]
  [./T_frac_ic]
     type = FunctionIC
     variable = temperature
     block = 1
     function = T_ic_func_frac
  [../]
[]

[BCs]
  [./p_bc]
    type = PresetBC
    variable = pore_pressure
    boundary = 'point_0 point_1 point_2 point_3'
    value = 0.0
  [../]
  [./T_top]
    type = PresetBC
    variable = temperature
    boundary = top
    value = 20.0
  [../]
  [./T_bottom]
    type = PresetBC
    variable = temperature
    boundary = bottom
    value = 170.0
  [../]
[]

[Kernels]
  [./darcy]
    type = GolemKernelH
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
    block = 1
  [../]
[]

[AuxKernels]
  [./vx_kernel]
    type = GolemFluidVelocity
    variable = vx
    component = 0
    execute_on = timestep_end
  [../]
  [./vy_kernel]
    type = GolemFluidVelocity
    variable = vy
    component = 1
    execute_on = timestep_end
  [../]
  [./vz_kernel]
    type = GolemFluidVelocity
    variable = vz
    component = 2
    execute_on = timestep_end
  [../]
  [./entropy_production]
   type = EntropyProduction
   variable = entropy_production
   execute_on = timestep_end
 [../]
[]

[Materials]
  [./unit]
    type = GolemMaterialTH
    block = 0
    initial_permeability = 1.0e-18
    initial_porosity = 1e-3
    output_properties = 'fluid_density fluid_viscosity'
    outputs = out
 [../]
 [./frac]
   type = GolemMaterialTH
   block = 1
   initial_permeability = 1.019e-13
   initial_porosity = 0.5
   output_properties = 'fluid_density fluid_viscosity'
   outputs = out
[../]
[]

[UserObjects]
  [./fluid_density]
    type = GolemFluidDensityFabien
    Tc = 20
    alpha = 5.91e-4
  [../]
  [./fluid_viscosity]
    type = GolemFluidViscosityFabien
    Tc = 20
    Tv = 62.1
  [../]
  [./porosity]
    type = GolemPorosityConstant
  [../]
  [./permeability]
    type = GolemPermeabilityConstant
  [../]
[]

[Preconditioning]
  active = 'FSP_fabien'
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
                              1e-1 0 1000'
     [../]
     [./H]
       vars = 'pore_pressure'
       petsc_options = '-ksp_converged_reason'
       petsc_options_iname = '-ksp_type
                              -pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold
                              -ksp_rtol -ksp_max_it'
       petsc_options_value = 'preonly
                              hypre boomeramg 0.5
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
  [./FSP_fabien]
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
                              1.0e-3 25
                              newtonls cp
                              1 0 1000'
     [../]
     [./H]
       vars = 'pore_pressure'
      # petsc_options = '-ksp_converged_reason'
       petsc_options_iname = '-ksp_type
                              -pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold
                              -ksp_rtol -ksp_max_it'
       petsc_options_value = 'bcgs
                              hypre boomeramg 1
                              1.0e-04 9000'
     [../]
     [./T]
       vars = 'temperature'
      # petsc_options = '-ksp_converged_reason'
       petsc_options_iname = '-ksp_type
                              -pc_type -sub_pc_type -sub_pc_factor_levels
                              -ksp_rtol -ksp_max_it'
      petsc_options_value = 'bcgs
                             hypre boomeramg 1
                             1.0e-04 9000'
     [../]
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'Newton' # 'PJFNK' #
  start_time = 0.0
  end_time   = 1e13
  dtmin = 1e3
  dtmax = 5e9
  [./TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 15
    iteration_window = 2
    dt = 1e3
  [../]
  abort_on_solve_fail = false
[]

[Outputs]
  [./out]
    type = Exodus
    sync_times = '1e3
                  1e9 5e9
                  1e10 2e10 3e10 4e10 5e10 6e10 7e10 8e10 9e10
                  1e11 2e11 3e11 4e11 5e11 6e11 7e11 8e11 9e11
                  1e12 2e12 3e12 4e12 5e12 6e12 7e12 8e12 9e12 1e13'
    sync_only = true
    elemental_as_nodal = true
  [../]
  [./console]
    type = Console
    perf_log = true
    output_linear = false
    output_nonlinear = true
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]

# Model 2b - Steady state calculation
# with heat conduction only

[Mesh]
  type = FileMesh
  file = mesh/Model_1-2_withMainFaults.e
  boundary_id = '1 2 3 4 5 6'
  boundary_name = 'bottom top back right front left'
[]

[Variables]
  [./pore_pressure]
  [../]
  [./temperature]
  [../]
[]


[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
  initial_thermal_conductivity_fluid = 0.65
  initial_heat_capacity_fluid = 4.18e+03
  initial_fluid_viscosity = 1.0e-03
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
  scaling_uo = scaling
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
[]

[Functions]
  [./func_bc_1]
    type = GolemFunctionBCfromFile
    data_file = base.dat
    interpolate_data_in_time = false
	  interpolate_data_in_space = true
  [../]
  [./func_bc_2]
    type = GolemFunctionBCfromFile
    data_file = surface.dat
    interpolate_data_in_time = false
	  interpolate_data_in_space = true
  [../]
[]

[BCs]
  [./BC_T_base]
    type = FunctionDirichletBC
    function = func_bc_1
    boundary = bottom
    variable = temperature
  [../]
  [./BC_T_surface]
    type = FunctionDirichletBC
    function = func_bc_2
	  boundary = top
    variable = temperature
  [../]
  [./p_top]
	  type = DirichletBC
	  variable = pore_pressure
	  boundary = top
	  value = 0.1 #1.0e+05
  [../]
[]

[Materials]
 [./QuaternaryTertiary]
   type = GolemMaterialTH
   block = 4
   initial_permeability = 7e-14
   initial_porosity = 0.18
   initial_density_solid = 2585.0
   initial_thermal_conductivity_solid = 1.3
   initial_heat_capacity_solid = 860.0
   T_source_sink = 1e-06
 [../]
 [./KeuperLiasDogger]
   type = GolemMaterialTH
   block = 5
   initial_permeability = 4e-16
   initial_porosity = 0.04
   initial_density_solid = 2667.0
   initial_thermal_conductivity_solid = 2.6
   initial_heat_capacity_solid = 800.0
   T_source_sink = 1.6e-06
 [../]
 [./Muschelkalk-PermoCarboniferous]
   type = GolemMaterialTH
   block = 0
   initial_permeability = 2.9e-14
   initial_porosity = 0.08
   initial_density_solid = 2780.0
   initial_thermal_conductivity_solid = 2.9
   initial_heat_capacity_solid = 725.0
   T_source_sink = 1.0e-06
 [../]
 [./UC_MidGermanCrystallineHigh]
   type = GolemMaterialTH
   block = 3
   initial_permeability = 1e-30
   initial_porosity = 0.01
   initial_density_solid = 2717.0
   initial_thermal_conductivity_solid = 2.4
   initial_heat_capacity_solid = 755.0
   T_source_sink = 1.8e-06
 [../]
  [./UC_Saxothuringian]
   type = GolemMaterialTH
   block = 1
   initial_permeability = 1e-30
   initial_porosity = 0.01
   initial_density_solid = 2747.0
   initial_thermal_conductivity_solid = 2.5
   initial_heat_capacity_solid = 900.0
   T_source_sink = 2.5e-06
 [../]
 [./UC_Moldanubian]
   type = GolemMaterialTH
   block = 2
   initial_permeability = 1e-30
   initial_porosity = 0.01
   initial_density_solid = 2707.0
   initial_thermal_conductivity_solid = 2.5
   initial_heat_capacity_solid = 900.0
   T_source_sink = 2.6e-06
 [../]
 [./Fault_MGCH]
   type = GolemMaterialTH
   block = '6 13 14 15 16'
   material_type = frac
   initial_scaling_factor = 1.0
   initial_permeability = 5e-14
   initial_porosity = 1.0
   initial_density_solid = 2717.0
   initial_thermal_conductivity_solid = 2.4
   initial_heat_capacity_solid = 755.0
   T_source_sink = 1.8e-06
 [../]
 [./Fault_SXT]
   type = GolemMaterialTH
   block = '7 8 17 18'
   material_type = frac
   initial_scaling_factor = 1.0
   initial_permeability = 5e-14
   initial_porosity = 1.0
   initial_density_solid = 2747.0
   initial_thermal_conductivity_solid = 2.5
   initial_heat_capacity_solid = 900.0
   T_source_sink = 2.5e-06
 [../]
  [./Fault_MOL]
   type = GolemMaterialTH
   block = '9 10 11 12 19'
   material_type = frac
   initial_scaling_factor = 1.0
   initial_permeability = 5e-14
   initial_porosity = 1.0
   initial_density_solid = 2707.0
   initial_thermal_conductivity_solid = 2.5
   initial_heat_capacity_solid = 900.0
   T_source_sink = 2.6e-06
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
  [./scaling]
    type = GolemScaling
    characteristic_time = 3.15576e+07 # 1 year
    characteristic_length = 1.0
    characteristic_temperature = 1.0
    characteristic_stress = 1.0e+06
  [../]
[]


[Preconditioning]
  [./FSP]
    type = FSP
    topsplit = 'pT'
     [./pT]
       splitting = 'p T'
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
                              1 0 1000'
     [../]
     [./p]
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
                              -pc_type
                              -sub_pc_type -sub_pc_factor_levels
                              -ksp_rtol -ksp_max_it'
       petsc_options_value = 'fgmres
                              asm
                              ilu 1
                              1.0e-04 500'
     [../]
 [../]
[]

[Executioner]
  type = Steady
  solve_type = Newton
[]

[Outputs]
  print_linear_residuals = false
  print_perf_log = true
  exodus = true
[]

[Debug]
  show_var_residual_norms = true
[]

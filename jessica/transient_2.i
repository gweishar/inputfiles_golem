[Mesh]
  file = transient_1_out.e
  #boundary_name = 'bottom top west east south north'
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

[VectorPostprocessors]
  [./point_sample]
    type = PointValueSampler
    variable = 'temperature'
    points = '399421.57 5365483.48 -1425.6  399421.57 5365483.48 -1446.3  399421.57 5365483.48 -49  399421.57 5365483.48 -249  400010.4 5371799.56 -1588  401105.83 5366177.2 -957  403454.88 5406502.57 -1426  403454.88 5406502.57 -1626  403454.88 5406502.57 -1820.5  403764.18 5406595.56 -229  403792.62 5406803.82 -294.6  405964.82 5383898.63 -1961.05  405964.82 5383898.63 -2235.2  405964.82 5383898.63 -936.8  405964.82 5383898.63 -680.5  405964.82 5383898.63 -1361.45  405964.82 5383898.63 -1596  405964.82 5383898.63 -1724  407192.18 5371525.45 -991.4  407192.18 5371525.45 -1068  407192.18 5371525.45 -1376.1  407192.18 5371525.45 -449.1  407192.18 5371525.45 -300.87  407330.54 5370479.52 -1616.2  407330.54 5370479.52 -885.2  407330.54 5370479.52 -987.1  407330.54 5370479.52 -856.75  407330.54 5370479.52 -1389.4  407330.54 5370479.52 -1412.9  407330.54 5370479.52 -95  407330.54 5370479.52 -180.5  407330.54 5370479.52 -280.8  407330.54 5370479.52 -287.5  407375.59 5371079.69 -1506.35  407375.59 5371079.69 -1506.95  407428.53 5372076.57 -444.05  407645.76 5408679.71 -1052  407645.76 5408679.71 -1051  407653.96 5373819.9 -1408  409514.81 5421493.86 -1577.3  410532.55 5421234.16 -1194.3  411565.9 5413842.96 -740.4  412218.16 5409086.29 -656  412639.58 5413100.38 -794  412639.58 5413100.38 -583  413504.5 5422414.38 -2053.2  413810.18 5421785.1 -779.5  414335.64 5424095.99 -279  415608.3 5420016.39 -1026  415608.3 5420016.39 -1226  415677.83 5420094.27 -1216.45  415677.83 5420094.27 -1816.45  415804.46 5423449.01 -324  416139.69 5421117.2 -2805.08  416139.69 5421117.2 -3805.08  416788.18 5420120.4 -2818.98  416788.18 5420120.4 -3818.98  416881.96 5421270.34 -109.75  416881.96 5421270.34 -127.1  416881.96 5421270.34 -173.9  416881.96 5421270.34 -179.15  416881.96 5421270.34 -193.4  416881.96 5421270.34 -57.5  416881.96 5421270.34 -313.15  416881.96 5421270.34 -338.85  416881.96 5421270.34 -4769.49  417006.03 5420766.29 -1216.83  417006.03 5420766.29 -816.83  417006.03 5420766.29 -4835.61  417006.03 5420766.29 -1816.83  417057.31 5420032.32 -344  417061.86 5420423.4 -1219.35  417061.86 5420423.4 -1219.35  417061.86 5420423.4 -1219.35  417061.86 5420423.4 -819.35  417061.86 5420423.4 -819.35  417061.86 5420423.4 -1819.35  417061.86 5420423.4 -2009.48  417061.86 5420423.4 -1819.35  417061.86 5420423.4 -3358.35  417061.86 5420423.4 -1819.35  417061.86 5420423.4 -1402.85  417068.24 5420954.5 -544  417068.24 5420954.5 -701  417068.24 5420954.5 -713  417068.24 5420954.5 -810.25  417147 5420987.88 -1029  417147 5420987.88 -1229  417147 5420987.88 -629  417147 5420987.88 -829  417147 5420987.88 -429  417147 5420987.88 5.4  417147 5420987.88 -144.6  417177.67 5420824.62 -725.9  417207.82 5420711.55 -426  417213.69 5420891.74 -710  417213.69 5420891.74 -388.85  417217 5421041.96 -818.04  417224.01 5421121.58 -1194.6  417224.01 5421121.58 -989.9  417224.01 5421121.58 -594.6  417224.01 5421121.58 -744.6  417224.01 5421121.58 -709.9  417224.01 5421121.58 -894.6  417224.01 5421121.58 -444.6  417240.61 5420628.32 -26  417240.61 5420628.32 -226  417253.44 5421113.95 -725.4  417253.44 5421113.95 -1332.58  417253.44 5421113.95 -1476.55  417258.53 5420541.16 -626  417258.53 5420541.16 -826  417262.97 5421108.13 -363.8  417388.42 5421497.69 -2818.73  417388.42 5421497.69 -3818.73  417388.42 5421497.69 -4878.73  417676.44 5420449.29 -29  417959.46 5421949.25 -1396.95  422174.75 5411096.63 -715.4  422174.75 5411096.63 -156  422174.75 5411096.63 -456  422825.35 5408321.21 -1172.1  422825.35 5408321.21 -1280.3  422825.35 5408321.21 -1398.75  422825.35 5408321.21 -1443.25  423433.93 5408398.6 -967.6  423594.47 5411012.07 -1691.3  423594.47 5411012.07 -1753.6  423594.47 5411012.07 -979.7  423594.47 5411012.07 -1002.55  423594.47 5411012.07 -1371.2  423846.71 5408692.46 -1092.78  423846.71 5408692.46 -1262  424056.26 5409471.77 -969.28  424056.26 5409471.77 -1005.2  424199.93 5430992.64 -744  424203.24 5409269.49 -674.7  424261.47 5409579.09 -1404.6  424379.92 5409443.13 -1569.15  425236.44 5410616.83 -1335  425236.44 5410616.83 -1106.9  425236.44 5410616.83 -1321.7  425236.44 5410616.83 -1361.7  425236.44 5410616.83 -1392.6  425236.44 5410616.83 -1509.4  425236.44 5410616.83 -1523.8  425236.44 5410616.83 -1551.75  425236.44 5410616.83 -193.45  425236.44 5410616.83 -784.1  425236.44 5410616.83 -2571  426402.84 5420730.52 -790.85  428040.6 5419391.2 -648.8  429289.37 5417262.28 -788.25  429289.37 5417262.28 -840.15  429289.37 5417262.28 -864.2  429289.37 5417262.28 -700.45  429342.59 5419587.04 -711  430164.67 5419122.78 -517  430402.5 5421579.15 -853  430418.07 5412801.01 -729  432545.93 5411887.66 -805.75  432545.93 5411887.66 -869.65  432545.93 5411887.66 -733.1  433243.19 5419888.72 -865  433243.19 5419888.72 -575  435325.24 5422431.27 -1167  437597.4 5423160.79 -938  438629.57 5420416.62 -1266  452475.23 5484723.62 -707.8  452475.23 5484723.62 -1042.8  452475.23 5484723.62 -962.8  453225.02 5484219.76 -695  453225.02 5484219.76 -1512  453225.02 5484219.76 -1857  453225.02 5484219.76 -3009  453225.02 5484219.76 -2908  456307.16 5489470.26 29  456307.16 5489470.26 -11  456307.16 5489470.26 -113  456307.16 5489470.26 -214  456307.16 5489470.26 -315  456307.16 5489470.26 -417  456307.16 5489470.26 -518  456307.16 5489470.26 -619  456307.16 5489470.26 -720  456307.16 5489470.26 -857  456687.05 5490067.09 29  456687.05 5490067.09 -11  456687.05 5490067.09 -113  456687.05 5490067.09 -214  456687.05 5490067.09 -315  456687.05 5490067.09 -417  456687.05 5490067.09 -518  456687.05 5490067.09 -619  456687.05 5490067.09 -670  457064.95 5489645.21 29.2  457064.95 5489645.21 -112.8  457064.95 5489645.21 -314.8  457064.95 5489645.21 -517.8  457064.95 5489645.21 -719.8  457064.95 5489645.21 -899.8  441228.36	5403791.85	103.76  441228.36	5403791.85	78.76  441228.36	5403791.85	53.76  441228.36	5403791.85	28.76  441228.36	5403791.85	-21.24  441228.36	5403791.85	-71.24  441228.36	5403791.85	-121.24  441228.36	5403791.85	-171.24  441228.36	5403791.85	-221.24  441228.36	5403791.85	-271.24  441228.36	5403791.85	-321.24  441228.36	5403791.85	-371.24  441228.36	5403791.85	-421.24  441228.36	5403791.85	-471.24  441228.36	5403791.85	-521.24  441228.36	5403791.85	-571.24  441228.36	5403791.85	-621.24  441228.36	5403791.85	-671.24  441228.36	5403791.85	-771.24  441228.36	5403791.85	-821.24  441228.36	5403791.85	-871.24  441228.36	5403791.85	-921.24  441228.36	5403791.85	-971.24  441228.36	5403791.85	-1021.24  441228.36	5403791.85	-1071.24  441228.36	5403791.85	-1121.24  441228.36	5403791.85	-1171.24  441228.36	5403791.85	-1221.24  441228.36	5403791.85	-1271.24  441228.36	5403791.85	-1321.24  441228.36	5403791.85	-1371.24  469516.49	5442734.67	30.45  469516.49	5442734.67	-45.55  469516.49	5442734.67	-54.55  469516.49	5442734.67	-329.55  469516.49	5442734.67	-580.55  469516.49	5442734.67	-849.55  469516.49	5442734.67	-882.55  469516.49	5442734.67	-1062.55  469516.49	5442734.67	-1212.55  469516.49	5442734.67	-1282.55  469516.49	5442734.67	-1579.55  469516.49	5442734.67	-1628.55  469516.49	5442734.67	-1750.55  469516.49	5442734.67	-1759.55  469516.49	5442734.67	-1541.55  468486.16	5441674.84	66.28  468486.16	5441674.84	-42.72  468486.16	5441674.84	-329.72  468486.16	5441674.84	-344.72  468486.16	5441674.84	-604.72  468486.16	5441674.84	-844.72  468486.16	5441674.84	-942.72  468486.16	5441674.84	-985.72  468486.16	5441674.84	-1354.72  468486.16	5441674.84	-1475.72  468486.16	5441674.84	-1607.72  468486.16	5441674.84	-1777.72  468486.16	5441674.84	-2055.72  468486.16	5441674.84	-2117.72  468486.16	5441674.84	-2174.72  468486.16	5441674.84	-2352.72  468486.16	5441674.84	-2426.72  435218.03	5452275.93	-11.89  435218.03	5452275.93	-111.89  435218.03	5452275.93	-311.89  435218.03	5452275.93	-811.89  435218.03	5452275.93	-911.89  437164.49	5456108.83	-107.61  437164.49	5456108.83	-157.61  437164.49	5456108.83	-257.61  437164.49	5456108.83	-357.61  437164.49	5456108.83	-457.61  437164.49	5456108.83	-557.61  437164.49	5456108.83	-657.61  437164.49	5456108.83	-757.61  437164.49	5456108.83	-857.61  437164.49	5456108.83	-957.61  437164.49	5456108.83	-1057.61  437164.49	5456108.83	-1157.61  437164.49	5456108.83	-1207.61  437164.49	5456108.83	-1307.61  437164.49	5456108.83	-1387.61  422213.7 5416546.9 -148.5507246  422213.7 5416546.9 -264.4927536  422213.7 5416546.9 -199.2753623  422213.7 5416546.9 -228.2608696  422213.7 5416546.9 -293.4782609  422213.7 5416546.9 -326.0869565  422213.7 5416546.9 -365.9420290  422213.7 5416546.9 -405.7971014  422213.7 5416546.9 -474.6376812  422213.7 5416546.9 -536.2318841  422213.7 5416546.9 -572.4637681  422213.7 5416546.9 -626.8115942  422213.7 5416546.9 -684.7826087  422213.7 5416546.9 -731.8840580  422213.7 5416546.9 -771.7391304  422213.7 5416546.9 -797.1014493  422213.7 5416546.9 -851.4492754  422213.7 5416546.9 -909.4202899  422213.7 5416546.9 -949.2753623  422213.7 5416546.9 -996.3768116  422213.7 5416546.9 -1039.855072  422213.7 5416546.9 -1068.840580  422213.7 5416546.9 -1105.072464  422213.7 5416546.9 -1148.550725  422213.7 5416546.9 -1202.898551  422213.7 5416546.9 -1257.246377  422213.7 5416546.9 -1177.536232  422213.7 5416546.9 -1286.231884  422213.7 5416546.9 -1326.086957  422213.7 5416546.9 -1384.057971  422213.7 5416546.9 -1420.289855  422213.7 5416546.9 -1449.275362  422213.7 5416546.9 -442.0289855  422213.7 5416546.9 -1492.753623  422213.7 5416546.9 -1536.231884  422213.7 5416546.9 -1579.710145  422213.7 5416546.9 -1630.434783  422213.7 5416546.9 -1663.043478  422213.7 5416546.9 -1692.028986  422213.7 5416546.9 -1731.884058  422213.7 5416546.9 -1750.000000  422213.7 5416546.9 -1771.739130  422213.7 5416546.9 -1826.086957  422213.7 5416546.9 -1880.434783  422213.7 5416546.9 -1945.652174  422213.7 5416546.9 -2003.623188  422213.7 5416546.9 -2076.086957  422213.7 5416546.9 -2126.811594  422213.7 5416546.9 -2184.782609  422213.7 5416546.9 -2246.376812  422213.7 5416546.9 -2300.724638  422213.7 5416546.9 -2347.826087  422213.7 5416546.9 -2380.434783  422213.7 5416546.9 -2438.405797  422213.7 5416546.9 -2521.739130'
    sort_by = x
  [../]
[]

[GlobalParams]
  pore_pressure = pore_pressure
  temperature = temperature
  has_gravity = true
  has_lumped_mass_matrix = true
  gravity_acceleration = 9.8065
  initial_density_fluid = 1000.0
  initial_thermal_conductivity_fluid = 0.65
  initial_heat_capacity_fluid = 4.18e+03
  initial_fluid_viscosity = 1.0e-03
  fluid_density_uo = fluid_density
  fluid_viscosity_uo = fluid_viscosity
  porosity_uo = porosity
  permeability_uo = permeability
  supg_uo = supg
  scaling_uo = scaling
[]

[Kernels]
  [./P_time]
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
  [./T_dif]
    type = GolemKernelT
    variable = temperature
  [../]
  [./T_adv]
    type = GolemKernelTH
    variable = temperature
    #block = 'Quarternary_Rift_19_TETRA Quarternary_Rift_37_WEDGE Quarternary_Rift_55_HEX Quarternary_Rift_70_HEX
    #         Tertiary_Rift_20_TETRA Tertiary_Rift_38_WEDGE Tertiary_Rift_71_HEX Tertiary_Rift_56_HEX Tertiary_East_30_WEDGE Tertiary_East_48_HEX
    #         Keuper_Rift_22_TETRA Keuper_Rift_40_WEDGE Keuper_Rift_58_HEX Keuper_Rift_73_HEX Keuper_East_31_WEDGE Keuper_East_49_HEX Keuper_West_13_TETRA Keuper_West_28_WEDGE Keuper_West_46_HEX Keuper_West_64_HEX
    #         Muschelkalk_Rift_21_TETRA Muschelkalk_Rift_39_WEDGE Muschelkalk_Rift_57_HEX Muschelkalk_Rift_72_HEX Muschelkalk_East_33_WEDGE Muschelkalk_East_51_HEX Muschelkalk_West_12_TETRA Muschelkalk_West_27_WEDGE Muschelkalk_West_45_HEX Muschelkalk_West_63_HEX
    #         Buntsandstein_Rift_23_TETRA Buntsandstein_Rift_41_WEDGE Buntsandstein_Rift_59_HEX Buntsandstein_Rift_74_HEX Buntsandstein_East_14_TETRA Buntsandstein_East_29_WEDGE Buntsandstein_East_47_HEX Buntsandstein_East_65_HEX Buntsandstein_West_11_TETRA Buntsandstein_West_26_WEDGE Buntsandstein_West_44_HEX Buntsandstein_West_62_HEX
    #         PermoCarbon_Rift_24_TETRA PermoCarbon_Rift_42_WEDGE PermoCarbon_Rift_60_HEX PermoCarbon_Rift_75_HEX PermoCarbon_East_15_TETRA PermoCarbon_East_32_WEDGE PermoCarbon_East_50_HEX PermoCarbon_East_66_HEX PermoCarbon_West_10_TETRA PermoCarbon_West_25_WEDGE PermoCarbon_West_43_HEX PermoCarbon_West_61_HEX'
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
[]

[Functions]
  [./temperature_base]
    type = GolemFunctionBCFromFile
    data_file = base.dat
    interpolate_data_in_time = false
	  interpolate_data_in_space = true
  [../]
  [./temperature_top]
    type = GolemFunctionBCFromFile
    data_file = surface.dat
    interpolate_data_in_time = false
	  interpolate_data_in_space = true
  [../]
[]

[BCs]
  [./temperature_base]
    type = FunctionDirichletBC
    function = temperature_base
    boundary = bottom
    variable = temperature
  [../]
  [./temperature_top]
    type = FunctionDirichletBC
    function = temperature_top
	  boundary = top
    variable = temperature
  [../]
  [./p_top]
	  type = DirichletBC
	  variable = pore_pressure
	  boundary = top
	  value = 0.1
  [../]
[]


[Materials]
  [./Quaternary_Rift]
    type = GolemMaterialTH
    block = 'Quarternary_Rift_19_TETRA Quarternary_Rift_37_WEDGE Quarternary_Rift_55_HEX Quarternary_Rift_70_HEX'
    initial_permeability = 7e-14
    initial_porosity = 0.35
    initial_density_solid = 3000.0
    initial_thermal_conductivity_solid = 1.5
    initial_heat_capacity_solid = 850.0
    T_source_sink = 1e-06
    fluid_modulus = 3.5e+9
  [../]
  [./Tertiary_Rift_East]
    type = GolemMaterialTH
    block = 'Tertiary_Rift_20_TETRA Tertiary_Rift_38_WEDGE Tertiary_Rift_71_HEX Tertiary_Rift_56_HEX
             Tertiary_East_30_WEDGE Tertiary_East_48_HEX'
    initial_permeability = 7e-14
    initial_porosity = 0.18
    initial_density_solid = 2585.0
    initial_thermal_conductivity_solid = 1.3
    initial_heat_capacity_solid = 860.0
    T_source_sink = 1e-06
    fluid_modulus = 1.8e+9
  [../]
  [./KeuperLiasDogger_Rift_East_West]
    type = GolemMaterialTH
    block = 'Keuper_Rift_22_TETRA Keuper_Rift_40_WEDGE Keuper_Rift_58_HEX Keuper_Rift_73_HEX
             Keuper_East_31_WEDGE Keuper_East_49_HEX
             Keuper_West_13_TETRA Keuper_West_28_WEDGE Keuper_West_46_HEX Keuper_West_64_HEX'
    initial_permeability = 4e-16
    initial_porosity = 0.04
    initial_density_solid = 2667.0
    initial_thermal_conductivity_solid = 2.6
    initial_heat_capacity_solid = 800.0
    T_source_sink = 1.6e-06
    fluid_modulus = 4e+8
  [../]
  [./Muschelkalk_Rift_East_West]
    type = GolemMaterialTH
    block = 'Muschelkalk_Rift_21_TETRA Muschelkalk_Rift_39_WEDGE Muschelkalk_Rift_57_HEX Muschelkalk_Rift_72_HEX
             Muschelkalk_East_33_WEDGE Muschelkalk_East_51_HEX
             Muschelkalk_West_12_TETRA Muschelkalk_West_27_WEDGE Muschelkalk_West_45_HEX Muschelkalk_West_63_HEX'
    initial_permeability = 6e-14
    initial_porosity = 0.05
    initial_density_solid = 2863.0
    initial_thermal_conductivity_solid = 2.1
    initial_heat_capacity_solid = 730.0
    T_source_sink = 1.2e-06
    fluid_modulus = 5e+8
  [../]
  [./Buntsandstein_Rift_East_West]
    type = GolemMaterialTH
    block = 'Buntsandstein_Rift_23_TETRA Buntsandstein_Rift_41_WEDGE Buntsandstein_Rift_59_HEX Buntsandstein_Rift_74_HEX
             Buntsandstein_East_14_TETRA Buntsandstein_East_29_WEDGE Buntsandstein_East_47_HEX Buntsandstein_East_65_HEX
             Buntsandstein_West_11_TETRA Buntsandstein_West_26_WEDGE Buntsandstein_West_44_HEX Buntsandstein_West_62_HEX'
    initial_permeability = 3e-14
    initial_porosity = 0.1
    initial_density_solid = 2778.0
    initial_thermal_conductivity_solid = 3.3
    initial_heat_capacity_solid = 710.0
    T_source_sink = 1.0e-06
    fluid_modulus = 1e+9
  [../]
  [./PermoCarbon_Rift_East_West]
    type = GolemMaterialTH
    block = 'PermoCarbon_Rift_24_TETRA PermoCarbon_Rift_42_WEDGE PermoCarbon_Rift_60_HEX PermoCarbon_Rift_75_HEX
             PermoCarbon_East_15_TETRA PermoCarbon_East_32_WEDGE PermoCarbon_East_50_HEX PermoCarbon_East_66_HEX
             PermoCarbon_West_10_TETRA PermoCarbon_West_25_WEDGE PermoCarbon_West_43_HEX PermoCarbon_West_61_HEX'
    initial_permeability = 2e-15
    initial_porosity = 0.07
    initial_density_solid = 2720.0
    initial_thermal_conductivity_solid = 2.3
    initial_heat_capacity_solid = 760.0
    T_source_sink = 1.0e-06
    fluid_modulus = 7e+8
  [../]
  [./UC_MidGermanCrystallineHigh]
    type = GolemMaterialTH
    block = 'Crust_Nord_16_TETRA Crust_Nord_34_WEDGE Crust_Nord_52_HEX Crust_Nord_67_HEX'
    initial_permeability = 1e-30
    initial_porosity = 0.01
    initial_density_solid = 2717.0
    initial_thermal_conductivity_solid = 2.4
    initial_heat_capacity_solid = 755.0
    T_source_sink = 1.8e-06
    fluid_modulus = 1e+8
  [../]
  [./UC_Saxothuringian]
    type = GolemMaterialTH
    block = 'Crust_Mid_17_TETRA Crust_Mid_35_WEDGE Crust_Mid_53_HEX Crust_Mid_68_HEX'
    initial_permeability = 1e-30
    initial_porosity = 0.01
    initial_density_solid = 2747.0
    initial_thermal_conductivity_solid = 2.5
    initial_heat_capacity_solid = 900.0
    T_source_sink = 2.5e-06
    fluid_modulus = 1e+8
  [../]
  [./UC_Moldanubian]
    type = GolemMaterialTH
    block = 'Crust_Sued_18_TETRA Crust_Sued_36_WEDGE Crust_Sued_54_HEX Crust_Sued_69_HEX'
    initial_permeability = 1e-30
    initial_porosity = 0.01
    initial_density_solid = 2707.0
    initial_thermal_conductivity_solid = 2.5
    initial_heat_capacity_solid = 900.0
    T_source_sink = 2.6e-06
    fluid_modulus = 1e+8
  [../]
  [./Fault_West]
    type = GolemMaterialTH
    block = 'fault_west_2_TRIANGLE fault_west_5_QUAD'
    material_type = frac
    initial_scaling_factor = 1.0
    initial_permeability = 5e-14
    initial_porosity = 1.0
    initial_density_solid = 2717.0
    initial_thermal_conductivity_solid = 2.4
    initial_heat_capacity_solid = 755.0
    fluid_modulus = 2.5e+9
  [../]
  [./Fault_East]
    type = GolemMaterialTH
    block = 'fault_east_3_TRIANGLE fault_east_6_QUAD'
    material_type = frac
    initial_scaling_factor = 1.0
    initial_permeability = 5e-14
    initial_porosity = 1.0
    initial_density_solid = 2717.0
    initial_thermal_conductivity_solid = 2.4
    initial_heat_capacity_solid = 755.0
    fluid_modulus = 2.5e+9
  [../]
  [./Fault_170]
    type = GolemMaterialTH #parallel to main stress
    block = 'fault_170_1_TRIANGLE fault_170_4_QUAD'
    material_type = frac
    initial_scaling_factor = 1.0
    initial_permeability = 1e-10
    initial_porosity = 1.0
    initial_density_solid = 2717.0
    initial_thermal_conductivity_solid = 2.4
    initial_heat_capacity_solid = 755.0
    fluid_modulus = 2.5e+9
  [../]
  [./Fault_020] #like main border faults
    type = GolemMaterialTH
    block = 'fault_020_7_QUAD'
    material_type = frac
    initial_scaling_factor = 1.0
    initial_permeability = 5e-14
    initial_porosity = 1.0
    initial_density_solid = 2717.0
    initial_thermal_conductivity_solid = 2.4
    initial_heat_capacity_solid = 755.0
    fluid_modulus = 2.5e+9
  [../]
  [./Fault_065] #perpendicular to main stress
    type = GolemMaterialTH
    block = 'fault_065_8_QUAD fault_065_long_9_QUAD'
    material_type = frac
    initial_scaling_factor = 1.0
    initial_permeability = 1e-20
    initial_porosity = 1.0
    initial_density_solid = 2717.0
    initial_thermal_conductivity_solid = 2.4
    initial_heat_capacity_solid = 755.0
    fluid_modulus = 2.5e+9
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
  [./supg]
    type = GolemSUPG
  [../]
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
                              1 0 1000'
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
  start_time = 0.0
  end_time = 2000000
  #[./TimeStepper]
  #  type = TimeSequenceStepper
	#  time_sequence = '0.1 0.2 0.4 0.8
  #                   1 2 4 8 16 32 64 128 256 400 550 700 900
  #                   1200 1500 1800 2200 2600 3000 3400 3800 4200 4600 5000 5600 6700 7800 8900 10000 12000 14000
	#				 16000 20000 25000 30000 35000 42000 50000 60000 75000 90000 110000 130000 150000
	#				 180000 200000 260000 524288 1048576 2000000'
  #[../]
   [./TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 6
	iteration_window = 1
    dt = .1
    growth_factor = 2
	cutback_factor = 0.5
  [../]
[]

[Outputs]
  print_linear_residuals = false
  print_perf_log = true
  [./out]
    type = Exodus
  [../]
  [./csv]
    type = CSV
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]

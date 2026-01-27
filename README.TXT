
FILE: optimized.m
It is the main file with the proposed algorithm.

INPUTS:

-x: Vector with the x-coordinates of the sensors
-y: Vector with the y-coordinates of the sensors

-x_max: Maximum x-coordinate
-y_max: Maximum y-coordinate

-n: Number of nodes in the experiment
-stop: Number of deaths required to reach the end, expressed as a percentage of n
-leach: Variable p from the LEACH method

-fis_fnd: KB until the simulation reaches FND
-fis_hnd: KB when the simulation has passed the FND but not the HND
-fis_lnd: KB when the HND has already been exceeded

-EBx: x-coordinate of the base station
-EBy: y-coordinate of the base station

-Eo: initial energy of nodes
-ETX,ERX,Efs,Eamp,EDA: parameters of energy model
-packetSize,controlPacketSize:parameters of communication packets

-Eminima: Minimum energy before a node is considered dead

OUTPUTS:
-FND: Firts node dies
-HND: Half node die
-LND: Last node die 

FILE: cprintf.m
Additional file to view the text output in color

FILE:escenario.mat
Coordinates with the location of the sensors.

FILE: variables_menos_x_y_ebx_eby.mat
All the variables of the energy and communications model necessary to launch experiments are in place; only the position of the sensors and the base station are missing.

FILE:pruebas_escenarios_centro.m
File that calculates the algorithm's output for 15 different scenarios, with the base station in the center.

FILES: 	kb_wsn_tras_fnd_centro.fis
	kb_wsn_tras_fnd_hnd_centro.fis
	kb_wsn_tras_fnd_hnd_lnd_centro.fis
Fuzzy inference systems to use when the BS is in the center.

FILE: pruebas_escenarios_esquina.m
File that calculates the algorithm's output for 15 different scenarios, with the base station in the corner.

FILES: 	kb_wsn_tras_fnd_esquina.fis
	kb_wsn_tras_fnd_hnd_esquina.fis
	kb_wsn_tras_fnd_hnd_lnd_esquina.fis
Fuzzy inference systems to use when the BS is in the corner.

FILE: pruebas_escenarios_lejos.m
File that calculates the algorithm's output for 15 different scenarios, with the base station far away.

FILES: 	kb_wsn_tras_fnd_lejos.fis
	kb_wsn_tras_fnd_hnd_lejos.fis
	kb_wsn_tras_fnd_hnd_lnd_lejos.fis
Fuzzy inference systems to use when the BS is in the corner.


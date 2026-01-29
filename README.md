# CFC3PSO clustering algorithm
This repository holds Matlab code for the bloew referenced reaearch paper Optimizing Rule Weights to Improve FRBS Clustering in Wireless Sensor Networks

> Muñoz-Exposito, J.-E., Yuste-Delgado, A.-J., Triviño-Cabrera, A., & Cuevas-Martinez, J.-C. (2024). Optimizing Rule Weights to Improve FRBS Clustering in Wireless Sensor Networks. Sensors, 24(17), 5548. [https://doi.org/10.3390/s24175548](https://doi.org/10.3390/s24175548)

## Abstract
Wireless sensor networks (WSNs) are usually composed of tens or hundreds of nodes powered by batteries that need efficient resource management to achieve the WSN’s goals. One of the techniques used to manage WSN resources is clustering, where nodes are grouped into clusters around a cluster head (CH), which must be chosen carefully. In this article, a new centralized clustering algorithm is presented based on a Type-1 fuzzy logic controller that infers the probability of each node becoming a CH. The main novelty presented is that the fuzzy logic controller employs three different knowledge bases (KBs) during the lifetime of the WSN. The first KB is used from the beginning to the instant when the first node depletes its battery, the second KB is then applied from that moment to the instant when half of the nodes are dead, and the last KB is loaded from that point until the last node runs out of power. These three KBs are obtained from the original KB designed by the authors after an optimization process. It is based on a particle swarm optimization algorithm that maximizes the lifetime of the WSN in the three periods by adjusting each rule in the KBs through the assignment of a weight value ranging from 0 to 1. This optimization process is used to obtain better results in complex systems where the number of variables or rules could make them unaffordable. The results of the presented optimized approach significantly improved upon those from other authors with similar methods. Finally, the paper presents an analysis of why some rule weights change more than others, in order to design more suitable controllers in the future.

> Keywords: wireless sensor network; fuzzy logic; clustering

## License
Creative Commons Attribution (CC BY) license [(https://creativecommons.org/licenses/by/4.0/)](https://creativecommons.org/licenses/by/4.0/)

## Disclaimer

This software is provided “as is”, without any express or implied warranties. No maintenance, updates, or technical support are provided. Use of the software is entirely at the user’s own risk. In no event shall the developer be held liable for any direct, indirect, incidental, or consequential damages arising from the use of, or inability to use, this software.

# Usage

## FILE: optimized.m
It is the main file with the proposed algorithm.

### INPUTS:
- x: Vector with the x-coordinates of the sensors
- y: Vector with the y-coordinates of the sensors
- x_max: Maximum x-coordinate
- y_max: Maximum y-coordinate
- n: Number of nodes in the experiment
- stop: Number of deaths required to reach the end, expressed as a percentage of n
- leach: Variable p from the LEACH method
- fis_fnd: KB until the simulation reaches FND
- fis_hnd: KB when the simulation has passed the FND but not the HND
- fis_lnd: KB when the HND has already been exceeded
- EBx: x-coordinate of the base station
- EBy: y-coordinate of the base station
- Eo: initial energy of nodes
- ETX,ERX,Efs,Eamp,EDA: parameters of energy model
- packetSize,controlPacketSize:parameters of communication packets
- Eminima: Minimum energy before a node is considered dead

### OUTPUTS:
- FND: Firts node dies
- HND: Half node die
- LND: Last node die 

## FILE: cprintf.m
Additional file to view the text output in color

## FILE:escenario.mat
Coordinates with the location of the sensors.

## FILE: variables_menos_x_y_ebx_eby.mat
All the variables of the energy and communications model necessary to launch experiments are in place; only the position of the sensors and the base station are missing.

## Setup files for scenario with BS in the center
### FILE:pruebas_escenarios_centro.m
File that calculates the algorithm's output for 15 different scenarios, with the base station in the center.

### Fuzzy inference system setup for BS located in the center
Fuzzy inference systems to use when the BS is in the center.
- File kb_wsn_tras_fnd_centro.fis
- File kb_wsn_tras_fnd_hnd_centro.fis
- File kb_wsn_tras_fnd_hnd_lnd_centro.fis

## Setup files for scenario with BS in a corner

### FILE: pruebas_escenarios_esquina.m
File that calculates the algorithm's output for 15 different scenarios, with the base station in the corner.

### Fuzzy inference system setup for BS located in ac corner
Fuzzy inference systems to use when the BS is in the corner.
- kb_wsn_tras_fnd_esquina.fis
- kb_wsn_tras_fnd_hnd_esquina.fis
- kb_wsn_tras_fnd_hnd_lnd_esquina.fis

## Setup files for scenario with BS far from the deployment area

### FILE: pruebas_escenarios_lejos.m
File that calculates the algorithm's output for 15 different scenarios, with the base station far away.

### Fuzzy inference system setup for BS located far from the deployment area
Fuzzy inference systems to use when the BS is in the corner.
- kb_wsn_tras_fnd_lejos.fis
- kb_wsn_tras_fnd_hnd_lejos.fis
- kb_wsn_tras_fnd_hnd_lnd_lejos.fis



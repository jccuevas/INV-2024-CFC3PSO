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


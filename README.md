# Brownian dynamics simulations of polymers with noise and a non-reciprocal force

This package can be used to perform Brownian dynamics simulations of a Rouse polymer driven by correlated, active forces which can vary in magnitude along the chain.

The act_pol.bdsim module contains the code to simulate a Rouse polymer with correlated noise along with other deterministic forces, such as additional harmonic bonds coupling distinct monomers, a soft elliptical confinement, and a non-reciprocal force pointing from one bead to another. The act_pol.analysis module contains various scripts to analyze the output of the simulation. In particular, the act_pol.analysis.contacts module allows one to compute the mean distance between all pairs of monomers, as well as contact probabilities from ensemble and time-averaged simulation data. 

This package was adapted from A. Goychuk, D. Kannan, A. K. Chakraborty, and M. Kardar. Polymer folding through active processes recreates features of genome organization. *PNAS* (2023) https://doi.org/10.1073/pnas.2221726120

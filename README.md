# MM-OPES_for_PK1
#"Optimizing On-the-Fly Probability Enhanced Sampling for Complex RNA Systems: Sampling Free Energy Surfaces of an H-Type Pseudoknot"

Manuscript Link: https://www.biorxiv.org/content/10.1101/2024.10.25.620366v1


# Repository Overview
This repository contains all the input files and simulation scripts needed to reproduce the simulations of the paper.

# Folder Structure
1. Qstem1_Qstem2/


Contains input files for simulations employing  $Q_{stem1}$ and $Q_{stem2}$ as two orthogonal collective variables (CVs).
Simulations were performed over a temperature range of 300–480 K.

Structure:

mdp/: Contains the GROMACS .mdp files.
0/, 1/, 2/, ..., 7/: These folders include the PLUMED input files (plumed files) and GROMACS .tpr files.


2. Nhb1_Nhb2/


Contains input files for simulations using $N_{HB1}$ and $N_{HB2}$ as two orthogonal CVs.
Simulations were performed over a temperature range of 300–480 K.

Structure:

mdp/: Contains the GROMACS .mdp files.
0/, 1/, 2/, ..., 7/: These folders include the PLUMED input files (plumed files) and GROMACS .tpr files.


3. plumed/


Contains all PLUMED input files used in the simulations.
File naming convention: plumed-CVs-temperature-range.dat.


Coordinate and Topology Files

pk1_deshaw_390_pr.gro: Coordinate file of the total system.
topol.top: GROMACS-compatible topology file of the total system.




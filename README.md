# MM-OPES_for_PK1
#"Optimizing On-the-Fly Probability Enhanced Sampling for Complex RNA Systems: Sampling Free Energy Surfaces of an H-Type Pseudoknot":https://www.biorxiv.org/content/10.1101/2024.10.25.620366v1

#This repository contains all the input files and simulation scripts needed to reproduce the simulations of the paper. 

#"Qstem1_Qstem2" contain input files blong to the simulation employing $Q_{stem1}$ and $Q_{stem2}$ as distinct collective variables (CVs), performed over a temperature range of 300–480 K. And "Nhb1_Nhb2" contain input files belong to the simulation employing $N_{HB1}$ and $N_{HB2}$ as two orthogonal CVs, performed over a temperature range of 300–480 K. In any folder there are one folder that contain mdp files "mdp". and 8 folder "0, 1, 2...,7" contain plumed and tpr files. 

#"plumed" contain all plumed input files for all simulations has been done, and name of the files are as follow. "plumed-CVs-temperature-range.dat"

#pk1_deshaw_390_pr.gro file is the coordinate of the total system and topol.top is the GROMACS-compatible topology file of the total system. 

#For the further details, please see to the manuscript



# The following is an example script how to run the plumed files:





#Full path to application + application name
source "/home/username/PROGRAMS/plumed2-v2.8/sourceme.sh

application="/home/username/PROGRAMS/gromacs-2021.4/exec/bin/gmx_gpu mdrun"

#Define number of walkers
ng=8


#Define variables related to RNA and ff
proot="pk1"
ff="deshaw"
fileroot="${proot}_${ff}"
this="opes"

mkdir cpts

nm=$(echo "$ng - 1" | bc)
dirs=0
cp ${dirs}/${fileroot}_${this}_nd.cpt cpts/${dirs}_${SLURM_JOB_ID}.cpt

for i in $(seq 1 $nm); do

cp ${i}/${fileroot}_${this}_nd.cpt cpts/${i}_${SLURM_JOB_ID}.cpt

dirs=${dirs}" "${i}
done

options="-maxh 169 -multidir $dirs \
-v -s ${fileroot}_${this}_nd.tpr \
-x ${fileroot}_${this}_nd.xtc \
-o ${fileroot}_${this}_nd.trr \
-c ${fileroot}_${this}_nd.gro \
-e ${fileroot}_${this}_nd.edr \
-g ${fileroot}_${this}_nd.log \
-plumed plumed.dat \
-cpo ${fileroot}_${this}_nd.cpt \
-cpi ${fileroot}_${this}_nd.cpt -noappend"

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`

# Launch the MPI executable

mpirun $application $options > outfile_${proot} 2>&1

echo Time is `date`


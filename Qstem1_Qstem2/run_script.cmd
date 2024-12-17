#!/bin/sh

source /home/username/PROGRAMS/plumed2-v2.8/sourceme.sh

# Define number of walkers
ng=8
# Which set?
s=1
# Full path to application + application name
application="/home/username/PROGRAMS/gromacs-2021.4/exec/bin/gmx_gpu mdrun"
# Define variables related to protein and ff
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

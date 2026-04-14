#!/bin/bash
#PBS -S /bin/bash
#PBS -N Test-VASP-new
#PBS -l select=2:ncpus=56:mpiprocs=56
#PBS -q workq
#PBS -joe
#PBS -V
#PBS -e test.err
#PBS -o test.out
export I_MPI_FABRICS=shm:tmi
export I_MPI_PROVIDER=psm2
export I_MPI_FALLBACK=0
export KMP_AFFINITY=verbose,scatter
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
ulimit -s unlimited

source /c14scratch/apps/modules/init/bash

#module load vasp/5.4.4
#source /c14scratch/apps/vasp/5.4.4/

module load vasp/6.5.1

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > pbs_nodes
echo Working directory is $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`
NNODES=`uniq $PBS_NODEFILE | wc -l`

mpirun -np 112 --machinefile $PBS_NODEFILE vasp_std | tee result-new

#!/bin/bash
#PBS -S /bin/bash
#PBS -N P-JOB-Test
#PBS -l select=4:ncpus=32:mpiprocs=32
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

#module load intel/2018
#module load vasp/5.4.4
module load vasp/6.3.2
cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > pbs_nodes
echo Working directory is $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`
NNODES=`uniq $PBS_NODEFILE | wc -l`

mpirun -np 128 --machinefile $PBS_NODEFILE vasp_ncl | tee result3

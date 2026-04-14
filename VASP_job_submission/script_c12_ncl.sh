#!/bin/bash
#PBS -S /bin/bash
#PBS -N P-JOB-Test
#PBS -l select=2:ncpus=24:mpiprocs=24
#PBS -q workq
#PBS -joe
#PBS -V
#PBS -e test.err
#PBS -o test.out
export I_MPI_FABRICS=shm:tcp
export I_MPI_PROVIDER=psm2
export I_MPI_FALLBACK=0
export KMP_AFFINITY=verbose,scatter
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

#ulimit -s unlimited || true

#source /c12scratch/apps/intel18/bin/compilervars.sh intel64 -platform linux

source /c12scratch/apps/intel18/bin/compilervars.sh intel64

module load vasp/6.2.1
 
cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > pbs_nodes


mpirun -np 48 -machinefile $PBS_NODEFILE vasp_ncl | tee result

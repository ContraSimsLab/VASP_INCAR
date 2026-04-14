#!/bin/bash
#PBS -S /bin/bash
#PBS -N gpu_job
##PBS -l select=1:ngpus=1
#PBS -l select=1:ncpus=1:ngpus=1:mem=16gb
#PBS -q gpuq
#PBS -j oe
#PBS -V
#PBS -e gpu_job.err
#PBS -o gpu_job.out

# Set CUDA environment variables
#export CUDA_HOME=./../apps/cuda/11.3  # Adjust to your CUDA path
#export PATH=$CUDA_HOME/bin:$PATH
#export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

export I_MPI_FABRICS=shm:tmi
export I_MPI_PROVIDER=psm2
export I_MPI_FALLBACK=0
export KMP_AFFINITY=verbose,scatter
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

#module load openmpi/4.0.0

module load vasp/6.5.1-gpu

# Change to the working directory
cd $PBS_O_WORKDIR

# Print job details
cat $PBS_NODEFILE > pbs_nodes
echo Working directory is $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`
NNODES=`uniq $PBS_NODEFILE | wc -l`
#mpirun -np $NPROCS --machinefile

mpirun -np 1 --machinefile $PBS_NODEFILE vasp_ncl | tee result-new

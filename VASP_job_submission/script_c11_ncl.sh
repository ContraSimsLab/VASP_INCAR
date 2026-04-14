#!/bin/bash
#PBS -l nodes=4:ppn=24
#PBS -q default
#PBS -N C11-test
#PBS -e test.err
#PBS -o test.out
echo PBS JOB id is $PBS_JOBID
echo PBS_NODEFILE is $PBS_NODEFILE
echo PBS_QUEUE is $PBS_QUEUE
cat  $PBS_NODEFILE
export I_MPI_FABRICS=shm:tmi
cd $PBS_O_WORKDIR

source /opt/parallel_studio_xe_2018/start.sh

#module load vasp.6.1.2

mpirun -hostfile $PBS_NODEFILE -np 96 /c11scratch/apps/vasp.6.1.2/bin/vasp_ncl | tee result





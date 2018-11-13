#!/bin/bash
#SBATCH --chdir=.
#SBATCH --job-name=benchmark
#SBATCH --output=./run.log
#SBATCH --no-requeue
#SBATCH --partition=cpu_dev
#SBATCH --cpus-per-task=40
#SBATCH --ntasks-per-node=1 --export=NONE

# run with `sbatch slurm.sh`
printf "USER:${USER:-none} SLURM_JOB_ID:${SLURM_JOB_ID:-none} SLURM_JOB_NAME:${SLURM_JOB_NAME:-none} HOSTNAME:${HOSTNAME:-none} PWD:$PWD\n"
TIMESTART="$(date +%s)"

make run

printf "elapsed time: %ss\n" "$(( $(date +%s) - ${TIMESTART} ))"

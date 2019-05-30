#!/bin/bash

#submitSlurm.sh

#SBATCH -J simrun
#SBATCH -p parallel 
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem 1024
#SBATCH -t 0-2:00
#SBATCH -o slurm.%N.%j.out
#SBATCH -e slurm.%N.%j.err

singularity run docker://b153/rcs-ss-r-hpc:latest

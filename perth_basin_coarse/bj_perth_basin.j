#!/usr/bin/env zsh

### Job name
#BSUB -J golem_perth_basin_coarse

### File / path where STDOUT & STDERR will be written
###    %J is the job ID, %I is the array ID
#BSUB -o ~/projects/golem-devel/job_logs/golem_transient_perth_basin_coarse.%J.%I

### Send email when job is done
#BSUB -u gweishar@gmail.com
#BSUB -N
#BSUB -B

### Request the time you need for execution in minutes
### The format for the parameter is: [hour:]minute,
### that means for 80 minutes you could also use this: 1:20
#BSUB -W 05:00

### Request memory you need for your job in TOTAL in MB
#BSUB -M 8000

### Use esub for Open MPI
#BSUB -a openmpi

### Request number of slots
#BSUB -n 64

cd $HOME/projects/golem-devel/tests/perth_basin_coarse/
mpirun -n 64 ../.././golem-opt -i transient.i

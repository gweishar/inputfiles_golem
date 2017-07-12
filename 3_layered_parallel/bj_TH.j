#!/usr/bin/env zsh

### Submit job as part of project
#BSUB -P thes0273

### Job name
#BSUB -J 3_layered_parallel

### File / path where STDOUT & STDERR will be written
###    %J is the job ID, %I is the array ID
#BSUB -o $HOME/projects/golem-devel/job_logs/3_layered_parallel.%J.%I

### Send email when job is done
#BSUB -u gweishar@gmail.com
#BSUB -N
#BSUB -B

### Request the time you need for execution in minutes
### The format for the parameter is: [hour:]minute,
### that means for 80 minutes you could also use this: 1:20
#BSUB -W 24:00

### Request memory you need for your job in TOTAL in MB
#BSUB -M 8000

### Use esub for Open MPI
#BSUB -a openmpi

### Request number of slots
#BSUB -n 16

cd $HOME/projects/golem-devel/inputfiles_golem/3_layered_parallel/ic
mpirun -n 16 ../../.././golem-opt -i ic.i
cd ..
mpirun -n 16 ../.././golem-opt -i transient.i

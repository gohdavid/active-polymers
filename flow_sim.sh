#!/bin/bash
#SBATCH --job-name=flow_sim
#SBATCH --time=96:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=xeon-p8
##SBATCH --partition=xeon-g6-volta
#SBATCH -o flow_sim.log-%A-%a
#SBATCH --array=1-239
##SBATCH --array=1-160

source activate poly
export OPENBLAS_NUM_THREADS=2
echo $SLURM_ARRAY_JOB_ID
echo $SLURM_ARRAY_TASK_ID
echo $PATH
# python flow_sim.py <job_id> <velocity_prefactor> <friction> <activity> <E-P tether length> <reciprocity boolean>

# Equilibrium distribution
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 20 0

# Zero flow, increase friction only, for two contour lengths
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 20 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1 20 0

# Zero flow, decrease activity only, for two contour lengths
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 0 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 0 20 0

# Zero flow, increase activity only (sanity check), for two contour lengths
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 10 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 10 20 0

# Finite flow
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 20 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 1 20 0

# Finite flow, increase friction only, for two contour lengths
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 100 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 100 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 20 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 100 1 20 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 20 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 100 1 20 0

# Finite flow, decrease activity only, for two contour lengths
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 0 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 0 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 0 20 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 0 20 0

# Phase diagram
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 22.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25.0 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 27.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 30 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 32.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 35.0 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 37.5 14 1 250 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 25 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 50 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 75 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 125 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 175 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 200 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 225 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 40 14 1 250 0
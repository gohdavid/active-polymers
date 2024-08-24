#!/bin/bash
#SBATCH --job-name=flow_sim
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
##SBATCH --partition=xeon-p8
#SBATCH --partition=xeon-g6-volta
#SBATCH -o flow_sim.log-%A-%a
##SBATCH --array=1-239
#SBATCH --array=1-160

source activate poly
export OPENBLAS_NUM_THREADS=2
echo $SLURM_ARRAY_JOB_ID
echo $SLURM_ARRAY_TASK_ID
echo $PATH
# python flow_sim.py <job_id> <velocity_prefactor> <friction> <diffusivity> <E-P tether length>

# Equilibrium distribution
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 150

# Increase flow only
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0.01 1 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0.1 1 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 1 1 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 100 1 1 150

# Increase friction and decrease diffusivity by the same factor (propto R^2)
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 25 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 49 1/49 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1/100 150

# Decrease diffusivity only
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1/49 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1/100 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 0 150

# Increase friction only
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 25 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 49 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1 150

# Finite flow, increase friction and decrease diffusivity by the same factor (propto R^2)
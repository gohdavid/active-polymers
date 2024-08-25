#!/bin/bash
#SBATCH --job-name=flow_sim
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
##SBATCH --partition=xeon-p8
#SBATCH --partition=xeon-g6-volta
#SBATCH -o flow_sim.log-%A-%a
#SBATCH --array=1-239
#SBATCH --array=1-160

source activate poly
export OPENBLAS_NUM_THREADS=2
echo $SLURM_ARRAY_JOB_ID
echo $SLURM_ARRAY_TASK_ID
echo $PATH
# python flow_sim.py <job_id> <velocity_prefactor> <friction> <diffusivity> <E-P tether length>

# Equilibrium distribution
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 150

# Increase flow only
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0.01 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0.1 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 1 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 100 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 50 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 1 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 1 150

# Zero flow, increase friction and decrease diffusivity by the same factor (propto R^2)
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 7 1/7 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 25 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 50 1/50 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1/100 150

# Zero flow, decrease diffusivity only
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1/7 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1/50 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1/100 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 0 150

# Zero flow, increase friction only
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 7 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 25 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 50 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1 150

# Finite flow, increase friction and decrease diffusivity by the same factor (propto R^2)
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 25 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 50 1/50 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 100 1/100 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 7 1/7 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 25 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 50 1/50 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 100 1/100 150

# Finite flow, decrease diffusivity only
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1/7 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1/50 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1/100 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 0 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 1 1/7 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 1 1/25 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 1 1/50 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 1 1/100 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 1 0 150


# Finite flow, increase friction only
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 25 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 50 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 100 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 7 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 25 1 150
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 50 1 150
# python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 25 100 1 150

# Finite flow, decrease contour length only, friction propto r and diffusion propto 1/r 
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 140
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 130
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 120
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 110
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 100
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 90
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 80
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 70
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 60
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1/7 50

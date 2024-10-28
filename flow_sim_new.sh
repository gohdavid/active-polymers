#!/bin/bash
#SBATCH --job-name=flow_sim
#SBATCH --time=48:00:00
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
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 7 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 7 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1 100 0


python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 10.5 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 3.5 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 10.5 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 3.5 1 150 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 10.5 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 3.5 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 10.5 1 100 0
python flow_sim.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 3.5 1 100 0
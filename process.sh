#!/bin/bash
#SBATCH --job-name=process
#SBATCH --time=06:00:00
#SBATCH -N 4
#SBATCH --partition=xeon-p8
#SBATCH -o process.log-%A-%a

source activate poly
export OPENBLAS_NUM_THREADS=2
echo $SLURM_ARRAY_JOB_ID
echo $SLURM_ARRAY_TASK_ID
echo $PATH
# python process.py <job_id> <velocity_prefactor> <friction> <activity> <E-P tether length> <reciprocity boolean>

# # Equilibrium distribution
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 20 0

# # Zero flow, increase friction only, for two contour lengths
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 20 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 100 1 20 0

# # Zero flow, decrease activity only, for two contour lengths
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 0 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 0 20 0

# # Zero flow, increase activity only (sanity check), for two contour lengths
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 10 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 10 20 0

# # Finite flow
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 20 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 1 20 0

# # Finite flow, increase friction only, for two contour lengths
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 100 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 100 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 20 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 100 1 20 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 20 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 100 1 20 0

# # Finite flow, decrease activity only, for two contour lengths
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 0 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 0 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 0 20 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 1 0 20 0

python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 5 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 225 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 25 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 50 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 75 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 100 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 125 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 150 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 175 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 200 0
python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 225 0

# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 250 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 2.5 14 1 250 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 7.5 14 1 250 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 250 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 12.5 14 1 250 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 15 14 1 250 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 17.5 14 1 250 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 20 14 1 250 0

# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 7 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 1 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 14 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 7 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 1 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 14 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 7 1 100 0


# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 10.5 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 3.5 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 10.5 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 3.5 1 150 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 10.5 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 0 3.5 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 10.5 1 100 0
# python process.py ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} 10 3.5 1 100 0
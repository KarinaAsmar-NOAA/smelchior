#!/bin/bash
#
#PBS -N dogwood_transfer
#PBS -o /u/shelley.melchior/log_transfer_dogwood.out
#PBS -e /u/shelley.melchior/log_transfer_dogwood.out
#PBS -q "dev_transfer"
#PBS -l select=1:ncpus=1:mem=40000MB
#PBS -A VERF-DEV
#PBS -l walltime=06:00:00
#PBS -l debug=true
#PBS -V

module load rsync/3.2.2
transfer_host="ddxfer.wcoss2.ncep.noaa.gov"
# pseudo command
# rsync -ahr -P /path/to/data/on/cactus/* ddxfer.wcoss2.ncep.noaa.gov:/path/to/data/on/dogwood

rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/mallory.row/evs_global_det_atmos_test/dev/com/evs/v1.0/* ddxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/mallory.row/evs_global_det_atmos_test/dev/com/evs/v1.0/.

#transfer_host="dlogin01"
#rsync -ahr -P /u/$USER/qstat.py $transfer_host:/u/$USER/.
#rsync -ahr -P /u/$USER/qdel_all.py $transfer_host:/u/$USER/.
#rsync -ahr -P /u/$USER/*.ver $transfer_host:/u/$USER/.
#rsync -ahr -P /u/$USER/load_metplus.sh $transfer_host:/u/$USER/.
#rsync -ahr -P /u/$USER/run_after_prod_switch.sh $transfer_host:/u/$USER/.
#rsync -ahr -P /u/$USER/.bashrc $transfer_host:/u/$USER/.
#rsync -ahr -P /u/$USER/cron_jobs/crontab* $transfer_host:/u/$USER/cron_jobs/.
#rsync -ahr -P /u/$USER/cron_jobs/scripts $transfer_host:/u/$USER/cron_jobs/.
#rsync -ahr -P /lfs/h2/emc/vpppg/save/$USER/* $transfer_host:/lfs/h2/emc/vpppg/save/$USER/.
#rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/$USER/* $transfer_host:/lfs/h2/emc/vpppg/noscrub/$USER/.

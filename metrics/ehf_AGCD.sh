#!/bin/bash
#PBS -P w97
#PBS -l ncpus=1
#PBS -l mem=4gb
#PBS -l walltime=10:00:00
#PBS -l wd
#PBS -j oe
#PBS -q normal
#PBS -l storage=gdata/w97+gdata/fs38+gdata/hh5+gdata/zv2
#PBS -M z5149708@unsw.edu.au
#PBS -m ae

module use /g/data/hh5/public/modules
module load conda
module load cdo 


#1 merge time for daily tmax and tmin

cdo mergetime /g/data/zv2/agcd/v1/tmax/mean/r005/01day/agcd_v1_tmax_mean_r005_daily_*.nc 1_AGCD_tmax_merged.nc
cdo mergetime /g/data/zv2/agcd/v1/tmin/mean/r005/01day/agcd_v1_tmin_mean_r005_daily_*.nc 1_AGCD_tmin_merged.nc

#2 setlatlonbox for tmax and tmin 

cdo sellonlatbox,110,155,-10,-45 1_AGCD_tmax_merged.nc 2_AGCD_tmax_merged_AUS.nc
cdo sellonlatbox,110,155,-10,-45 1_AGCD_tmin_merged.nc 2_AGCD_tmin_merged_AUS.nc

#3 regrid tmax and tmin
## ACCESS_grid.txt is from cdo griddes
cdo remapcon,ACCESS_grid.txt 2_AGCD_tmax_merged_AUS.nc AGCD_tmax_regrid.nc 
cdo remapcon,ACCESS_grid.txt 2_AGCD_tmin_merged_AUS.nc AGCD_tmin_regrid.nc

#4 use Tammas' ehfheatwave

python3 /g/data/w97/sl7808/ehf/ehfheatwaves/ehfheatwaves.py -x "AGCD_tmax_regrid.nc" --vnamex="tmax" -n "AGCD_tmin_regrid.nc" --vnamen="tmin" --mask="landmask3AUS.nc" --vnamem="landmask" --daily --season=summer --ehi



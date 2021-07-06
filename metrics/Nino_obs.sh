#!/bin/bash

#Leanne_Lee_May2021

##AIM
#calculate nino3.4 for HADISST



#PBS -P w97
#PBS -l ncpus=1
#PBS -l mem=4gb
#PBS -l walltime=10:00:00
#PBS -l wd
#PBS -j oe
#PBS -q normal
#PBS -l storage=gdata/w97+gdata/fs38+gdata/hh5
#PBS -M z5149708@unsw.edu.au
#PBS -m ae

module use /g/data/hh5/public/modules
module load conda

module load cdo



in_dir=/g/data/ua8/HadISST/v1-1/HadISST_sst.nc
echo "#1"
#1_pull out the regions from input file 
##set the box for nino3.4
cdo sellonlatbox,-170,-120,-5,5 -selname,sst ${in_dir} 1_box.nc
echo "#1 box done"

echo "#2"
#2_average of the area
cdo fldmean 1_box.nc 2_mean.nc
echo "2_mean.nc"

echo "#3"
#choose climatology years
cdo selyear,1961/1990 2_mean.nc 3a_climyrs.nc
echo "3a_climyrs.nc"
#get the mean for each month
cdo ymonmean 3a_climyrs.nc 3b_monmean.nc
echo "3b_monmean.nc"
#Get the difference between two input files and save an output file.
cdo ymonsub 2_mean.nc 3b_monmean.nc 3c_anomalies.nc
echo "3c_anomalies.nc"


echo "#4"
#4_detrend the data
cdo detrend 3c_anomalies.nc 4_detrend.nc
echo "4_detrend.nc"

echo "finsh"


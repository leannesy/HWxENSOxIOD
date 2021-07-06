#!/bin/bash

#Leanne_Lee_Nov2020

##AIM
#calculate DMI for observational data, from HADISST
#data avilable: 1870_01-2020_09
#climatology: 1961-1990
#DMI for: 1870-2020Sept

module load cdo

#0_dir where the merged-time monthly SST files live
in_dir=$1
#e.g. /g/data/ua8/HadISST/v1-1/HadISST_sst.nc
echo "input dir:""$in_dir"

#0_define an output dir
#$2 e.g. /g/data/w97/sl7808
out_dir=$2/$3
#$out_dir e.g. /g/data/w97/sl7808/DMI_HADISST
mkdir -p $out_dir
echo "output dir:""$out_dir"

#0_experiment
expt=$3
echo "start cal DMI for historical experiment ""$expt"

echo "#1"
#1_pull out the regions from input file 
##set the box for Western Indian Ocean
box=("WIO" "EIO")
cdo sellonlatbox,50,70,-10,10 -selname,sst ${in_dir} ${out_dir}/1_WIO.nc
echo "West box done"
##set the box for SE Indian Ocean
cdo sellonlatbox,90,110,-10,0 -selname,sst ${in_dir} ${out_dir}/1_EIO.nc
echo "SE box done"

#for each region 
for k in ${box[@]}
        do
                echo "loop""${k}"
                echo "input from""${out_dir}/1_${k}.nc"
                echo "#2"
                #2_average of the area
                cdo fldmean ${out_dir}/1_${k}.nc ${out_dir}/2_mean_${k}.nc
                echo "${out_dir}/2_mean_${k}.nc"

                echo "#3"
                #3_detrend the data
                cdo detrend ${out_dir}/2_mean_${k}.nc ${out_dir}/3_detrend_${k}.nc
                echo "#${out_dir}/3_detrend_${k}.nc"

                echo "#4&5"
                #4&5_choose climatology years
                cdo selyear,1961/1990 ${out_dir}/3_detrend_${k}.nc ${out_dir}/5a_climyrs_${k}.nc
                echo "${out_dir}/5a_climyrs_${k}.nc"
                #get the mean for each month
                cdo ymonmean ${out_dir}/5a_climyrs_${k}.nc ${out_dir}/5b_monmean_${k}.nc
                echo "${out_dir}/5b_monmean_${k}.nc"
                #Get the difference between two input files and save an output file.
                cdo ymonsub ${out_dir}/3_detrend_${k}.nc ${out_dir}/5b_monmean_${k}.nc ${out_dir}/5c_anomalies_${k}.nc
                echo "${out_dir}/5c_anomalies_${k}.nc"

        done

echo "finish loop"

echo "#6"       
#6_EvsW anomalies 
cdo sub ${out_dir}/5c_anomalies_WIO.nc ${out_dir}/5c_anomalies_EIO.nc ${out_dir}/6_EvsW.nc
echo "${out_dir}/6_EvsW.nc"

echo "#7"
#7_5month running mean 
cdo runmean,5 ${out_dir}/6_EvsW.nc ${out_dir}/7_runmean.nc
echo "${out_dir}/7_runmean.nc"

echo "#8"
#8_standard deviation  
cdo selyear,1961/1990 ${out_dir}/7_runmean.nc ${out_dir}/8a_selyear.nc
cdo timstd ${out_dir}/8a_selyear.nc ${out_dir}/8b_sd.nc
echo "${out_dir}/8b_sd.nc"


echo "#9"
#9_normalise 
cdo div ${out_dir}/7_runmean.nc ${out_dir}/8b_sd.nc ${out_dir}/9_norm.nc




echo "finsh exp""$expt"
```

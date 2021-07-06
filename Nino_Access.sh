
#!/bin/bash

#Leanne_Lee_May2021

##AIM
#calculate nino3.4 for ACCESS model output, historical experiment- normalised
#historical experiments: 1850_01-2014_12
#climatology 1961-1990 
#nino3.4 for 185-2014

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

for i in {1..20};
	do
		echo "exp${i}_start"
		in_dir=/g/data/fs38/publications/CMIP6/CMIP/CSIRO/ACCESS-ESM1-5/historical/r${i}i1p1f1/Omon/tos/gn/files/*/tos_Omon_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_185001-201412.nc
		echo "#1"
		#1_pull out the regions from input file 
		##set the box for nino3.4
		cdo sellonlatbox,-170,-120,-5,5 ${in_dir} exp${i}_1_box.nc
		echo "#1 box done"
		
		echo "#2"
		#2_average of the area
		cdo fldmean exp${i}_1_box.nc exp${i}_2_mean.nc
		echo "2_mean.nc"
		
		echo "#3"
		#choose climatology years
		cdo selyear,1961/1990 exp${i}_2_mean.nc exp${i}_3a_climyrs.nc
		echo "3a_climyrs.nc"
		#get the mean for each month
		cdo ymonmean exp${i}_3a_climyrs.nc exp${i}_3b_monmean.nc
		echo "3b_monmean.nc"
		#Get the difference between two input files and save an output file.
		cdo ymonsub exp${i}_2_mean.nc exp${i}_3b_monmean.nc exp${i}_3c_anomalies.nc
		echo "3c_anomalies.nc"
		
		
		echo "#4"
		#4_detrend the data
		cdo detrend exp${i}_3c_anomalies.nc exp${i}_4_detrend.nc
		echo "4_detrend.nc"
	done

echo "finsh"

#echo "#5"
#6_5month running mean
#cdo runmean,5 5c_anomalies.nc 6_runmean.nc
#echo "${out_dir}/6_runmean.nc"

#echo "#5"
#8_standard deviation  
#cdo selyear,1961/1990 6_runmean.nc 8a_selyear.nc
#cdo timstd 8a_selyear.nc 8b_sd.nc
#echo "${out_dir}/8b_sd.nc"

#echo "#9"
#9_normalise 
#cdo div 6_runmean.nc 8b_sd.nc 9_norm.nc

```

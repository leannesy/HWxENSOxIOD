#!/bin/bash
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

#Tasmax - merge time and select region  

out= /g/data/w97/sl7808/ehf/ehfout/test2
for i in {1..20};
        do

                dir=/g/data/fs38/publications/CMIP6/CMIP/CSIRO/ACCESS-ESM1-5/historical/r${i}i1p1f1/day/tasmax/gn/latest
                cdo mergetime ${dir}/tasmax_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_18500101-18991231.nc ${dir}/tasmax_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_19000101-19491231.nc ${dir}/tasmax_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_19500101-19991231.nc ${dir}/tasmax_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_20000101-20141231.nc ${out}/1_merged_${i}.nc
                cdo sellonlatbox,110,155,-10,-45 ${out}/1_merged_${i}.nc ${out}/2_box_${i}.nc
                echo "exp ${i} done"

        done




#Tasmin - merge time and select region	
mkdir /g/data/w97/sl7808/ehf/tasmin/mer20
out=/g/data/w97/sl7808/ehf/tasmin/mer20


for i in {1..20};
        do

                dir=/g/data/fs38/publications/CMIP6/CMIP/CSIRO/ACCESS-ESM1-5/historical/r${i}i1p1f1/day/tasmin/gn/latest
                cdo mergetime ${dir}/tasmin_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_18500101-18991231.nc ${dir}/tasmin_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_19000101-19491231.nc ${dir}/tasmin_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_19500101-19991231.nc ${dir}/tasmin_day_ACCESS-ESM1-5_historical_r${i}i1p1f1_gn_20000101-20141231.nc ${out}/1_merged_${i}.nc
                cdo sellonlatbox,110,155,-10,-45 ${out}/1_merged_${i}.nc ${out}/2_box_${i}.nc
                echo "exp ${i} done"

        done



	
#Use Tammas' ehfheatwaves
for i in {1..20};
        do
		echo "start exp ${i}"
		python3 /g/data/w97/sl7808/ehf/ehfheatwaves/ehfheatwaves.py -x "/g/data/w97/sl7808/ehf/ehfout/test2/2_box_${i}.nc" -n "/g/data/w97/sl7808/ehf/tasmin/mer20/2_box_${i}.nc"  --mask="/g/data/w97/sl7808/ehf/landmask3AUS.nc" --vnamem="landmask" --daily --season=summer --ehi 
		mv 'EHF_heatwaves__all-forcing simulation of the recent past__daily.nc' ehf_day_exp${i}.nc
		mv 'EHF_heatwaves__all-forcing simulation of the recent past__yearly_summer.nc' ehf_year_exp${i}.nc
		mv 'EHI_heatwaves__all-forcing simulation of the recent past__daily.nc' ehi_day_exp${i}.nc
		echo "finish exp ${i}"

	done		


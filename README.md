# Readme

This repository contains all the scripts necessary to produce the figures in the honours thesis:

The Influence of Indian Ocean Dipole and El Niño-Southern Oscillation on Australian Heatwaves

Author: **Leanne LEE**

Supervisors: **Sarah Perkins-Kirkpatrick, Annette Hirsch, Jatin Kala**

## Input files

### Observation

1. **AGCD daily minimum temperature:**
/g/data/zv2/agcd/v1/tmin/mean/r005/01day/agcd_v1_tmin_mean_r005_daily_*.nc

2. **AGCD daily maximum temperature:**
/g/data/zv2/agcd/v1/tmax/mean/r005/01day/agcd_v1_tmax_mean_r005_daily_*.nc

3. **HadISST 1.1 monthly average sea surface temperature:**
/g/data/ua8/HadISST/v1-1/HadISST_sst.nc

### ACCESS-ESM1-5

4. **ACCESS monthly average sea surface temperature:** 
/g/data/fs38/publications/CMIP6/CMIP/CSIRO/ACCESS-ESM1-5/historical/r1i1p1f1/Omon/tos/gn/files/*/tos_Omon_ACCESS-ESM1-5_historical_r*i1p1f1_gn_185001-201412.nc

5. **ACCESS daily maximum temperature:** 
/g/data/fs38/publications/CMIP6/CMIP/CSIRO/ACCESS-ESM1-5/historical/r*i1p1f1/day/tasmax/gn/latest/tasmax_day_ACCESS-ESM1-5_historical_r*i1p1f1_gn_*.nc

6. **ACCESS daily minimum temperature:** 
/g/data/fs38/publications/CMIP6/CMIP/CSIRO/ACCESS-ESM1-5/historical/r*i1p1f1/day/tasmin/gn/latest/tasmin_day_ACCESS-ESM1-5_historical_r*i1p1f1_gn_*.nc

7. **ACCESS Land-sea mask:**
/g/data/fs38/publications/CMIP6/CMIP/CSIRO/ACCESS-ESM1-5/historical/r1i1p1f1/fx/sftlf/gn/latest/sftlf_fx_ACCESS-ESM1-5_historical_r1i1p1f1_gn.nc 
(this land-sea mask is preprocessed by *cdo sellonlatbox,110,155,-10,-45)*

## Scripts in [Metrics](https://github.com/leannesy/HWxENSOxIOD/tree/main/metrics) folder

The scripts in this folder were used for preprocessing the data and calculating DMI, Nino 3.4 and heatwave metrics. The corresponding inputs are shown in square brackets. 

**[ACCESS_grid.txt](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/ACCESS_grid.txt)**:   

This file is the grid information of ACCESS from *cdo griddes* [*5 or 6*]*.* This is used in the **[ehf_AGCD.sh](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/ehf_AGCD.sh)** script**.** 

**[DMI_Access_1.sh,](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/DMI_Access_1.sh) [DMI_HADISST.sh](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/DMI_HADISST.sh)**: 

Calculate DMI from ACCESS [*4*] and HADISST[*1*] respectively. 

**[Nino_Access.sh,](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/Nino_Access.sh) [Nino_obs.sh](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/Nino_obs.sh):** 

Calculate Nino3.4 from ACCESS[*4*] and HADISST(obs) [*1*] respectively. 

**[ehf_AGCD.sh,](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/ehf_AGCD.sh) [ehf_Access.sh](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/ehf_Access.sh):** 

Calculate Excess Heat Factor (EHF), absolute index (EHI<sub>sig</sub>), daily event flag and three heatwave metrics (HWF, HWD, HWT) from AGCD[*1, 2*] and ACCESS [*5, 6*] respectively. These two scripts use the[ehfheatwaves](https://github.com/tammasloughran/ehfheatwaves) written by [Tammas Loughran](https://github.com/tammasloughran). 

**[HWC_Calculation.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/HWC_Calculation.ipynb):** 

Calculate Cumulative heat (HWC) from AGCD and ACCESS [EHI<sub>sig</sub>, daily event flag from **[ehf_AGCD.sh,](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/ehf_AGCD.sh) [ehf_Access.sh](https://github.com/leannesy/HWxENSOxIOD/blob/main/metrics/ehf_Access.sh)**]

## Scripts for plotting

The scripts in this folder were used to plot the figures by using the output from the metrics folder. 

**[Fig1_trends.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Fig1_trends.ipynb)**: Figure 1

**[Fig2_Bias_plot.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Fig2_Bias_plot.ipynb):** Figure 2

**[Fig3_appendix_MkTrend.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Fig3_appendix_MkTrend.ipynb)**

**[Fig4-7_IOD_Composite.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Fig4-7_IOD_Composite.ipynb):** Figure 4-7, Appendix F-I, Appendix R

**[Fig8-11_ENSO_Composite.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Fig8-11_ENSO_Composite.ipynb):** Figure 8-11, Appendix J-M, Appendix S

**[Fig12-15_ENSO&IOD_Composite.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Fig12-15_ENSO%26IOD_Composite.ipynb):** Figure 12-15, Appendix N-Q, Appendix T

**[Fig16-17_CompositeTables.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Fig16-17_CompositeTables.ipynb)**

**[Appendix1.ipynb](https://github.com/leannesy/HWxENSOxIOD/blob/main/Appendix1.ipynb):** Appendix 1

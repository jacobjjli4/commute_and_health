/*******************************************************************************
Title:		 	ECO481 Final Paper Data Cleaning Script
Authors:	 	Jia Jun (Jacob) Li, 1006824750
Date Created:	November 17, 2023
Date Updated:	December 10, 2023

Stata Version:	17.0 BE
Stata Packages:	setroot (ttp://fmwww.bc.edu/repec/bocode/s)

Description:	Do-file to clean and merge ATUS and MSA-level Uber entry data
				for the Commuting and Health project.
*******************************************************************************/

clear all
set linesize 240
setroot
capture mkdir "$root/data/derived/"

* Generate Uber entry dataset
use "$root/data/raw/uber_entry_msa.dta", clear
keep year met2013 uber
* change MSA code to be consistent with crosswalk
rename met2013 msacode
replace msacode = msacode/10
save "$root/data/derived/uber_entry_msa_clean.dta", replace

* Generate MSA crosswalk
import delimited "$root/data/raw/qcew-county-msa-csa-crosswalk-2013.csv", clear
replace msacode = substr(msacode, 2, .)
drop csacode csatitle
rename countycode county
save "$root/data/derived/county_msa_crosswalk.dta", replace

* Assign MSA values to observations in the ATUS dataset
use "$root/data/derived/commute.dta", clear
merge m:1 county using "$root/data/derived/county_msa_crosswalk.dta"
destring(msacode), replace

* Impute MSA based on Combined MSA for ATUS observations that do not have county
* codes. Counties with <100k pop are coded as XX000, where XX is the state FIPS.

replace msacode=1946 if (metarea==3440) & (msacode==.)
replace msacode=3078 if (metarea==4400) & (msacode==.)
replace msacode=3490 if (metarea==7360) & (msacode==.)
replace msacode=3108 if (metarea==4480) & (msacode==.)
replace msacode=3108 if (metarea==4481) & (msacode==.)
replace msacode=1974 if (metarea==2080) & (msacode==.)
replace msacode=1974 if (metarea==2081) & (msacode==.)
replace msacode=1486 if (metarea==1160) & (msacode==.)
replace msacode=2554 if (metarea==3284) & (msacode==.)
replace msacode=1966 if (metarea==5960) & (msacode==.)
replace msacode=3310 if (metarea==5000) & (msacode==.)
replace msacode=1058 if (metarea==160) & (msacode==.)
replace msacode=1154 if (metarea==460) & (msacode==.)
replace msacode=1202 if (metarea==521) & (msacode==.)
replace msacode=1446 if (metarea==1120) & (msacode==.)
replace msacode=1446 if (metarea==1121) & (msacode==.)
replace msacode=1446 if (metarea==1122) & (msacode==.)
replace msacode=1662 if (metarea==1480) & (msacode==.)
replace msacode=1686 if (metarea==1560) & (msacode==.)
replace msacode=1698 if (metarea==1600) & (msacode==.)
replace msacode=1698 if (metarea==1601) & (msacode==.)
replace msacode=1714 if (metarea==1641) & (msacode==.)
replace msacode=1746 if (metarea==1680) & (msacode==.)
replace msacode=1746 if (metarea==1681) & (msacode==.)
replace msacode=1798 if (metarea==1800) & (msacode==.)
replace msacode=1910 if (metarea==1920) & (msacode==.)
replace msacode=1910 if (metarea==1921) & (msacode==.)
replace msacode=1938 if (metarea==2000) & (msacode==.)
replace msacode=1982 if (metarea==2160) & (msacode==.)
replace msacode=1982 if (metarea==2161) & (msacode==.)
replace msacode=2134 if (metarea==2310) & (msacode==.)
replace msacode=2434 if (metarea==3000) & (msacode==.)
replace msacode=2466 if (metarea==3120) & (msacode==.)
replace msacode=2486 if (metarea==3160) & (msacode==.)
replace msacode=2554 if (metarea==3284) & (msacode==.)
replace msacode=2642 if (metarea==3361) & (msacode==.)
replace msacode=2642 if (metarea==3360) & (msacode==.)
replace msacode=2690 if (metarea==3480) & (msacode==.)
replace msacode=2870 if (metarea==3660) & (msacode==.)
replace msacode=1298 if (metarea==3720) & (msacode==.)
replace msacode=3142 if (metarea==4680) & (msacode==.)
replace msacode=3154 if (metarea==4720) & (msacode==.)
replace msacode=3334 if (metarea==5080) & (msacode==.)
replace msacode=3334 if (metarea==5081) & (msacode==.)
replace msacode=3346 if (metarea==5120) & (msacode==.)
replace msacode=3798 if (metarea==6161) & (msacode==.)
replace msacode=3890 if (metarea==6400) & (msacode==.)
replace msacode=3890 if (metarea==6401) & (msacode==.)
replace msacode=3958 if (metarea==6640) & (msacode==.)
replace msacode=4162 if (metarea==7160) & (msacode==.)
replace msacode=4266 if (metarea==7600) & (msacode==.)
replace msacode=4266 if (metarea==7601) & (msacode==.)
replace msacode=4406 if (metarea==7840) & (msacode==.)
replace msacode=4790 if (metarea==8840) & (msacode==.)
replace msacode=4790 if (metarea==8841) & (msacode==.)
replace msacode=1074 if (metarea==200) & (msacode==.)
replace msacode=3562 if (metarea==5600) & (msacode==.)
replace msacode=3562 if (metarea==5601) & (msacode==.)
replace msacode=1714 if (metarea==1640) & (msacode==.)
replace msacode=3798 if (metarea==6160) & (msacode==.)
replace msacode=2542 if (metarea==3240) & (msacode==.)

drop _merge metarea

* Merge Uber entry with ATUS on MSA
merge m:1 msacode year using "$root/data/derived/uber_entry_msa_clean.dta"
* ATUS observations in MSAs with no Uber entry have _merge==1
* MSAs with no ATUS observations have _merge==2
* Remove observations whose metropolitan area status is "Nonmetropolitan" or 
* "Not identified" (metro==4 or metro==5).
keep if (_merge==3)|(inlist(metro, 1, 2, 3))

* Keep only full-time employees of working age in the Uber sample who report
* commuting for at least one minute in ATUS. Remove commute outliers.
drop if msacode == .
keep if empstat == 1
keep if (age>=16)&(age<=65)
keep if (year>=2009)&(year<=2015)
keep if travel_work > 0
quietly sum travel_work, detail
keep if travel_work <= `r(p99)'
replace uber = 0 if uber==.

label variable food_preparation "Food/drink preparation"
label variable sleep "Sleep"
label variable travel_work "Commute"

* Clean health indicators
replace rested = . if rested == 99
replace rested = 2 if rested <= 2
replace rested = 1 if rested > 2
replace highbp = . if highbp == 99
replace painmed = . if painmed == 99

save "$root/data/derived/commute_cleaned.dta", replace

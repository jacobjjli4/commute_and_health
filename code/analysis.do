/*******************************************************************************
Title:		 	ECO481 Final Paper Data Analysis Script
Authors:	 	Jia Jun (Jacob) Li, 1006824750
Date Created:	November 17, 2023
Date Updated:	November 17, 2023

Stata Version:	17.0 BE
Stata Packages:	estout (http://fmwww.bc.edu/repec/bocode/e)
				binscatter (http://fmwww.bc.edu/repec/bocode/b)
				setroot (http://fmwww.bc.edu/repec/bocode/s)
				
Description:	Do-file to perform OLS and IV estimation and generate figures/
				tables for Commuting and Health project.
*******************************************************************************/
clear all
set linesize 240
setroot
capture mkdir "$root/results"
use "$root/data/derived/commute_cleaned.dta", clear

* 1. SUMMARY STATISTICS ****************************************
estpost summarize travel_work sleep participate_exercise food_preparation rested highbp painmed

esttab . using "$root/results/sum_stat.tex", ///
	cells("mean(fmt(%9.2f)) sd(fmt(%9.2f)) min(fmt(%9.2f)) max(fmt(%9.2f))") ///
	label nomtitle nonumber replace

* Generate histogram of commute duration
hist travel_work
graph export "$root/results/hist_travel_work.png", replace

* Get how many MSAs have Uber and how many MSAs are in my data
preserve
collapse (max) uber, by(msacode year)
graph bar (sum) uber, over(year) ytitle("Count of MSAs with Uber")
graph export "$root/results/uber_entry.png", replace

collapse (max) uber, by(msacode)
count if uber == 1
yamlout using "$root/results/results.yaml", key(msa_uber) value(`=r(N)') replace
count
yamlout using "$root/results/results.yaml", key(msa_total) value(`=r(N)')
restore

* Get how many observations there are
count
yamlout using "$root/results/results.yaml", key(obs_total) value(`=r(N)')
count if wb_resp == 1
yamlout using "$root/results/results.yaml", key(obs_wb_resp) value(`=r(N)')

* 2. OLS ESTIMATES ****************************************
* Generate binned scatterplots between health indicators and commute duration.
binscatter rested travel_work, xtitle("Commute duration (minutes)") ytitle("Well-rested status") savegraph("$root/results/binscatter_rested_commute") replace
binscatter highbp travel_work, xtitle("Commute duration (minutes)") ytitle("High blood pressure status") savegraph("$root/results/binscatter_highbp_commute") replace
binscatter painmed travel_work, xtitle("Commute duration (minutes)") ytitle("Pain medication status") savegraph("$root/results/binscatter_painmed_commute") replace

* Generate binned scatterplot between health behaviours and commute duration
binscatter sleep travel_work, xtitle("Commute duration (minutes)") ytitle("Sleep duration (minutes)") savegraph("$root/results/binscatter_sleep_commute") replace
binscatter food_preparation travel_work, xtitle("Commute duration (minutes)") ytitle("Food/drink preparation duration (minutes)") savegraph("$root/results/binscatter_food_prep_commute") replace
binscatter participate_exercise travel_work, xtitle("Commute duration (minutes)") ytitle("Exercise duration (minutes)") savegraph("$root/results/binscatter_exercise_commute")replace

graph combine "$root/results/binscatter_rested_commute.gph" "$root/results/binscatter_highbp_commute.gph" "$root/results/binscatter_painmed_commute.gph" "$root/results/binscatter_sleep_commute.gph" "$root/results/binscatter_food_prep_commute.gph" "$root/results/binscatter_exercise_commute.gph"
graph export "$root/results/binscatter_combined.png", replace

* Run and export OLS regressions of health indicators and sleep on commute duration.
label variable rested "Well-rested"
label variable highbp "High BP"
label variable painmed "Pain med."
label variable food_preparation "Food prep."
label variable participate_exercise "Exercise"
eststo reg_rested: reg rested travel_work earnweek i.statefip i.race i.year educyrs [pw=wt06], vce(robust)
eststo reg_highbp: reg highbp travel_work earnweek i.statefip i.race i.year educyrs [pw=wt06], vce(robust)
eststo reg_painmed: reg painmed travel_work earnweek i.statefip i.race i.year educyrs [pw=wt06], vce(robust)
eststo reg_sleep: reg sleep travel_work earnweek i.statefip i.race i.year educyrs [pw=wt06], vce(robust)
eststo reg_food_prep: reg food_preparation travel_work earnweek i.statefip i.race i.year educyrs [pw=wt06], vce(robust)
eststo reg_exercise: reg participate_exercise travel_work earnweek i.statefip i.race i.year educyrs [pw=wt06], vce(robust)

estadd local state_fe "Yes": _all
estadd local year_fe "Yes": _all
estadd local socio_econ_controls "Yes": _all

#delimit ;
esttab reg_* using "$root/results/all_tables.tex", replace
	keep(travel_work)
	wrap booktabs label 
	stats(r2 N state_fe year_fe socio_econ_controls, label("R-squared" "Observations" "State FE" "Year FE" "Socioeconomic controls")) 
	se star(* 0.10 ** 	0.05 *** 0.01);
#delimit cr

* 3. IV ESTIMATION ****************************************
gen ln_earnweek = ln(earnweek)
label variable ln_earnweek "ln weekly earnings"

graph box travel_work [pweight=wt06], over(uber) title("Commute duration by Uber entry status (MSA-year)") ytitle("Commute duration (minutes)")
graph export "$root/results/commute_uber.png", replace

eststo iv_firststage: reg travel_work uber age i.sex i.msasize i.region ln_earnweek [pweight = wt06], cluster(msacode)
estadd scalar fstat `e(F)': iv_firststage

eststo iv_sleep: ivregress 2sls sleep age i.sex i.msasize i.region (travel_work = uber) [pweight = wt06], cluster(msacode)
eststo iv_food: ivregress 2sls food_preparation age i.sex i.msasize i.region (travel_work = uber age) [pweight = wt06], cluster(msacode)
eststo iv_exercise: ivregress 2sls participate_exercise age i.sex i.msasize i.region (travel_work = uber) [pweight = wt06], cluster(msacode)

estadd local msa_pop "Yes": _all
estadd local demographic "Yes": _all
estadd local region "Yes": _all

#delimit ;
esttab iv_* using "$root/results/iv_tables.tex", replace
	keep (travel_work uber)
	wrap booktabs label 
	stats(fstat r2 N msa_pop demographic region, label("First-stage F" "R-squared" "Observations" "MSA population controls" "Demographic controls" "U.S. Region Controls")) 
	se star(* 0.10 ** 	0.05 *** 0.01);
#delimit cr


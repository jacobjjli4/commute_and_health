/*******************************************************************************
Title:		 	ECO481 Final Paper Workflow File
Author:	 		Jia Jun (Jacob) Li, 1006824750
Date Created:	November 15, 2023
Date Updated:	December 10, 2023

Stata Version:	17.0 BE
Stata Packages:	estout (http://fmwww.bc.edu/repec/bocode/e)
				binscatter (http://fmwww.bc.edu/repec/bocode/b)
				setroot (http://fmwww.bc.edu/repec/bocode/s)
				
Description:	Master do-file for the Commuting and Health code. Run entire
				pipeline from data generation, data cleaning, and analysis.
*******************************************************************************/
clear all
set linesize 240

setroot

log using "$root/build_log.log"

* Load data from .dat format provided by IPUMS into .dta format using the IPUMS-
* provided do-file. Save the converted file as commute.dta.
do "$root/code/dat_to_dta.do"

* Clean commute.dta and save as commute_cleaned.dta.
do "$root/code/clean.do"

* Perform the summary, OLs, and IV analysis and generate figures.
do "$root/code/analysis.do"

log close

/*******************************************************************************
Title:		 	ECO481 Final Paper Data Generating Script
Authors:	 	Jia Jun (Jacob) Li, 1006824750
Date Created:	November 17, 2023
Date Updated:	December 10, 2023

Stata Version:	17.0 BE
Stata Packages:	setroot (ttp://fmwww.bc.edu/repec/bocode/e)

Description:	Do-file to convert atus_00003.dat into .dta format and label 
				data using the provided IPUMS Stata command file. 
*******************************************************************************/

clear all
set linesize 240
set more off

clear
quietly infix                            ///
  long    year                  1-5      ///
  double  caseid                6-19     ///
  long    serial                20-26    ///
  long    strata                27-32    ///
  byte    region                33-33    ///
  byte    statefip              34-35    ///
  byte    metro                 36-37    ///
  byte    msasize               38-38    ///
  long    metarea               39-43    ///
  long    county                44-48    ///
  byte    pernum                49-50    ///
  int     lineno                51-53    ///
  double  wt06                  54-70    ///
  double  wt20                  71-85    ///
  int     age                   86-88    ///
  byte    sex                   89-90    ///
  int     race                  91-94    ///
  byte    genhealth             95-96    ///
  int     educyrs               97-99    ///
  byte    empstat               100-101  ///
  int     occ2_cps8             102-105  ///
  int     uhrsworkt             106-109  ///
  double  earnweek              110-116  ///
  byte    wb_resp               117	-118  ///
  byte    rested                119-120  ///
  byte    highbp                121-122  ///
  byte    painmed               123-124  ///
  int     food_preparation      125-128  ///
  int     participate_exercise  129-132  ///
  int     sleep                 133-136  ///
  int     travel_work           137-140  ///
  using `"$root/data/raw/atus_00003.dat"'

replace wt20                 = wt20                 / 1000000
replace earnweek             = earnweek             / 100

format caseid               %14.0f
format wt06                 %17.0g
format wt20                 %15.6f
format earnweek             %7.2f

label var year                 `"Survey year"'
label var caseid               `"ATUS Case ID"'
label var serial               `"Household serial number"'
label var strata               `"Scrambled pseudo primary sampling unit (PSU) collapsed stratum "'
label var region               `"Region"'
label var statefip             `"FIPS State Code"'
label var metro                `"Metropolitan/central city status"'
label var msasize              `"MSA/PMSA size"'
label var metarea              `"Consolidated MSA name"'
label var county               `"FIPS County code"'
label var pernum               `"Person number (general)"'
label var lineno               `"Person line number"'
label var wt06                 `"Person weight, 2006 methodology"'
label var wt20                 `"Person weight, 2020 methodology"'
label var age                  `"Age"'
label var sex                  `"Sex"'
label var race                 `"Race"'
label var genhealth            `"General health"'
label var educyrs              `"Years of education"'
label var empstat              `"Labor force status"'
label var occ2_cps8            `"General occupation category, main job (CPS)"'
label var uhrsworkt            `"Hours usually worked per week"'
label var earnweek             `"Weekly earnings"'
label var wb_resp              `"Well-Being Module Respondent"'
label var rested               `"Well-rested yesterday"'
label var highbp               `"High blood pressure in last five years"'
label var painmed              `"Pain medication yesterday"'
label var food_preparation     `"preparing for food and drink"'
label var participate_exercise `"Participating in sports or exercise"'
label var sleep                `"Sleeping (010101)"'
label var travel_work          `"ACT: Traveling"'

label define strata_lbl 009999 `"Not generated"'
label values strata strata_lbl

label define region_lbl 1 `"Northeast"'
label define region_lbl 2 `"Midwest"', add
label define region_lbl 3 `"South"', add
label define region_lbl 4 `"West"', add
label values region region_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label values statefip statefip_lbl

label define metro_lbl 01 `"Metropolitan, central city"'
label define metro_lbl 02 `"Metropolitan, balance of MSA"', add
label define metro_lbl 03 `"Metropolitan, not identified"', add
label define metro_lbl 04 `"Nonmetropolitan"', add
label define metro_lbl 05 `"Not identified"', add
label values metro metro_lbl

label define msasize_lbl 0 `"Not identified or non-metropolitan"'
label define msasize_lbl 2 `"100,000 - 249,999"', add
label define msasize_lbl 3 `"250,000 - 499,999"', add
label define msasize_lbl 4 `"500,000 - 999,999"', add
label define msasize_lbl 5 `"1,000,000 - 2,499,999"', add
label define msasize_lbl 6 `"2,500,000 - 4,999,999"', add
label define msasize_lbl 7 `"5,000,000+"', add
label values msasize msasize_lbl

label define metarea_lbl 00000 `"Not Identified or NonMetropolitan"'
label define metarea_lbl 00160 `"Albany-Schenectady, NY"', add
label define metarea_lbl 00200 `"Albuquerque-Santa Fe-Las Vegas, NM"', add
label define metarea_lbl 00460 `"Appleton-Oshkosh-Neenah, WI"', add
label define metarea_lbl 00521 `"Atlanta--Athens-Clarke County--Sandy Springs, GA"', add
label define metarea_lbl 01120 `"Boston, MA"', add
label define metarea_lbl 01121 `"Boston-Worchester-Manchester, MS-NH-CT-ME"', add
label define metarea_lbl 01122 `"Boston-Worcester-Providence, MA-RI-NH-CT"', add
label define metarea_lbl 01160 `"Bridgeport-New Haven-Stamford, CT"', add
label define metarea_lbl 01360 `"Cedar Rapids-Iowa City, IA"', add
label define metarea_lbl 01480 `"Charleston-Huntington-Ashland, WV-OH-KY"', add
label define metarea_lbl 01560 `"Chattanooga-Cleveland-Dalton, TN-GA-AL"', add
label define metarea_lbl 01600 `"Chicago-Gary-Kenosha, IL-IN-WI"', add
label define metarea_lbl 01601 `"Chicago-Naperville-Michigan City, IL-IN-WI"', add
label define metarea_lbl 01640 `"Cincinnati-Hamilton, OH-KY-IN"', add
label define metarea_lbl 01641 `"Cincinnati-Middletown-Wilmington, OH-KY-IN"', add
label define metarea_lbl 01680 `"Cleveland-Akron, OH"', add
label define metarea_lbl 01681 `"Cleveland-Akron-Elyria, OH"', add
label define metarea_lbl 01800 `"Columbus-Auburn-Opelika, GA-AL"', add
label define metarea_lbl 01920 `"Dallas-Fort Worth, TX"', add
label define metarea_lbl 01921 `"Dallas-Fort Worth, TX"', add
label define metarea_lbl 02000 `"Dayton-Springfield-Greenville, OH"', add
label define metarea_lbl 02080 `"Denver-Boulder-Greeley, CO"', add
label define metarea_lbl 02081 `"Denver-Aurora-Boulder, CO"', add
label define metarea_lbl 02160 `"Detroit-Ann Arbor-Flint, MI"', add
label define metarea_lbl 02161 `"Detroit-Warren-Flint, MI"', add
label define metarea_lbl 02310 `"El Paso-Las Cruces, TX-NM"', add
label define metarea_lbl 02700 `"Cape Coral-Fort Myers-Naples, FL"', add
label define metarea_lbl 02840 `"Fresno-Madera, CA"', add
label define metarea_lbl 03000 `"Grand Rapids-Muskegon-Holland, MI (part)"', add
label define metarea_lbl 03120 `"Greensboro-Winston-Salem-High Point, NC (part)"', add
label define metarea_lbl 03160 `"Greenville, SC"', add
label define metarea_lbl 03240 `"Harrisburg-York-Lebanon, PA"', add
label define metarea_lbl 03284 `"Hartford-West Hartford, CT"', add
label define metarea_lbl 03360 `"Houston-Galveston-Brazoria, TX"', add
label define metarea_lbl 03361 `"Houston-Baytown-Huntsville, TX (part)"', add
label define metarea_lbl 03720 `"Kalamazoo-Battle Creek-Portage, MI"', add
label define metarea_lbl 03440 `"Huntsville-Decatur, AL"', add
label define metarea_lbl 03480 `"Indianapolis-Anderson-Columbus, IN (part)"', add
label define metarea_lbl 03660 `"Johnson City-Kingsport-Bristol, TN-VA (part)"', add
label define metarea_lbl 04400 `"Little Rock-North Little Rock, AR"', add
label define metarea_lbl 04480 `"Los Angeles-Riverside-Orange County, CA"', add
label define metarea_lbl 04481 `"Los Angeles-Long Beach-Riverside, CA"', add
label define metarea_lbl 04680 `"Macon-Warner-Robins-Fort Valley, GA (part)"', add
label define metarea_lbl 04720 `"Madison-Janesville-Beloit, WI"', add
label define metarea_lbl 05000 `"Miami-Fort Lauderdale, FL"', add
label define metarea_lbl 05080 `"Milwaukee-Racine, WI"', add
label define metarea_lbl 05081 `"Milwaukee-Racine-Waukesha, WI"', add
label define metarea_lbl 05120 `"Minneapolis-St. Paul-St. Cloud, MN-WI (part)"', add
label define metarea_lbl 05160 `"Mobile-Daphne-Fairhope, AL"', add
label define metarea_lbl 05600 `"New York-Northern New Jersey-Long Island, NY-NJ-CT-PA"', add
label define metarea_lbl 05601 `"New York-Newark-Bridgeport, NY-NH-CT-PA"', add
label define metarea_lbl 05960 `"Orlando-Deltona-Daytona Beach, FL"', add
label define metarea_lbl 06160 `"Philadelphia-Wilmington-Atlantic City, PA-NJ-DE-MD"', add
label define metarea_lbl 06161 `"Philadelphia-Camden-Vineland, PA-NJ-DE-MD"', add
label define metarea_lbl 06400 `"Portland-Salem, OR-WA"', add
label define metarea_lbl 06401 `"Portland-Lewiston-South Portland, ME"', add
label define metarea_lbl 06640 `"Raleigh-Durham-Cary, NC (part)"', add
label define metarea_lbl 06920 `"Sacramento-Yolo, CA"', add
label define metarea_lbl 06921 `"Sacramento-Arden-Arcade-Truckee, CA-NV"', add
label define metarea_lbl 07160 `"Salt Lake City-Ogden-Clearfield, UT (part)"', add
label define metarea_lbl 07360 `"San Francisco-Oakland-San Jose, CA"', add
label define metarea_lbl 07600 `"Seattle-Tacoma-Bremerton, WA"', add
label define metarea_lbl 07601 `"Seattle-Tacoma-Olympia, WA"', add
label define metarea_lbl 07800 `"South Bend-Elkhart-Mishawaka, IN-MI"', add
label define metarea_lbl 07840 `"Spokane-Spokane Valley-Coeur d'Alene, WA-ID"', add
label define metarea_lbl 08840 `"Washington-Baltimore, DC-MD-VA-WV"', add
label define metarea_lbl 08841 `"Washington-Baltimore-Northern Virginia, DC-MD-VA-WV"', add
label define metarea_lbl 08780 `"Visalia-Porterville-Hanford, CA"', add
label define metarea_lbl 99998 `"Blank"', add
label define metarea_lbl 99999 `"NIU (Not in universe)"', add
label values metarea metarea_lbl

label define pernum_lbl 01 `"1"'
label define pernum_lbl 02 `"2"', add
label define pernum_lbl 03 `"3"', add
label define pernum_lbl 04 `"4"', add
label define pernum_lbl 05 `"5"', add
label define pernum_lbl 06 `"6"', add
label define pernum_lbl 07 `"7"', add
label define pernum_lbl 08 `"8"', add
label define pernum_lbl 09 `"9"', add
label define pernum_lbl 10 `"10"', add
label define pernum_lbl 11 `"11"', add
label define pernum_lbl 12 `"12"', add
label define pernum_lbl 13 `"13"', add
label define pernum_lbl 14 `"14"', add
label define pernum_lbl 15 `"15"', add
label define pernum_lbl 16 `"16"', add
label values pernum pernum_lbl

label define lineno_lbl 001 `"1"'
label define lineno_lbl 002 `"2"', add
label define lineno_lbl 003 `"3"', add
label define lineno_lbl 004 `"4"', add
label define lineno_lbl 005 `"5"', add
label define lineno_lbl 006 `"6"', add
label define lineno_lbl 007 `"7"', add
label define lineno_lbl 008 `"8"', add
label define lineno_lbl 009 `"9"', add
label define lineno_lbl 010 `"10"', add
label define lineno_lbl 011 `"11"', add
label define lineno_lbl 012 `"12"', add
label define lineno_lbl 013 `"13"', add
label define lineno_lbl 014 `"14"', add
label define lineno_lbl 015 `"15"', add
label define lineno_lbl 016 `"16"', add
label define lineno_lbl 017 `"17"', add
label define lineno_lbl 018 `"18"', add
label define lineno_lbl 019 `"19"', add
label define lineno_lbl 999 `"NIU (Not in universe)"', add
label values lineno lineno_lbl

label define sex_lbl 01 `"Male"'
label define sex_lbl 02 `"Female"', add
label define sex_lbl 99 `"NIU (Not in universe)"', add
label values sex sex_lbl

label define race_lbl 0100 `"White only"'
label define race_lbl 0110 `"Black only"', add
label define race_lbl 0120 `"American Indian, Alaskan Native"', add
label define race_lbl 0130 `"Asian or Pacific Islander"', add
label define race_lbl 0131 `"Asian only"', add
label define race_lbl 0132 `"Hawaiian Pacific Islander only"', add
label define race_lbl 0200 `"White-Black"', add
label define race_lbl 0201 `"White-American Indian"', add
label define race_lbl 0202 `"White-Asian"', add
label define race_lbl 0203 `"White-Hawaiian"', add
label define race_lbl 0210 `"Black-American Indian"', add
label define race_lbl 0211 `"Black-Asian"', add
label define race_lbl 0212 `"Black-Hawaiian"', add
label define race_lbl 0220 `"American Indian-Asian"', add
label define race_lbl 0221 `"American Indian-Hawaiian"', add
label define race_lbl 0230 `"Asian-Hawaiian"', add
label define race_lbl 0300 `"White-Black-American Indian"', add
label define race_lbl 0301 `"White-Black-Asian"', add
label define race_lbl 0302 `"White-Black-Hawaiian"', add
label define race_lbl 0310 `"White-American Indian-Asian"', add
label define race_lbl 0311 `"White-American Indian-Hawaiian"', add
label define race_lbl 0320 `"White-Asian-Hawaiian"', add
label define race_lbl 0330 `"Black-American Indian-Asian"', add
label define race_lbl 0331 `"Black-American Indian-Hawaiian"', add
label define race_lbl 0340 `"Black-Asian-Hawaiian"', add
label define race_lbl 0350 `"American Indian-Asian-Hawaiian"', add
label define race_lbl 0398 `"Other 3 race combinations"', add
label define race_lbl 0399 `"2 or 3 races, unspecified"', add
label define race_lbl 0400 `"White-Black-American Indian-Asian"', add
label define race_lbl 0401 `"White-Black-American Indian-Hawaiian"', add
label define race_lbl 0402 `"White-Black-Asian-Hawaiian"', add
label define race_lbl 0403 `"Black-American Indian-Asian-Hawaiian"', add
label define race_lbl 0404 `"White-American Indian-Asian-Hawaiian"', add
label define race_lbl 0500 `"White-Black-American Indian-Asian-Hawaiian"', add
label define race_lbl 0599 `"4 or 5 races, unspecified"', add
label define race_lbl 9999 `"NIU (Not in universe)"', add
label values race race_lbl

label define genhealth_lbl 01 `"Excellent"'
label define genhealth_lbl 02 `"Very good"', add
label define genhealth_lbl 03 `"Good"', add
label define genhealth_lbl 04 `"Fair"', add
label define genhealth_lbl 05 `"Poor"', add
label define genhealth_lbl 96 `"Refused"', add
label define genhealth_lbl 97 `"Don't know"', add
label define genhealth_lbl 99 `"NIU (Not in universe)"', add
label values genhealth genhealth_lbl

label define educyrs_lbl 100 `"Grades 1-12"'
label define educyrs_lbl 101 `"Less than first grade"', add
label define educyrs_lbl 102 `"First through fourth grade"', add
label define educyrs_lbl 105 `"Fifth through sixth grade"', add
label define educyrs_lbl 107 `"Seventh through eighth grade"', add
label define educyrs_lbl 109 `"Ninth grade"', add
label define educyrs_lbl 110 `"Tenth grade"', add
label define educyrs_lbl 111 `"Eleventh grade"', add
label define educyrs_lbl 112 `"Twelfth grade"', add
label define educyrs_lbl 200 `"College"', add
label define educyrs_lbl 213 `"College--one year"', add
label define educyrs_lbl 214 `"College--two years"', add
label define educyrs_lbl 215 `"College--three years"', add
label define educyrs_lbl 216 `"College--four years"', add
label define educyrs_lbl 217 `"Bachelor's degree"', add
label define educyrs_lbl 300 `"Advanced degree"', add
label define educyrs_lbl 316 `"Master's degree"', add
label define educyrs_lbl 317 `"Master's degree--one year program"', add
label define educyrs_lbl 318 `"Master's degree--two year program"', add
label define educyrs_lbl 319 `"Master's degree--three+ year program"', add
label define educyrs_lbl 320 `"Professional degree"', add
label define educyrs_lbl 321 `"Doctoral degree"', add
label define educyrs_lbl 999 `"NIU (Not in universe)"', add
label values educyrs educyrs_lbl

label define empstat_lbl 01 `"Employed - at work"'
label define empstat_lbl 02 `"Employed - absent"', add
label define empstat_lbl 03 `"Unemployed - on layoff"', add
label define empstat_lbl 04 `"Unemployed - looking"', add
label define empstat_lbl 05 `"Not in labor force"', add
label define empstat_lbl 99 `"NIU (Not in universe)"', add
label values empstat empstat_lbl

label define occ2_cps8_lbl 0110 `"Management occupations"'
label define occ2_cps8_lbl 0111 `"Business and financial operations occupations"', add
label define occ2_cps8_lbl 0120 `"Computer and mathematical science occupations"', add
label define occ2_cps8_lbl 0121 `"Architecture and engineering occupations"', add
label define occ2_cps8_lbl 0122 `"Life, physical, and social science occupations"', add
label define occ2_cps8_lbl 0123 `"Community and social service occupations"', add
label define occ2_cps8_lbl 0124 `"Legal occupations"', add
label define occ2_cps8_lbl 0125 `"Education, training, and library occupations"', add
label define occ2_cps8_lbl 0126 `"Arts, design, entertainment, sports, and media occupations"', add
label define occ2_cps8_lbl 0127 `"Healthcare practitioner and technical occupations"', add
label define occ2_cps8_lbl 0130 `"Healthcare support occupations"', add
label define occ2_cps8_lbl 0131 `"Protective service occupations"', add
label define occ2_cps8_lbl 0132 `"Food preparation and serving related occupations"', add
label define occ2_cps8_lbl 0133 `"Building and grounds cleaning and maintenance occupations"', add
label define occ2_cps8_lbl 0134 `"Personal care and service occupations"', add
label define occ2_cps8_lbl 0140 `"Sales and related occupations"', add
label define occ2_cps8_lbl 0150 `"Office and administrative support occupations"', add
label define occ2_cps8_lbl 0160 `"Farming, fishing, and forestry occupations"', add
label define occ2_cps8_lbl 0170 `"Construction and extraction occupations"', add
label define occ2_cps8_lbl 0180 `"Installation, maintenance, and repair occupations"', add
label define occ2_cps8_lbl 0190 `"Production occupations"', add
label define occ2_cps8_lbl 0200 `"Transportation and material moving occupations"', add
label define occ2_cps8_lbl 0210 `"Armed Forces"', add
label define occ2_cps8_lbl 9999 `"NIU (Not in universe)"', add
label values occ2_cps8 occ2_cps8_lbl

label define wb_resp_lbl 00 `"No"'
label define wb_resp_lbl 01 `"Yes"', add
label define wb_resp_lbl 99 `"Not an ATUS respondent"', add
label values wb_resp wb_resp_lbl

label define rested_lbl 01 `"Very"'
label define rested_lbl 02 `"Somewhat"', add
label define rested_lbl 03 `"A Little"', add
label define rested_lbl 04 `"Not at all"', add
label define rested_lbl 99 `"NIU (Not in universe)"', add
label values rested rested_lbl

label define highbp_lbl 01 `"Yes"'
label define highbp_lbl 02 `"No"', add
label define highbp_lbl 99 `"NIU (Not in universe)"', add
label values highbp highbp_lbl

label define painmed_lbl 01 `"Yes"'
label define painmed_lbl 02 `"No"', add
label define painmed_lbl 99 `"NIU (Not in universe)"', add
label values painmed painmed_lbl

capture mkdir "$root/data/derived"
save "$root/data/derived/commute.dta", replace

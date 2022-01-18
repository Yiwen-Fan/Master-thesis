//Set up
clear all
set more off

use "C:\Users\Even\Desktop\修論STATA\data merging 2015\data 2015\Demographic_Background.dta"
log using result4, replace
save demobg_after, replace

gen spouseID = regexs(0) if(regexm(ID, "[0-9][0-9][0-9]$"))
encode spouseID, generate(spouseid)
keep if spouseid==1
destring householdID, generate(householdid)

//change it real birth year
gen birthyear=ba004_w3_1
replace birthyear= ba002_1 if ba002==2

//marital status
gen mari_status=0
replace mari_status=1 if be001==1 | be001 == 2 | be001 == 7

keep householdid birthyear mari_status 


log close

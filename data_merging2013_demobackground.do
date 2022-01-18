//Set up
clear all
set more off


cd "C:\Users\Even\Desktop\修論STATA\data merging 2013"
use "C:\Users\Even\Desktop\修論STATA\data merging 2013\data 2013\Demographic_Background.dta"
log using result1, replace
save demobg_after, replace

gen spouseID = regexs(0) if(regexm(ID, "[0-9][0-9][0-9]$"))
encode spouseID, generate(spouseid)
keep if spouseid==1
destring householdID, generate(householdid)
recast double householdid

//marital status
gen mari_status=0
replace mari_status=1 if be001==1 | be001 == 2 | be001 == 7



gen birthyear=zba002_1 if ba001_w2_1==1&xrtype==2
replace birthyear=zba002_1 if ba001_w2_1==.&xrtype==2
replace birthyear=ba002_1 if ba001_w2_1==2 | xrtype==1


keep householdid mari_status birthyear 


log close

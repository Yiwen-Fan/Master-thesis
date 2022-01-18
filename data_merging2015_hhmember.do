//Set up
clear all
set more off
cd "C:\Users\Even\Desktop\修論STATA\data merging 2015"
log using result2, replace
import delimited CHARLS2015r_household_member2
save hh_member_after, replace


//Variables
keep householdid member_type_r
gen cores=0
foreach i of num 1/12{
        bysort householdid: replace cores=1 if member_type_r[`i'] == 4
		 }
drop if cores == 1

keep if member_type_r == 1

//keep id 

log close

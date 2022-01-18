//Set up
clear all
set more off

cd "C:\Users\Even\Desktop\修論STATA\data merging 2011"
log using result6, replace
use "C:\Users\Even\Desktop\修論STATA\data merging 2011\data 2011\child.dta" 
save child_after, replace

destring householdID, generate(householdid)
destring ID, generate(id)
replace householdid=householdid*10
recast double householdid
 
keep id householdid childID cb053 cb069

gen liveapart=1
replace liveapart=0 if cb053==.|cb053==1|cb053==2
replace liveapart=0 if cb069==.
bysort householdid : egen liveapartnum=total(liveapart) 
sort householdid childID

//income
replace cb069=0 if cb069==1
replace cb069=1000 if cb069==2
replace cb069=3500 if cb069==3
replace cb069=7500 if cb069==4
replace cb069=15000 if cb069==5
replace cb069=35000 if cb069==6
replace cb069=75000 if cb069==7
replace cb069=125000 if cb069==8
replace cb069=175000 if cb069==9
replace cb069=250000 if cb069==10
replace cb069=0 if cb069==11
bysort householdid : egen totalincome=total(cb069) if liveapart==1
gen ave_inc=totalincome/liveapartnum

drop if ave_inc==.
by householdid: gen order=[_n]
keep if order==1
keep householdid liveapartnum totalincome ave_inc


log close

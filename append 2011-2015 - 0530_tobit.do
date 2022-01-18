//Set up
clear all
set more off


cd "C:\Users\Even\Desktop\修論STATA\panel data 2011-2015_0530"
log using append_result_0530, replace

use merging_result2011_0522_6.dta  
append using merging_result2013_0522_6.dta  
save append_0530_1.dta, replace


use append_0530_1.dta
append using merging_result2015_0522_6.dta
sort householdid year
save append_0530_2.dta, replace

//drop if totalincome==0
//drop if allreceive_total==0
//drop if total_visit==0

by householdid: gen nyear=[_N]
keep if nyear == 3
save append_0530_3.dta, replace

sum householdid year allincome spouse_allincome indv_pension spouse_pension birthyear mari_status allreceive_total allgive_total nettrsf ave_mt max total_visit total_contact livewith total_distance liveapartnum totalincome ave_inc contact_num visit_num

log close

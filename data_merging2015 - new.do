//Set up
clear all
set more off


cd "C:\Users\Even\Desktop\修論STATA\data merging 2015"
log using merging_result2015_0522, replace

use demobg_after, clear 
sort householdid
save merging_result2015_0522, replace

use family_transfer_after, clear
sort householdid
merge 1:1 householdid using merging_result2015_0522
drop if _merge !=3
drop _merge

save merging_result2015_0522_2, replace
//

use merging_result2015_0522_2, clear 
sort householdid
save merging_result2015_0522_2, replace

use family_info&timetrsf_after_2, clear
sort householdid

merge 1:1 householdid using merging_result2015_0522_2
drop if _merge !=3
drop _merge

save merging_result2015_0522_3, replace
//

use merging_result2015_0522_3, clear
sort householdid
save merging_result2015_0522_3, replace


use indvincome_after, clear 
sort householdid

merge 1:1 householdid using merging_result2015_0522_3
drop if _merge !=3
drop _merge

save merging_result2015_0522_4, replace
//

use merging_result2015_0522_4, clear
sort householdid
save merging_result2015_0522_4, replace


use work&pension_after, clear 
sort householdid

merge 1:1 householdid using merging_result2015_0522_4
drop if _merge !=3
drop _merge

save merging_result2015_0522_5, replace

//
use merging_result2015_0522_5, clear
sort householdid
save merging_result2015_0522_5, replace


use child_after, clear 
sort householdid

merge 1:1 householdid using merging_result2015_0522_5
drop if _merge !=3
drop _merge

save merging_result2015_0522_6, replace

//
gen year=2015


gen allincome=indv_income+otherincome
gen spouse_allincome=spouse_income+spouse_otherincome


keep householdid year allincome spouse_allincome indv_pension spouse_pension birthyear mari_status allreceive_total allgive_total nettrsf ave_mt max total_visit total_contact livewith total_distance liveapartnum totalincome ave_inc contact_num visit_num

log close




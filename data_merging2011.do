//Set up
clear all
set more off


cd "C:\Users\Even\Desktop\修論STATA\data merging 2011"
log using merging_result2011, replace

use demobg_after, clear 
sort householdid
save merging_result2011, replace

use family_transfer_after, clear
sort householdid
merge 1:1 householdid using merging_result2011
drop if _merge !=3
drop _merge

save merging_result2011_2, replace
//

use merging_result2011_2, clear 
sort householdid
save merging_result2011_2, replace

use family_info&timetrsf_after, clear
sort householdid

merge 1:1 householdid using merging_result2011_2
drop if _merge !=3
drop _merge

save merging_result2011_3, replace
//

use merging_result2011_3, clear
sort householdid
save merging_result2011_3, replace


use parent_income_after, clear 
sort householdid

merge 1:1 householdid using merging_result2011_3
drop if _merge !=3
drop _merge

save merging_result2011_4, replace
//

use merging_result2011_4, clear
sort householdid
save merging_result2011_4, replace


use work&pension_after, clear 
sort householdid

merge 1:1 householdid using merging_result2011_4
drop if _merge !=3
drop _merge

save merging_result2011_5, replace

//
gen year=2011


gen allincome=indv_income+otherincome
gen spouse_allincome=spouse_income+spouse_otherincome


keep householdid year allincome spouse_allincome indv_pension spouse_pension birthyear mari_status working_num allreceive_total allgive_total total_visit total_contact aver_visit aver_contact nettrsf aver_inc livewith total_distance aver_distance

log close




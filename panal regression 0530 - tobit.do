//Set up
clear all
set more off

cd "C:\Users\Even\Desktop\修論STATA\panel data 2011-2015_0530"
log using panel_regression_tobit_0530, replace


use append_0530_3
sort householdid year
xtset householdid year


recast double ave_inc 
recast double allreceive_total
recast double nettrsf
recast double allincome
recast double spouse_allincome
recast double mari_status
recast double total_distance
gen ave_visit=total_visit/liveapartnum
gen ave_contact=total_contact/liveapartnum
recast double ave_visit 
recast double ave_contact


xtsum householdid year allincome spouse_allincome indv_pension spouse_pension birthyear mari_status allreceive_total allgive_total nettrsf ave_mt max total_visit total_contact livewith total_distance liveapartnum totalincome ave_inc contact_num visit_num

gen d2013=0 
replace d2013=1 if year==2013

gen d2015=0
replace d2015=1 if year==2015

gen age=2020-birthyear

keep if liveapartnum==max
keep if max==visit_num
keep if visit_num==contact_num

//drop if allreceive_total==0
//drop if total_visit==0

//drop if livewith==1

egen parents_income=rowtotal(allincome spouse_allincome indv_pension spouse_pension)



//tobit 


tobit allreceive_total totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum age d2013 d2015 total_distance, ll(0)
estimates store model1

tobit nettrsf totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum age d2013 d2015 total_distance, ll(0)
estimates store model2

tobit total_visit totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum age d2013 d2015 total_distance, ll(0)
estimates store model3

tobit total_contact totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum age d2013 d2015 total_distance, ll(0)
estimates store model4


//
tobit allreceive_total totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum d2013 d2015 total_distance, ll(0)
estimates store model5

tobit nettrsf totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum d2013 d2015 total_distance, ll(0)
estimates store model6

tobit total_visit totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum d2013 d2015 total_distance, ll(0)
estimates store model7

tobit total_contact totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum d2013 d2015 total_distance, ll(0)
estimates store model8


tobit  allreceive_total totalincome parents_income liveapartnum age d2013 d2015 total_distance, ll(0)
estimates store model9

tobit  total_visit totalincome parents_income liveapartnum age d2013 d2015 total_distance, ll(0)
estimates store model10

tobit  total_contact totalincome parents_income liveapartnum age d2013 d2015 total_distance, ll(0)
estimates store model11

//
tobit  allreceive_total totalincome parents_income liveapartnum d2013 d2015 total_distance, ll(0)
estimates store model12

tobit  total_visit totalincome parents_income liveapartnum d2013 d2015 total_distance, ll(0)
estimates store model13

tobit  total_contact totalincome parents_income liveapartnum d2013 d2015 total_distance, ll(0)
estimates store model14


tobit allreceive_total totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum total_contact age d2013 d2015 total_distance, ll(0)
estimates store model15

tobit total_visit totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum total_contact age d2013 d2015 total_distance, ll(0)
estimates store model16



//

tobit allreceive_total totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum total_contact d2013 d2015 total_distance, ll(0)
estimates store model17

tobit total_visit totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum total_contact d2013 d2015 total_distance, ll(0)
estimates store model18

tobit allreceive_total totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum total_contact d2013 d2015, ll(0)
estimates store model19

tobit total_visit totalincome allincome spouse_allincome indv_pension spouse_pension liveapartnum total_contact d2013 d2015, ll(0)
estimates store model20



esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 model10 model11 model12 model13 model14 model15 model16 model17 model18 model19 model20 using result00617_tobit, star(* .1 ** .05 *** .01) csv

log close

//Set up
clear all
set more off

cd "C:\Users\Even\Desktop\修論STATA\data merging 2013"
use "C:\Users\Even\Desktop\修論STATA\data merging 2013\data 2013\Family_Transfer.dta" 
log using result4, replace
save family_transfer_after, replace

destring householdID, generate(householdid)
recast double householdid

gen ce009_1_12_=.
gen ce009_1_13_=.
gen ce009_1_14_=.

gen ce009_3_12_=.
gen ce009_3_13_=.
gen ce009_3_14_=.


gen mon_num=0
gen enum1=1
foreach i of num 1/15 {
replace mon_num=mon_num+enum1 if ce009_1_`i'_!=.

}

gen inkind_num=0
gen enum2=1
foreach i of num 1/15 {
replace inkind_num=inkind_num+enum2 if ce009_3_`i'_!=.

}


egen allreceive_total = rowtotal(ce009_1_1_ ce009_1_2_/*
*/ ce009_1_3_ ce009_1_4_ ce009_1_5_ ce009_1_6_ ce009_1_7_ ce009_1_8_ ce009_1_9_ ce009_1_10_ ce009_1_11_ ce009_1_15_ /*
*/ ce009_3_1_ ce009_3_2_ ce009_3_3_ ce009_3_4_ ce009_3_5_ ce009_3_6_ ce009_3_7_ ce009_3_8_ ce009_3_9_ ce009_3_10_ ce009_3_11_ ce009_3_15_)


egen allgive_total = rowtotal( ce029_1_1_ ce029_1_2_  ce029_1_3_ ce029_1_4_ ce029_1_5_ ce029_1_6_ ce029_1_7_ ce029_1_8_ ce029_1_9_ ce029_1_10_ ce029_1_11_ ce029_1_15_/*
*/ ce029_3_1_ ce029_3_2_ ce029_3_3_ ce029_3_4_ ce029_3_5_ ce029_3_6_ ce029_3_7_ ce029_3_8_ ce029_3_9_ ce029_3_10_ ce029_3_11_ ce029_3_15_)

gen nettrsf = allreceive_total - allgive_total


egen max = rowmax(mon_num inkind_num)
replace allreceive_total=0 if max==0
gen ave_mt=allreceive_total/max


keep householdid allreceive_total allgive_total nettrsf ave_mt max

log close

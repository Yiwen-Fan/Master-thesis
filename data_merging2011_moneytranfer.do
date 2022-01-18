//Set up
clear all
set more off

cd "C:\Users\Even\Desktop\修論STATA\data merging 2011"
use "C:\Users\Even\Desktop\修論STATA\data merging 2011\data 2011\family_transfer.dta" 
log using result4, replace
save family_transfer_after, replace

destring householdID, gen(householdid)
replace householdid=householdid*10
recast double householdid

//name inteval
foreach i of num 1/10 {
replace ce009_`i'_1_every=12 if ce009_`i'_1_every==1
}

foreach i of num 1/10 {
replace ce009_`i'_1_every=4 if ce009_`i'_1_every==2
}

foreach i of num 1/10 {
replace ce009_`i'_1_every=2 if ce009_`i'_1_every==3
}

foreach i of num 1/10 {
replace ce009_`i'_1_every=1 if ce009_`i'_1_every==4
}

//

foreach i of num 1/10 {
replace ce009_`i'_2_every=12 if ce009_`i'_2_every==1
}

foreach i of num 1/10 {
replace ce009_`i'_2_every=4 if ce009_`i'_2_every==2
}

foreach i of num 1/10 {
replace ce009_`i'_2_every=2 if ce009_`i'_2_every==3
}

foreach i of num 1/10 {
replace ce009_`i'_2_every=1 if ce009_`i'_2_every==4
}

//regular monetary

foreach i of num 1/10 {
replace ce009_`i'_1=2/0 if ce009_`i'_1<0
}

gen re_monetary1=ce009_1_1*ce009_1_1_every
gen re_monetary2=ce009_2_1*ce009_2_1_every
gen re_monetary3=ce009_3_1*ce009_3_1_every
gen re_monetary4=ce009_4_1*ce009_4_1_every
gen re_monetary5=ce009_5_1*ce009_5_1_every
gen re_monetary6=ce009_6_1*ce009_6_1_every
gen re_monetary7=ce009_7_1*ce009_7_1_every
gen re_monetary8=ce009_8_1*ce009_8_1_every
gen re_monetary9=ce009_9_1*ce009_9_1_every
gen re_monetary10=ce009_10_1*ce009_10_1_every


gen re_mon_num=0
gen enum1=1
foreach i of num 1/10 {
replace re_mon_num=re_mon_num+enum1 if re_monetary`i'!=.

}


egen re_monetary=rowtotal(re_monetary1 re_monetary2 re_monetary3 re_monetary4 re_monetary5 re_monetary6 re_monetary7 re_monetary8 re_monetary9 re_monetary10)

//regular inkind
foreach i of num 1/10 {
replace ce009_`i'_2=2/0 if ce009_`i'_2<0
}

gen re_inkind1=ce009_1_2*ce009_1_2_every
gen re_inkind2=ce009_2_2*ce009_2_2_every
gen re_inkind3=ce009_3_2*ce009_3_2_every
gen re_inkind4=ce009_4_2*ce009_4_2_every
gen re_inkind5=ce009_5_2*ce009_5_2_every
gen re_inkind6=ce009_6_2*ce009_6_2_every
gen re_inkind7=ce009_7_2*ce009_7_2_every
gen re_inkind8=ce009_8_2*ce009_8_2_every
gen re_inkind9=ce009_9_2*ce009_9_2_every
gen re_inkind10=ce009_10_2*ce009_10_2_every

gen re_inkind_num=0
gen enum2=1
foreach i of num 1/10 {
replace re_inkind_num=re_inkind_num+enum2 if re_inkind`i'!=.

}

egen re_inkind=rowtotal(re_inkind1 re_inkind2 re_inkind3 re_inkind4 re_inkind5 re_inkind6 re_inkind7 re_inkind8 re_inkind9 re_inkind10)

//

foreach i of num 1/10 {
replace ce009_`i'_3=2/0 if ce009_`i'_3<0
}

foreach i of num 1/10 {
replace ce009_`i'_4=2/0 if ce009_`i'_4<0
}

gen non_mon_num=0
gen enum3=1
foreach i of num 1/10 {
replace non_mon_num=non_mon_num+enum3 if ce009_`i'_3!=.

}


gen non_inkind_num=0
gen enum4=1
foreach i of num 1/10 {
replace non_inkind_num=non_inkind_num+enum4 if ce009_`i'_4!=.

}

 
egen non_monetary=rowtotal(ce009_1_3 ce009_2_3 ce009_3_3 ce009_4_3 ce009_5_3 ce009_6_3 ce009_7_3 ce009_8_3 ce009_9_3 ce009_10_3)


egen non_inkind=rowtotal(ce009_1_4 ce009_2_4 ce009_3_4 ce009_4_4 ce009_5_4 ce009_6_4 ce009_7_4 ce009_8_4 ce009_9_4 ce009_10_4)


//
gen allreceive_total=2/0
replace allreceive_total=0 if ce007==1
replace allreceive_total=. if ce007==.

replace allreceive_total = re_monetary+re_inkind+non_monetary+non_inkind


//name inteval
foreach i of num 1/10 {
replace ce029_`i'_1_every=12 if ce029_`i'_1_every==1
}

foreach i of num 1/10 {
replace ce029_`i'_1_every=4 if ce029_`i'_1_every==2
}

foreach i of num 1/10 {
replace ce029_`i'_1_every=2 if ce029_`i'_1_every==3
}

foreach i of num 1/10 {
replace ce029_`i'_1_every=1 if ce029_`i'_1_every==4
}

foreach i of num 1/10 {
replace ce029_`i'_2_every=12 if ce029_`i'_2_every==1
}

foreach i of num 1/10 {
replace ce029_`i'_2_every=4 if ce029_`i'_2_every==2
}

foreach i of num 1/10 {
replace ce029_`i'_2_every=2 if ce029_`i'_2_every==3
}

foreach i of num 1/10 {
replace ce029_`i'_2_every=1 if ce029_`i'_2_every==4
}

//regular monetary
foreach i of num 1/10 {
replace ce029_`i'_1=2/0 if ce029_`i'_1<0
}

gen re_monetary11=ce029_1_1*ce029_1_1_every
gen re_monetary12=ce029_2_1*ce029_2_1_every
gen re_monetary13=ce029_3_1*ce029_3_1_every
gen re_monetary14=ce029_4_1*ce029_4_1_every
gen re_monetary15=ce029_5_1*ce029_5_1_every
gen re_monetary16=ce029_6_1*ce029_6_1_every
gen re_monetary17=ce029_7_1*ce029_7_1_every
gen re_monetary18=ce029_8_1*ce029_8_1_every
gen re_monetary19=ce029_9_1*ce029_9_1_every
gen re_monetary20=ce029_10_1*ce029_10_1_every

egen re_monetaryg=rowtotal(re_monetary11 re_monetary12 re_monetary13 re_monetary14 re_monetary15 re_monetary16 re_monetary17 re_monetary18 re_monetary19 re_monetary20)

//regular inkind
foreach i of num 1/10 {
replace ce009_`i'_2=2/0 if ce009_`i'_2<0
}

gen re_inkind11=ce029_1_2*ce029_1_2_every
gen re_inkind12=ce029_2_2*ce029_2_2_every
gen re_inkind13=ce029_3_2*ce029_3_2_every
gen re_inkind14=ce029_4_2*ce029_4_2_every
gen re_inkind15=ce029_5_2*ce029_5_2_every
gen re_inkind16=ce029_6_2*ce029_6_2_every
gen re_inkind17=ce029_7_2*ce029_7_2_every
gen re_inkind18=ce029_8_2*ce029_8_2_every
gen re_inkind19=ce029_9_2*ce029_9_2_every
gen re_inkind20=ce029_10_2*ce029_10_2_every

egen re_inkindg=rowtotal(re_inkind11 re_inkind12 re_inkind13 re_inkind14 re_inkind15 re_inkind16 re_inkind17 re_inkind18 re_inkind19 re_inkind20)

//

foreach i of num 1/10 {
replace ce029_`i'_3=2/0 if ce029_`i'_3<0
}
foreach i of num 1/10 {
replace ce029_`i'_4=2/0 if ce009_`i'_4<0
}

egen non_monetaryg=rowtotal(ce029_1_3 ce029_2_3 ce029_3_3 ce029_4_3 ce029_5_3 ce029_6_3 ce029_7_3 ce029_8_3 ce029_9_3 ce029_10_3)


egen non_inkindg=rowtotal(ce029_1_4 ce029_2_4 ce029_3_4 ce029_4_4 ce029_5_4 ce029_6_4 ce029_7_4 ce029_8_4 ce029_9_4 ce029_10_4)


//
gen allgive_total=2/0
replace allgive_total=0 if ce027==2
replace allgive_total=re_monetaryg+re_inkindg+non_monetaryg+non_inkindg if ce027==1

//keep householdid allreceive_total allgive_total re_monetaryg re_inkindg non_monetaryg non_inkindg

gen nettrsf = allreceive_total - allgive_total

//keep householdid allreceive_total allgive_total nettrsf


egen max = rowmax(re_mon_num non_mon_num re_inkind_num non_inkind_num)
gen ave_mt=allreceive_total/max

keep householdid allreceive_total allgive_total nettrsf ave_mt max

log close

//Set up
clear all
set more off

cd "C:\Users\Even\Desktop\修論STATA\data merging 2013"
use "C:\Users\Even\Desktop\修論STATA\data merging 2013\data 2013\Individual_Income.dta" 
log using result3, replace
save indvincome_after, replace


destring ID, generate(id)
destring householdID, generate(householdid)
recast double householdid

//adjust indvincome
replace ga002_1=0 if ga001==2
replace ga002_1=12*ga002_2 if missing(ga002_1)&ga001==1
replace ga002_1=(ga002_bracket_min+ga002_bracket_max)/2 if missing(ga002_1)&missing(ga002_2)

//excluded income
gen ex_income=.
replace ex_income=0 if ga002_w2_1==2
replace ex_income=ga002_w2_2a if ga002_w2_1==1&missing(ga002_w2_2b)&missing(ga002_w2_2c)&ga002_w2_1==1
replace ex_income=ga002_w2_2b*12 if ga002_w2_1==1&missing(ga002_w2_2a)&missing(ga002_w2_2c)&ga002_w2_1==1
replace ex_income=ga002_w2_2c*ga002_1 if ga002_w2_1==1&missing(ga002_w2_2b)&missing(ga002_w2_2a)&ga002_w2_1==1


//total income
gen indv_income=0
replace indv_income=ga002_1+ex_income if ex_income!=.
replace indv_income=ga002_1 if ex_income==.

//total indv pension 
foreach i of num 1/9 {
replace ga004_`i'_=1 if ga004_`i'_==1
}

foreach i of num 1/9 {
replace ga004_`i'_=12 if ga004_`i'_==2
}

gen indv_pension=0
replace indv_pension=0 if ga003s10==10  
egen indv_pension_year=rowtotal(ga004_1_1_ ga004_1_2_ ga004_1_3_ ga004_1_4_ ga004_1_5_ ga004_1_6_ ga004_1_7_ ga004_1_8_ ga004_1_9_)
egen indv_pension_month=rowtotal(ga004_2_1_ ga004_2_2_ ga004_2_3_ ga004_2_4_ ga004_2_5_ ga004_2_6_ ga004_2_7_ ga004_2_8_ ga004_2_9_)

replace indv_pension=indv_pension_year if ga003s10!=10 
replace indv_pension=indv_pension_month*12 if indv_pension_year==0&ga003s10!=10 

by householdid (id), sort: gen num1=_n
by householdid (id), sort: gen spouse_income=0
by householdid (id), sort: replace spouse_income=indv_income[2] if num1[2]==2
by householdid (id), sort: gen num2=_n
by householdid (id), sort: gen spouse_pension=0
by householdid (id), sort: replace spouse_pension=indv_pension[2] if num2[2]==2


gen spouseID = regexs(0) if(regexm(ID, "[0-9][0-9][0-9]$"))
encode spouseID, generate(spouseid)
keep if spouseid==1


keep householdid indv_income spouse_income indv_pension spouse_pension
log close

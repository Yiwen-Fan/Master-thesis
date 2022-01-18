//Set up
clear all
set more off

cd "C:\Users\Even\Desktop\修論STATA\data merging 2015"
use "C:\Users\Even\Desktop\修論STATA\data merging 2015\data 2015\Individual_Income.dta" 
log using result5, replace
save indvincome_after, replace

destring ID, generate(id)
destring householdID, generate(householdid)
recast double householdid

//adjust indvincome
replace ga002=0 if ga001==2
replace ga002=12*ga002_2 if missing(ga002)
replace ga002=(ga002_bracket_min+ga002_bracket_max)/2 if missing(ga002)&missing(ga002_2)

//excluded income
gen ex_income=2/0
replace ex_income=0 if ga002_w2_1==2
replace ex_income=ga002_w2_2a if ga002_w2_1==1&missing(ga002_w2_2b)&missing(ga002_w2_2c)
replace ex_income=ga002_w2_2b*12 if ga002_w2_1==1&missing(ga002_w2_2a)&missing(ga002_w2_2c)
replace ex_income=ga002_w2_2c*ga002 if ga002_w2_1==1&missing(ga002_w2_2b)&missing(ga002_w2_2a)


//total income
egen indv_income=rowtotal(ga002 ex_income)
replace indv_income=ga002+ex_income if ex_income!=.
replace indv_income=ga002 if ex_income==.


//total indv pension 
gen indv_pension=0
egen indv_income2_=rowtotal(ga004_1_ ga004_2_ ga004_3_ ga004_4_ ga004_5_ ga004_6_ ga004_7_ ga004_8_ ga004_9_)  
replace indv_pension=0 if ga003s10==10 
replace indv_pension=indv_income2_ if ga003s10!=10


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

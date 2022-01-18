//Set up
clear all
set more off


cd "C:\Users\Even\Desktop\修論STATA\data merging 2013"
use "C:\Users\Even\Desktop\修論STATA\data merging 2013\data 2013\Work_Retirement_and_Pension.dta" 
log using result5, replace
save work&pension_after, replace

//Variable
destring householdID, generate(householdid)
destring ID, generate(id)
recast double householdid


keep householdid id ID fa001 fa002 fa003 fc001 fc004 fc007 ff002_1 ff003bracket_max ff003bracket_min ff014 ff015bracket_max ff015bracket_min fh010 fh011bracket_max fh011bracket_min fm059 fm056_1 fm056_2


//income1
gen income1=0
replace income1=fc004*fc007 if fc001==1&fc004!=.&fc007!=0

//income2
gen income2=0
replace income2=ff002_1 if ff002_1!=.

//income3 bonus
gen income3=0
replace income3=ff014 if ff014!=.

//income4 company
gen income4=0
replace income4=fh010 if fh010!=.
replace income4=0 if fh010!=.&fh010<0


//income5 partime
gen income5=0
replace income5=fm059*12 if fm059!=.&fm056_1<=2011&fm056_1!=.
replace income5=fm059*(13-fm056_2) if fm059!=.&fm056_1==2012&fm056_1!=.&fm056_2!=.

egen otherincome=rowtotal(income1 income2 income3 income4 income5)

by householdid (id), sort: gen num1=_n
by householdid (id), sort: gen spouse_otherincome=0
by householdid (id), sort: replace spouse_otherincome=otherincome[2] if num1[2]==2


gen spouseID = regexs(0) if(regexm(ID, "[0-9][0-9][0-9]$"))
destring spouseID, generate(spouseid)
keep if spouseid==1

keep householdid otherincome spouse_otherincome
log close

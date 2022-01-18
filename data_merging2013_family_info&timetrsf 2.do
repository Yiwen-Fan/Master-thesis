//Set up
clear all
set more off


cd "C:\Users\Even\Desktop\修論STATA\data merging 2013"
use "C:\Users\Even\Desktop\修論STATA\data merging 2013\data 2013\Family_Information.dta" 
log using result2_2, replace
save family_info&timetrsf_after_2, replace

//Variable
destring householdID, generate(householdid)
recast double householdid

//foreach i of num 1/13 {
//       drop if cb053_`i'_==1 | cb053_`i'_==2
//}


//time transfer_visit
foreach i of num 1/11 {
        replace cd003_`i'_=365 if cd003_`i'_==1
}
foreach i of num 1/11 {
        replace cd003_`i'_=130 if cd003_`i'_==2
}
foreach i of num 1/11 {
        replace cd003_`i'_=52 if cd003_`i'_==3
}
foreach i of num 1/11 {
        replace cd003_`i'_=26 if cd003_`i'_==4
}
foreach i of num 1/11 {
        replace cd003_`i'_=12 if cd003_`i'_==5
}
foreach i of num 1/11 {
        replace cd003_`i'_=4 if cd003_`i'_==6
}
foreach i of num 1/11 {
        replace cd003_`i'_=2 if cd003_`i'_==7
}
foreach i of num 1/11 {
        replace cd003_`i'_=1 if cd003_`i'_==8
}
foreach i of num 1/11 {
        replace cd003_`i'_=0 if cd003_`i'_==9
}
foreach i of num 1/11 {
        replace cd003_`i'_=. if cd003_`i'_==10
}

gen visit_num=0
gen num1=1
foreach i of num 1/11 {
replace visit_num=visit_num+num1 if cd003_`i'_!=.

}


//time transfer_contact 
foreach i of num 1/11 {
        replace cd004_`i'_=365 if cd004_`i'_==1
}
foreach i of num 1/11 {
        replace cd004_`i'_=130 if cd004_`i'_==2
}
foreach i of num 1/11 {
        replace cd004_`i'_=52 if cd004_`i'_==3
}
foreach i of num 1/11 {
        replace cd004_`i'_=26 if cd004_`i'_==4
}
foreach i of num 1/11 {
        replace cd004_`i'_=12 if cd004_`i'_==5
}
foreach i of num 1/11 {
        replace cd004_`i'_=4 if cd004_`i'_==6
}
foreach i of num 1/11 {
        replace cd004_`i'_=2 if cd004_`i'_==7
}
foreach i of num 1/11 {
        replace cd004_`i'_=1 if cd004_`i'_==8
}
foreach i of num 1/11 {
        replace cd004_`i'_=0 if cd004_`i'_==9
}
foreach i of num 1/11 {
        replace cd004_`i'_=. if cd004_`i'_==10
}
gen contact_num=0
gen num2=1
foreach i of num 1/11 {
replace contact_num=contact_num+num2 if cd004_`i'_!=.

}




//distance 

gen livewith=0
foreach i of num 1/11 {
        replace livewith=1 if cb053_`i'_==1 | cb053_`i'_==2
}

foreach i of num 1/11 {
        replace cb053_`i'_=0 if cb053_`i'_==1 | cb053_`i'_==2
}


foreach i of num 1/11 {
        replace cb053_`i'_=1 if cb053_`i'_==3 | cb053_`i'_==4 | cb053_`i'_==5
}

foreach i of num 1/11 {
        replace cb053_`i'_=2 if cb053_`i'_==5 | cb053_`i'_==6
}

foreach i of num 1/11 {
        replace cb053_`i'_=3 if cb053_`i'_==7 
}



//exclude time transfer from who is missing


foreach i of num 1/11 {
        replace cd003_`i'_=. if cb069_`i'_==.
}

foreach i of num 1/11 {
        replace cd004_`i'_=. if cb069_`i'_==.
}

gen enum1=0
foreach i of num 1/11 {
        replace enum1=1 if cd003_`i'_!=.
}


gen enum2=0
foreach i of num 1/11 {
        replace enum2=1 if cd004_`i'_!=.
}

egen total_visit=rowtotal(cd003_1_ cd003_2_ cd003_3_ cd003_4_ cd003_5_ cd003_6_ cd003_7_ cd003_8_ cd003_9_ cd003_10_ cd003_11_)
replace total_visit=2/0 if enum1==0

egen total_contact=rowtotal(cd004_1_ cd004_2_ cd004_3_ cd004_4_ cd004_5_ cd004_6_ cd004_7_ cd004_8_ cd004_9_ cd004_10_ cd004_11_)
replace total_contact=2/0 if enum2==0
    
    
egen total_distance = rowtotal(cb053_1_ cb053_2_ cb053_3_ cb053_4_ cb053_5_ cb053_6_ cb053_7_ cb053_8_ cb053_9_ cb053_10_ cb053_11_)


keep householdid total_visit total_contact livewith total_distance contact_num visit_num
log close

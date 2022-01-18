//Set up
clear all
set more off

cd "C:\Users\Even\Desktop\修論STATA\panel data 2011-2015_0523"
log using panel_regression_0523, replace


use append_0523_good4
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

gen d2013=0 
replace d2013=1 if year==2013

gen d2015=0
replace d2015=1 if year==2015

//keep if liveapartnum==max
//keep if max==visit_num
//keep if visit_num==contact_num

//drop if allreceive_total==0
//drop if total_visit==0


egen parents_income=rowtotal(allincome spouse_allincome indv_pension spouse_pension)
gen age=2019-birthyear


//xtsum allreceive_total total_visit totalincome allincome spouse_allincome indv_pension spouse_pension total_contact total_distance age liveapartnum


//
//xtreg  allreceive_total totalincome allincome spouse_allincome indv_pension spouse_pension total_contact i.year, fe vce(cluster householdid) 
//estimates store MonetaryTransfer


//xtreg  total_visit totalincome allincome spouse_allincome indv_pension spouse_pension total_contact i.year, fe cluster(householdid)
//estimates store NumberofVisits



//esttab MonetaryTransfer NumberofVisits, se b(5) r2 star(* 0.1 ** 0.05 *** 0.01) title(Money and Visits Transfered to Parents) booktabs alignment(D{.}{.}{-1}) nodepvar 

//esttab MonetaryTransfer NumberofVisits using reg5.tex, se b(5) ar2 star(* 0.1 ** 0.05 *** 0.01) booktabs alignment(D{.}{.}{-1}) title(Money and visits transfered to parents) nodepvar coeflabels(totalincome "$\mathit{Total\,Income\,of\,Children}$" allincome "$\mathit{Income\,of\,Respondent}$" spouse_allincome "$\mathit{Income\,of\,Respondent's\,Spouse}$" indv_pension "$\mathit{Compensations\,Respondent\,Received}$" spouse_pension "$\mathit{Compensations\,Respondent's\,Spouse\,Received}$" total_contact "$\mathit{Number\,of\,Contacts}$" _cons "$\mathit{Constant}$") nodepvar

program define xtsum2, eclass

syntax varlist

foreach var of local varlist {
    xtsum `var'

    tempname mat_`var'
    matrix mat_`var' = J(3, 5, .)
    matrix mat_`var'[1,1] = (`r(mean)', `r(sd)', `r(min)', `r(max)', `r(N)')
    matrix mat_`var'[2,1] = (., `r(sd_b)', `r(min_b)', `r(max_b)', `r(n)')
    matrix mat_`var'[3,1] = (., `r(sd_w)', `r(min_w)', `r(max_w)', `r(Tbar)')
    matrix colnames mat_`var'= Mean "Std. Dev." Min Max "N/n/T-bar"
    matrix rownames mat_`var'= `var' " " " "

    local matall `matall' mat_`var'
    local obw `obw' overall between within
}

if `= wordcount("`varlist'")' > 1 {
    local matall = subinstr("`matall'", " ", " \ ",.)
    matrix allmat = (`matall')
    ereturn matrix mat_all = allmat
}
else ereturn matrix mat_all = mat_`varlist'
ereturn local obw = "`obw'"

end

xtsum2 allreceive_total total_visit totalincome allincome spouse_allincome indv_pension spouse_pension total_contact total_distance age liveapartnum
esttab e(mat_all), mlabels(none) labcol2(`e(obw)') varlabels(r2 " " r3 " ") tex


log close


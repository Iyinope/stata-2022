use "C:\Users\isivebukola\Downloads\IceCreamStudy.dta", clear

des
gen wt=.
replace wt= 1824/20 if grade==7
replace wt = 1025/9 if grade==8
replace wt = 1151/11 if grade==9
tab wt


svyset studentid [pweight=wt], strata(grade) vce(linearized) singleunit(missing)
svy linearized: mean spending
*the average mean for spending = $9.14*


gen snew=.
replace snew= 1 if spendinggroup=="more"
replace snew=0 if spendinggroup=="less"
tab snew



svy linearized : proportion snew
*percentage of students spending at least $10 - 45.54%.*


svy linearized : proportion snew, over(grade)
*percentage of students in 7th grade with spending of at least $10 - 15%. percentage of students in 8th grade with spending of at least $10 - 1%. percentage of students in 9th grade with spending of at least $10 - 45.45%.*


svy linearized : total spending, over(grade)
* total spending in dollars of students in 7th grade = $9120 8th grade = $15,830.56 and 9th grade = $11,614.64*




*part 2 - startified cluster sample*
gen wt2=608/8 if grade==7
replace wt2=252/3 if grade==8
replace wt2=403/5 if grade==9
tab wt2


svyset studentid [pweight=wt2], strata(grade) vce(linearized) singleunit(missing)
svy linearized: mean spending
*the average mean for spending = $8.92*




svy: proportion snew
* the percentage of students that spend at least $10 is 43.85% *


svy: proportion snew, over(grade)
* the percentage of students that spend at least $10 in grade 7 - 15%, grade 8 - 1%, grade 9 - 45.45%*


svy: total spending, over(grade)
* total spending in dollars of students in 7th grade = $7600 8th grade = $11,676 and 9th grade = $8,946.6*
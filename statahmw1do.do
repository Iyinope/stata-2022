


clear


log using "C:\Users\isivebukola\Downloads\firststata1.smcl"
import delimited "C:\Users\isivebukola\Downloads\blackdemo.csv", encoding(ISO-8859-9) 
describe
save "C:\Users\isivebukola\Downloads\blackdemok.dta", replace

clear

import delimited "C:\Users\isivebukola\Downloads\Nonblackdemo.txt", encoding(ISO-8859-9) 
describe
save "C:\Users\isivebukola\Downloads\nonblackdemok.dta", replace

append using "C:\Users\isivebukola\Downloads\blackdemok.dta"
describe
save "C:\Users\isivebukola\Downloads\nonblackdemok.dta", replace



clear

import delimited "C:\Users\isivebukola\Downloads\Blackhealth.csv"
describe
save "C:\Users\isivebukola\Downloads\blackhealthk.dta", replace

merge 1:1 id using "C:\Users\isivebukola\Downloads\nonblackdemok.dta"
describe
save "C:\Users\isivebukola\Downloads\blackhealthk.dta", replace


gen BMI=weight/ (height/100) ^2
describe

drop if BMI==.
list

egen BMI_mean=mean(BMI)
list

egen BMI_SD=sd(BMI)
list

gen zBMI=(BMI-BMI_mean)/ BMI_SD

summarize BMI zBMI


save "C:\Users\isivebukola\Downloads\statahmw1dta.dta", replace

log close
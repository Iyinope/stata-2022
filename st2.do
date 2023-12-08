
use "C:\Users\isivebukola\Downloads\statahw1.dta", clear

gen bpgroup=4 if  bpsystol >=160 | bpdiast >=100
replace bpgroup=3 if  bpgroup==. & (bpsystol >=140 | bpdiast >=90)
replace bpgroup=2 if  bpgroup==. & (bpsystol >=120 | bpdiast >=80)
replace bpgroup=1 if  bpgroup==. & (bpsystol <120  & bpdiast <80)
replace bpgroup=. if  bpsystol==. | bpdiast==.




quietly tabulate bpgroup, generate(new_)
tab2  bpgroup new_1
tab2  bpgroup new_2
tab2  bpgroup new_3
tab2  bpgroup new_4

gen normal=1 if  bpsystol<120 &  bpdiast<80
replace normal=0 if normal==.
replace normal=. if  bpsystol==. |  bpdiast==.

gen pre=1 if  bpsystol<140 &  bpdiast<90 & normal==0
replace pre=0 if pre==.
replace pre=. if  bpsystol==. |  bpdiast==.

gen stage1=1 if  bpsystol<160 &  bpdiast<100 & normal==0 & pre==0
replace stage1=0 if stage1==.
replace stage1=. if  bpsystol==. |  bpdiast==.


tab2 new_1 normal
tab2 new_2 pre
tab2 new_3 stage1



sdtest tcresult, by(sex)
* Step 1: equality of variances
* H0: variance (cho in man)  = variance (cho in woman)
* Ha: variance (cho in man) != variance (cho in woman)
* 2*Pr(F < f) = 0.0000 <0.05
* Reject H0; unequal variances.

ttest tcresult, by(sex) unequal
* Step 2: two sample t test
* H0: mean (cho in man)  = mean (cho in woman)
* Ha: mean (cho in man) != mean (cho in woman)
* Pr(|T| > |t|) = 0.0000 <0.05
* Reject H0; mean cho is different between man and woman
* 95%CI of cho for   man: (211.9, 214.5)
* 95%CI of cho for woman: (220.4, 223.1) no overlap




gen hypertension=1 if (bpsystol>=140 &  bpsystol~=.) | ( bpdiast>=90 &  bpdiast~=.)
replace hypertension=0 if hypertension==.
replace hypertension=. if bpsystol==. | bpsystol==.
prtest hypertension == 0.24
* one sample test for binomial proportion
* H0: prevalence of hypertension  = 24%
* Ha: prevalence of hypertension ~= 24%
* Pr(|Z| > |z|) = 0.0000 <0.05
* Reject H0; prevalence of hypertension is sig. different from 24%.
* This prevalence of hypertension from this sample is 42% with 95%CI (41%, 43%) 



gen obese=1 if bmi>=30 & bmi~=.
replace obese=0 if bmi<30
gen hichol=1 if tcresult>=240 & tcresult~=.
replace hichol=0 if tcresult<240
tabulate obese hichol, chi2
* chi square test for association
* H0: there is no association between obese and hichol
* Ha: there is an association between obese and hichol
* Pearson chi2(1) =  28.4963   Pr = 0.000 <0.05
* Reject H0; there is an association between obese and hichol




logit heartatk hichol obese, or
* Mantel-Haenszel test / chi square test
* H0: There is no relationship between high cholesterol and heart attack after controlling for obesity
* Ha: There is a  relationship between high cholesterol and heart attack after controlling for obesity
* p-value = 0.000 <0.05
* Reject H0; there is a relationship between high cholesterol and heart attack after controlling for obesity
* Also OR = 1.72 with 95% CI (1.422, 2.072)
* The odds of heart attack is 1.72 times higher for people with high cholesterol after controlling for obesity.

log close
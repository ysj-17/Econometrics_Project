clear
use "C:\Users\Jason Yoon\Desktop\2016-2017\School\Winter 2017\ECN 140\Empirical Project\traningprogram.dta" 
sum married
tab married
sum hsorged
tab hsorged
sum wkless13
tab wkless13
replace married = 0 if married < 0.5
replace married = 1 if married > 0.5
replace hsorged = 0 if hsorged < 0.5
replace hsorged = 1 if hsorged > 0.5
replace wkless13 = 0 if wkless13 < 0.5
replace wkless13 = 1 if wkless13 > 0.5
gen logearn = log(earn)
hist logearn if training==0, frequency normal
hist logearn if training==1, frequency normal
des
sum
reg logearn training sex married hsorged black hispanic wkless13#afdc
hettest
logit assignmt i.sex##i.married bdate age hsorged black hispanic wkless13#afdc
estat classification
esttab, append wide modelwidth(20)
probit assignmt i.sex##i.married bdate age hsorged black hispanic wkless13#afdc
estat classification
esttab, append wide modelwidth(20)
reg training assignmt i.sex##i.married age hsorged black hispanic i.wkless13#i.afdc
ivregress 2sls logearn (training=assignmt) i.sex##i.married age hsorged black hispanic i.wkless13#i.afdc, vce(robust)
esttab, append wide modelwidth(20)
estat endogenous
estat firststage, forcenonrobust
corr training assignmt

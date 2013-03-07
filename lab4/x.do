/* 	A. Shawn Bandy
	Lab #4 Demo 
	February 12th, 2013
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads";
log using teaching.log , replace;
use "wages";

gen female=0;
replace female = 1 if gender == "female";
gen nonwhite=0;
replace nonwhite = 1 if race == "other";
gen union=0;
replace union = 1 if unionstatus == "union";
replace nonwhite = . if missing(race);
drop female;
drop nonwhite;
drop union;

tabulate gender, gen(gend);
tabulate race, gen(race);
tabulate union, gen(unionstatus);
rename gend1 female;
rename gend2 male;

//removes observations if race is blank
drop if missing(race);

summarize;

regress wage education;
regress wage education exper;
correlate education exper;

//predict must be run after regress and applies to last regression
predict residual, r;

//predicted r's can be used like a regular variable
correlate residual wage, covariance;

//in the interpretation, being female reduced wage by 3.20 dollars
regress wage education exper female;
//notice education did not change from last regression and female and education are not correlate
correlate female education;

//notice race2 was omitted
regress wage education race1 race2;

//create an interaction variable
gen fem_exper = female*exper

save wagesnew.dta, replace;
log close;

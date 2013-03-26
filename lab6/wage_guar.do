cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads\lab6";

use wage_guar.dta;
log using lab6demo.log, replace;


/* L1. The dataset wage_guar.dta contains data on 1,289 individuals interviewed 
in March 1995 for the Current Population Survey (CPS) by the U.S. Census Bureau
This question looks at the determinants of their wages. Create a do file
 wage95cps.do and a log file wage95cpsdlog for this problem. Submit the log file 
with your answers.
a. Create the following variables and then save data as wage95cps.dta
lnwage : defined as the log(wage)
exp_squared : defined as exper squared
college : defined as having education of 16 years or above
some_college : defined as having education of 12 or above but less than 16
no_college : defined as having education of less than 12
female_exp : interact the female and the experience variables
lnexp : defined as the log(exper)
annual_wage : defined as the annual wage if the person works full time at his/her
hourly wage. So, 8 hours a day, 1289 days a year.*/

gen lnwage = ln(wage);
gen exp_squared = exper^2;
gen college = 0;
gen some_college = 0;
gen nocollege = 0;
replace college = 1 if education >= 16;
replace some_college = 1 if (education > 12 & education <16);
replace  nocollege = 1 if education <= 12;
gen female_exp  = female * exper;
gen lnexp = ln(exper);
gen annual_wage = wage * 8 * 300;

/*b. Run the following regressions to look at the determinants of wages. After 
you estimate the first model (i), use the Breusch-Pagan test to test for
 heteroskedasticity. If you find that the errors are heteroskedastic, use robust
 standard errors to correct for heteroskedasticity by re-estimating that model and
then go ahead and use robust standard errors for the rest of the models.
i. Dependent variable: wage; explanatory variables are female nonwhite union education exper
ii. Dependent variable: annual_wage; explanatory variables are female nonwhite union education exper
iii. Dependent variable: lnwage; explanatory variables are female nonwhite union education exper
iv. Dependent variable: lnwage; explanatory variables are female nonwhite union education lnexp
v. Dependent variable: lnwage; explanatory variables are female nonwhite union education exper exp_squared
vi. Dependent variable: lnwage; explanatory variables are female nonwhite union college some_college exper*/

regress wage female nonwhite union education exper;
estat hettest;
regress wage female nonwhite union education exper,r;

regress annual_wage female nonwhite union education exper exp_squared;
estat hettest;
regress annual_wage female nonwhite union education exper exp_squared,r;

regress lnwage  nonwhite union education exper;
estat hettest;
regress lnwage  nonwhite union education exper,r;

regress lnwage female nonwhite education lnexp;
estat hettest;
regress lnwage female nonwhite education lnexp,r;

regress lnwage female nonwhite union education exper exp_squared;
estat hettest;
regress lnwage female nonwhite union education exper exp_squared,r;

regress lnwage female nonwhite union college some_college exper;
estat hettest;
regress lnwage female nonwhite union college some_college exper,r;

/*
reject none
c. Run a regression omitting union and nonwhite from model (vi) from part b. 
This is the restricted model that can be used to test if union and nonwhite are 
jointly significant. Save the RSS as rss_r using ereturn list and the scalar 
command.*/

regress lnwage female college some_college exper,r;
scal rss_r = e(rss);

/*d. Now, run model (vi) from part b again. Save the RSS for this model as rss_u
 using ereturn list and the scalar command.*/
 
regress lnwage female nonwhite union college some_college exper,r;
scal rss_u = e(rss);
/*e. Now, calculate the F-statistic manually using the saved scalars from
 parts c and d the STATA scalar command: sca fstat=… Display the f-statistic
 by typing sca list fstat*/
 
scal fstat = ((rss_r - rss_u)/2)/(rss_u/1289);
scal list;
 

/*f. Run model (vi) from part b again. Use the STATA command test to test for 
joint significance of union and nonwhite in this model.*/

regress lnwage female nonwhite union college some_college exper,r;
test union=nonwhite;

/*g. Now, create a special variable for use in testing if the coefficients on 
college and some_college are the same. This variables is all_college = 
college+some_college*/
gen all_college = 0;
replace all_college = college+some_college;

/*h. Run a regression such that: dependent variable: lnwage; explanatory
 variables are female nonwhite union college all_college exper*/

regress lnwage female nonwhite union college all_college exper;

/*i. Now, run the model (vi) from part b again. Use the STATA command test to 
test whether the coefficients on college and some_college are the same in this 
model.*/

regress lnwage female nonwhite union college some_college exper,r;
test college = some_college;

/*j. Test for multicollinearity of the model (vi) from part b by using the vif
command.*/

vif;

log close;

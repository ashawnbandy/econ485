/* 	A. Shawn Bandy
	Lab #5 Demo 
	February 12th, 2013
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads\lab5";
log using lab5demo.log , replace;

use "wage1lab.dta";

regress wage educ exper tenure nonwhite female married smsa northcen south west construc ndurman trcommpu trade services profserv profocc clerocc servocc profocc;
vif;

corr wage educ exper tenure nonwhite female married smsa northcen south west construc ndurman trcommpu trade services profserv profocc clerocc servocc profocc;



//manually test for homo heteroskadasticity
predict res, r;
gen res2 = res^2;

//regress residuals-squared on the dependent variables
regress res2 educ exper tenure nonwhite female married smsa northcen south west construc ndurman trcommpu trade services profserv profocc clerocc servocc profocc;

//save some scalars from the regression
sca chisquared = e(r2)*e(N);

//recall 'scalar list'
scalar list;

//manually calculate p-value 
sca pvalue = chi2tail(e(df_m),chisquared);

//we reject the null hypothesis, so we have heteroskedasticity
sca list;


disp "Breusch-Pagan test: Chi-Squared = " chisquared ", p-value = " pvalue ";
sca list;

//automatic test - indicates heteroskadasticity
regress wage educ exper tenure nonwhite female married smsa northcen south west construc ndurman trcommpu trade services profserv profocc clerocc servocc profocc;
estat hettest;

//also less common is the white test - does note indeicate heteroskdasticity
regress wage educ exper tenure nonwhite female married smsa northcen south west construc ndurman trcommpu trade services profserv profocc clerocc servocc profocc;
imtest, white;

//go with hetero..city - run regress with r variable at the end
regress wage educ exper tenure nonwhite female married smsa northcen south west construc ndurman trcommpu trade services profserv profocc clerocc servocc profocc,r;

//the following is a post regression command that shows stats that are not automatically reported (including adj_R^2)
ereturn list;

//or e(r2_a) to show it explicitly
display e(r2_a);




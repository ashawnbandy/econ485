/* 	A. Shawn Bandy
	Lab #3 
	February 12th, 2013
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads\lab3";

insheet using "farm SE up to 2000 BEA.csv", names;
log using log3demo.log , replace;

foreach v of varlist fips year* {;
	gen `v'_new=real(`v');
	drop `v';
	rename `v'_new `v';
	};
	
//regress var1 var2
regress year1980 year1981;

log close;

/* 	A. Shawn Bandy
	Lab #2 
	February 7th, 2013
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;


//a
log using pciformatting.log , replace;

//b
cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads\econ485-master\econ485-master\lab2";
insheet using "per capita income 1969 to 2008.csv", names;

//c 
local i = 1969;
foreach v of varlist v*{;
	rename `v' farmse`i';
	local i = `i'+1;
};


//d
save "pci 1969 to 2008", replace;
log close;

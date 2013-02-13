/* 	A. Shawn Bandy
	Lab #2 
	February 7th, 2013
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;


/*a. Creates a log file named pciformatting.log on your flash drive that records all output./*

log using pciformatting.log , replace;


/*b. Imports the file “per capita income 1969 to 2008.csv” and includes the variable names. This data set 
includes information on per capita income for each U.S. county from 1969 to 2008 from the Bureau of Economic 
Analysis (BEA). */

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads\econ485-master\econ485-master\lab2";
insheet using "per capita income 1969 to 2008.csv", names;


/*c. Renames the variables for the per capita income data for each of the years that have been given names 
v1, v2, etc. as pci1969, pci1970, etc. Use the local and foreach v commands as shown in lab. */
local i = 1969;
foreach v of varlist v*{;
	rename `v' farmse`i';
	local i = `i'+1;
};


/*d. Saves the data as “pci 1969 to 2008.dta.”*/
save "pci 1969 to 2008", replace;

log close;

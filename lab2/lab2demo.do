/* 	A. Shawn Bandy
	Lab #1 
	January 31, 2013
*/
/* close previous run do-files */
cap log close

//executes without pausing to paginate
set more 1

//clears variables
clear

//set semi-colon as command line delimiter
#delimit ;

//change directory
cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads";

//a. Create a log file named lab1problemset.log on your flash drive that records all output.
log using lab2.log , replace;

//b.Imports the BEA data from your flash drive
insheet using "Farm SE 7000 BEA.csv", names;

local i = 1969;
foreach v of varlist v*{;
	local i = `i'+1;
	rename `v' farmse`i';
};

foreach v of varlist fips farmse* {;
	gen `v'_new=real(`v');
	drop `v';
	rename `v'_new `v';
	};
	
//label variable <name> <"label">
label variable areaname "county and state";
label variable farmse1970 "farm self employment 1970";
label variable farmse2000 "farm self employment 2000";

twoway scatter farmse1970 farmse2000;

graph export scatter.emf, replace;


twoway (lfit farmse1970 farmse2000)(scatter farmse1970 farmse2000);
graph export scatter2.emf, replace;

//calculate tstat manually
sum farmse1970;
scalar tstat = (r(mean) - 800)/(r(sd) / sqrt(r(N)));


//create pval by manually - sca is short for scalar
sca pval = ttail(r(N),tstat);

//now use ttest 
ttest farmse1970==800;

//always use unpaired unequal
ttest farmse1970= farmse2000, unpaired unequal;

log close;



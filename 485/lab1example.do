/* comments */
// comment line

/* close previous run do-files */
cap log close

//executes without pausing to paginate
set more 1

//clears variables
clear

//set semi-colon as command line delimiter
#delimit ;

//change directory
cd "F:\485";

//create a log with <filename> and replace anything that is there
log using lab1example.log, replace;



//IMPORT

insheet using "farmse7000bea.csv", names;
save farmse7000bea.dta, replace;


destring, replace;

rename year1970 farmse70;
rename year2000 farmse00;

generate perch_farmse7000 = (farmse00 - farmse70) / farmse70 * 100;

keep fips areaname farmse70 farmse00 perch_farmse7000;

order fips areaname perch_farmse7000 farmse70 farmse00;

sort perch_farmse7000;

save farmse_7000, replace;
//order - changes the order variables appear in list

summarize;

summarize farmse70 farmse00 perch_farmse7000, detail;

log close;

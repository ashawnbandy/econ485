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
log using gasmileage.log, replace;

//IMPORT

insheet using "gasmileage.csv", names;
save gasmileage.dta, replace;

keep carline engdispl cityfeguid~l annualfuel~l;	

graph dot cityfeguideconventionalfuel annualfuel1costconventionalfuel;
log close;
destring, replace;

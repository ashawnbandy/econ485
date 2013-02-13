/* 	A. Shawn Bandy
	Lab #2 
	February 7th, 2013
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads\lab2\lab2";


//a. Creates a log file named appalachian1st.log on your flash drive that records all output.
log using lab1problemset.log , replace;

/*b. Imports the file “Appalachian Dataset 1.csv” and includes the variable names. 
//   This data set includes information on counties in thirteen eastern U.S. states that follow 
//   the Appalachian Mountains, including counties within the federally-designated 
//   Appalachian Regional Commission region and those that surround them.
*/
insheet using "Appalachian Dataset 1.csv", names;


//c. Renames the variable emp06 as total_emp06. Note all data variables are from 1990 except for emp06.
rename emp06 total_emp06;

/*d. Changes the labels on the key variables as follows:
Variable Name
New Label
manu_emp
Manufacturing Employment 1990
total_emp
Total Employment 1990
total_emp06
Total Employment 2006
*/
label variable manu_emp "Manufacturing Employment 1990";
label variable total_emp "Total Employment 1990";
label variable total_emp06 "Total Employment 2006";

//e. Creates a new variable pct_manuemp90 which is manu_emp/total_emp*100
generate pct_manuemp90 = manu_emp/total_emp*100;

//f. Creates a new variable which shows the growth rate in total employment between 1990 and 2006, pct_empgrowth9006
generate pct_empgrowth9006 = (total_emp06 - total_emp) / total_emp * 100;


//g. Saves the data as appalachianupdated.dta and summarizes the data.
save appalachianupdated, replace;

/*h. Uses STATA commands to manually calculate the t-statistic to test whether the mean of pct_manuemp90 is different from 20. 
Also calculate the p-value.
*/

sum pct_manuemp90;
scalar tstat = (r(mean) - 20)/(r(sd) / sqrt(r(N)));
scalar list;

//i. Uses the STATA command ttest to test whether the mean of pct_manuemp90 is different from 20.

ttest pct_manuemp90 = 20;

/*j. Uses the STATA command ttest to test whether the mean of total employment in 1990 is statistically 
different from total employment in 2006. Make sure you account for differences in variances as shown in lab.
*/

ttest total_emp = total_emp06, unpaired unequal;

//k. Calculates the correlation coefficient between pct_manuemp90 and pct_empgrowth9006 using correlate.
correlate pct_manuemp90 pct_empgrowth9006;

/*l. Creates a two-way scatterplot between pct_manuemp90 and pct_empgrowth9006 and include a fitted line. 
   Export the graph as manuempfitted.emf.
*/
twoway (lfit pct_manuemp90 pct_empgrowth9006)(scatter pct_manuemp90 pct_empgrowth9006);
graph export manuempfitted.png, replace;
//m. Calculates the covariance between pct_manuemp90 and pct_empgrowth9006 using correlate with the option covariance.
correlate pct_manuemp90 pct_empgrowth9006, covariance;

log close;

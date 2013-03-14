/* 	A. Shawn Bandy
	Lab #4  - L1
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Desktop\econ485-lab4\lab4";
log using arclab1.log , replace;
use "arclab";

/*a. Create a dummy variable, arc that is equal to one if the arc_county variable
 indicates it is an ARC county. Otherwise, non-ARC counties should have a 
 value of zero. This variable will be used to see if there is a difference 
 in employment growth between the ARC and non-ARC counties.*/

 gen arc=1 if arc_county=="ARC";
 replace arc=0 if arc==.;

 /*b. Create a set of dummy variables for each of the 13 states in the ARC region. 
Use tabulate with the prefix state to create these variables. Hint: the state 
variable has the unique names of the 13 states for each county in the dataset.*/

tabulate state, gen(state);

/*c. Create a new variable empgrowth_9006 that is the percent change in employment
 from 1990 to 2006. Use the label command to label this “Percent change in 
 employment from 1990 to 2006”. Make sure you save the data as arcdata1.dta so you
 can use it for the next problem.*/

 gen empgrowth_9006 = (emp06 - emp90) / emp90;
save arcdata_n.dta, replace;

/*d. Use the summarize command to look at the description of the variables in
 this dataset. */
summarize;

/*e. Use the regression command to estimate the following linear
 regression model, under the assumption that college educated people 
 contribute to employment growth: */
regress empgrowth_9006 percoll90;

/*f. What is the estimated slope coefficient for percoll90?
 What is the interpretation of this slope coefficient?
 
 INTERPRETATION
 
 */

 /*g. Use the regression command to estimate the following 
linear regression model, where we now test whether college 
educated people and having a higher percentage of self-employed
individuals are important to employment growth in this region:*/
regress empgrowth_9006 percoll90 perse90;

/*h. What is the estimated slope coefficient for percoll90 in
 the model from part g? What is the interpretation of this slope coefficient?
 
 INTERPRETATION
 
 */
 
/*i. Using your results from parts e and g, does the regression model in part 
e suffer from omitted variable bias? Explain. 

INTERPRETATION

*/


/*j. Use the regression command to estimate the following linear
 regression model:*/

 regress percoll90 perse90;
 
/*k. Use the predict command to capture the residuals from the regression in
 part j in a new variable named res.*/
 
 predict residual, res;
 
/*l. Use the covariance option of the correlate command to examine the
 covariance between res and empgrowth_9006.*/
 correlate res empgrowth_9006, covariance;
 
save arcdata1.dta, replace;
log close;

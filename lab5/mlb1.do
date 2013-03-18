/* 	A. Shawn Bandy
	Lab #5
	March 12, 2013
*/

cap log close
set more 1
clear
#delimit ;

cd "/Users/shawn/src/econ485/lab5";
log using mlb1.log , replace;

use "mlb1.dta";

/*a. Run a regression where the dependent variable is salary and the explanatory variables are teamsal 
pcinc yrsallst years hits runsyr. In other words, the total team salary, the average income of the city 
where the team is located, the number of years on the All-Star team, the number of year the player has 
been in the League, the number of all-time hits (over all years), and runs per year.*/

regress salary teamsal pcinc yrsallst years hits runsyr;


/*b. Look at the simple correlation between the variables in your model, using correlate.*/

correlate salary teamsal pcinc yrsallst years hits runsyr;


/*c. Test for multicollinearity by using the vif command.*/

vif;

/*d. Look at your regression results, the test for multicollinearity, and the test for correlation.
 Is there a problem with multicollinearity in the model? Look at the variables in the model. If you believe 
 there is a problem with multicollinearity, explain why you might have that problem.
 
 INTERPRETATION
 
 */


 
/*e. Now, use the regression command to estimate a linear regression model where the dependent variable is salary
 and the explanatory variables are teamsal pcinc allstar slugavg fldperc frstbase scndbase shrtstop thrdbase
 outfield. In this new model, the explanatory variables are team salary, per capita income of the city where 
 the team is located, percentage of years as an All-Star, career slugging average, career fielding percentage,
 and dummy variables for the various positions on the team, with catcher excluded.*/
 
 regress salary teamsal pcinc allstar slugavg fldperc frstbase scndbase shrtstop thrdbase
 outfield;
 
/*f. Test for multicollinearity again for the model in part e.*/

vif;

corr salary teamsal pcinc allstar slugavg fldperc frstbase scndbase shrtstop thrdbase outfield;

/*g. Is multicollinearity a problem for the model in part e. Why do you think this result is different from before?

INTERPRETATION

*/


/*h. Now, predict the residuals for each observation in the model from part e.*/

predict res, r;

/*i. Create a new variable resid_2 using the generate command.*/

gen res2 = res^2;

/*j. Regress resid_2 on the explanatory variables (not salary) from part f.*/

regres res2 teamsal pcinc allstar slugavg fldperc frstbase scndbase shrtstop thrdbase outfield;

/*k. Run the regression from part e again.*/

regress salary teamsal pcinc allstar slugavg fldperc frstbase scndbase shrtstop thrdbase
 outfield;
 

/*l. Use the standard STATA Breusch-Pagan test for heteroskedasticity (estat hettest).*/

estat hettest;

/*m. Run the standard STATA White’s test for heteroskedasticity (imtest, white).*/


imtest, white;

/*n. For now, assume there is a problem with heteroskedasticity in the model from part e, 
estimate the model again with robust standard errors.*/

regress salary teamsal pcinc allstar slugavg fldperc frstbase scndbase shrtstop thrdbase
 outfield, r;


/*o. Pick a factor that you believe is missing from the regression equation in part e. 
Add that variable to the regression equation for salary using STATA. Test for multicollinearity 
and heteroskedasticity (using the standard STATA Breusch-Pagan test) in your model. Rerun your model 
to account for heteroskedasticity, if appropriate.*/

regress salary teamsal pcinc allstar slugavg fldperc frstbase scndbase shrtstop thrdbase outfield hruns;
vif;
estat hettest;

/*p. Why did you decide to include the variable you chose for your model in part o?

INTERPRETATION

*/

/*q. Did your estimate and statistical significance for allstar (percent of years as an All-Star) change from 
the model in part e to the final estimation model in part o (controlling for heteroskedasticity, if appropriate)?
 Explain why you might have a difference.*/


log close;

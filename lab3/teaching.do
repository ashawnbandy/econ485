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

use "TeachingRatings";
log using teaching.log , replace;

/*a. Create a graph that includes both a scatter plot of average course evaluation (course_eval) vs. instructor’s beauty
 (beauty) and the fitted line. Save this scatter plot as scattereval_beauty.emf so it can be printed and turned in with
 your assignment.*/

 twoway (lfit course_eval beauty)(scatter course_eval beauty);
 graph export scattereval_beauty.emf, replace;
 graph export scattereval_beauty.png, replace; //Note: this is for my use:  .emf is difficult to work with on Mac/Linux
 
/*b. Using the scatter plot and the fitted line from a), does it appear that course evaluations and beauty are related?
 Explain why.*/

//TODO Interpretation
 
/*c. Use the summarize command to look at the description of the variables in this dataset.*/

summarize;

/*d. Use the covariance option for the correlate command to get the covariance between course_eval and beauty.*/

correlate course_eval beauty, covariance;

/*e. Use the regression command to estimate the following linear regression model
CourseEvaluations_i = Beta_zero * Beauty + u_i*/

regression course_eval beauty;
/*f. What is the interpretation of the intercept term0ßin this regression model.*/
//TODO Interpretation

/*g. Using the regression output, what is the value of the estimated intercept 0ˆß?*/
//TODO Interpretation

/*h. What is the interpretation of the slope term1ßin this regression model.*/
//TODO Interpretation

/*i. Using the regression output, what is the value of the estimated slope 1ˆß?
Is it significantly different from zero? How do you know?*/
//TODO Interpretaion

/*j. Suppose Professor Smith is of average beauty, while Professor Miller is one standard deviation above the average beauty.
 Using the regression output and the summary statistics, predict Professor Smith’s and Professor Miller’s course evaluations.*/
//TODO Interpretation 

/*k. Does this model explain a large fraction of the variance in course evaluations*/
//TODO Interpretation

log close;

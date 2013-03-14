/* 	A. Shawn Bandy
	Lab #4 
*/
/* close previous run do-files */
cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Desktop\econ485-lab4\lab4";
log using arclab2.log , replace;
use "arcdata1";

/* a. Now, we want to test if additional variables would add to the explanatory 
value of employment growth in the region. Add the following additional variables
 to the model from L1 part g: pci90_thousands and pci90. */

 regress percoll90 perse90 pci90_thousands pci90;
 
/* b. Does the STATA output from part a) include both the new variables? 
Explain what happened.*/

/*INTERPRETATION */

/* c. Now, use the regression command to estimate a linear regression where
 y=empgrowth_9006 and x includes percoll90, perse90, and the dummy variable arc.*/
 
 regress empgrowth_9006 percoll90 perse90 arc;
 
/* d. What is the coefficient on arc? What is the interpretation of this 
coefficient in our model? (Hint: Look at the t-statistic!) */

/* INTERPRETATION */

/* e. Now, use the regression command to estimate a linear regression where
 y=empgrowth_9006 and x includes percoll90, perse90, and dummy variables for 
 each of the states in the model (state1,… state13). Exclude the dummy
 variable for state2 (Georgia) from the model.*/
 
 regress empgrowth_9006 percoll90 perse90 state1 state3-state13;
 
/* f. Why did we exclude Georgia from the model in part e? What is 
the interpretation of the coefficient on state1 (Alabama)?*/

/* INTERPRETATION */

/* g. Now, add the following additional variables to the model from part e:
 popsqmi_60 and rural. */

  regress empgrowth_9006 percoll90 perse90 state1 state3-state13 popsqmi_60 rural;
 
/* h. Test for multicollinearity in your data by running the vif command.*/

vif;

/* i. Are there any problems with multicollinearity in your model? Explain.*/

/* INTERPRETATION */

/* j. Compare the final model in part g to the model in L1, part g in terms of
 how much they explain the variance in employment growth. Explain.*/

 /*INTERPRETATION */

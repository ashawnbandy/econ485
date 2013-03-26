cap log close
set more 1
clear
#delimit ;

cd "C:\Users\cla-spa206.CAMPUS-DOMAIN\Downloads";

use bweight2.dta;
log using lab6demo.log, replace;

gen faminc_thous = faminc / 1000;

gen lnfaminc = ln(faminc);

gen bwghtlbs = bwght/16;

label variable faminc_thous "family income in 1000s of dollars";
label variable lnfaminc "log of family income";
label variable bwghtlbs "birthweight in pounds";

save bwight3.dta, replace;


/*Two regressions are the same except scaled dependent */
regress bwghtlbs cigs faminc white, r;
regress bwght cigs faminc white, r;

/*Same as above except scaled family income*/
regress bwghtlbs cigs faminc_thous white, r;

/* percent change family income to unit change in birthweight */
regress bwghtlbs cigs lnfaminc white,r;

clear;

use hprice2.dta;

gen dist_sq = dist^2;

regress lprice rooms crime stratio dist lnox, r;

regress lprice rooms crime stratio dist dist_sq lnox, r;

/* Taken together are dist and dist_sq jointly significant

Restricted model has zero in coefficients (or dropped) for the variables in question

Restricted model first...
 */


regress lprice rooms crime stratio lnox, r;

ereturn list;
scal rss_r = e(rss);

//unrestriced model next

regress lprice rooms crime stratio lnox dist dist_sq, r;
scal rss_u = e(rss);

scal fstat = ((rss_r - rss_u)/2)/(rss_u/499);
scal list;

/*fstat = 13.72 and so is significant even though the t-stats for the two variables is not

the following is another test for joint significance
*/
gen crime_school = crime+stratio;
regress lprice rooms crime stratio crime_school dist dist_sq lnox, r;

regress lprice rooms crime stratio dist dist_sq lnox, r;
test crime==stratio;

log close;

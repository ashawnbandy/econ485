//twoway (lfit farmse1970 farmse2000)(scatter farmse1970 farmse2000);
//graph export scatter2.emf, replace;


//return list;
//help scalar;

//calculate tstat manually
//sum farmse1970;
//scalar tstat = (r(mean) - 800)/(r(sd) / sqrt(r(N)));

//create pval by manually - sca is short for scalar
//sca pval = ttail(r(N),tstat);

//now use ttest 
//ttest farmse1970==800;

//notice that hand calculated value is the same as that for 't' when ttest is run


//always use unpaired unequal
//ttest farmse1970= farmse2000, unpaired unequal;

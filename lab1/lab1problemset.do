/* close previous run do-files */
cap log close

//executes without pausing to paginate
set more 1

//clears variables
clear

//set semi-colon as command line delimiter
#delimit ;

//change directory
cd "C:\econ485\lab1";

//a. Create a log file named lab1problemset.log on your flash drive that records all output.
log using lab1problemset.log , replace;

//b.Imports the BEA data from your flash drive
insheet using "BEA per capita income 1969 to 2008.csv", names;
  

foreach v of varlist fips * {;
	gen `v'_new=real(`v');
	drop `v';
	rename `v'_new `v';
	};
	
drop if missing(fips);

//e.	Renames the variables year1970 and year2008 as pci70 and pci08
rename year1970 pci70;
rename year2008 pci08;

//f.	Creates a new variable called perch_pci7008 that looks at the % change in per capita income from 1970 to 2008.
generate perch_farmse7000 =(pci08 - pci70) / pci70 * 100;

//g.	Saves the FIPS code, the name of each county, pci70, pci08, and perch_pci7008 in a new dataset called pci70and08.dta in the folder on your flash drive.
keep pci70 pci08 perch_pci7008;

save pci70and08, replace;

//h.	Reorders the variables so that the first variable is the FIPS code, followed by name of the county, then the % change in per capita income, and then per capita income in 1970 and 2008.  
order fips;

//i.	Sorts by the change in per capita income from 1970 to 2008
sort perch_pci7008;

//j.	Uses the simple summarize function to look at all the variables left in the sample.
summarize;

//k.	Uses the detailed summarize function for only pci70, pci08, and perch_pci7008 
summarize pci70 pci08 perch_pci7008, detail;

//l.	Examines the correlation between pci70 and pci08.
correlate pci70, pci08;

//m.	Examines the correlation between pci70 and the change in per capita income from 1970 to 2008.  
correlate pci70, perch_pci7008;

//n.	Creates a histogram of pci70 based on fractions 
histogram pci70, fraction

//p.	Exports the histogram in n. as a Windows Enhanced Metafile (emf) with the name pcihistogram.  Print a copy of the histogram and include with your assignment.     
graph export pcihistogram.emf, replace

//o.	Creates a histogram of pci70 based on fractions and with the normal distribution added.  
hisogram pci70, fraction normal

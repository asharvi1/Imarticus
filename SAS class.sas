/* First class on SAS*/

/* Creating the first program */
data details;
input age exp;
datalines;
28 4
32 8
62 20
58 15
44 16
;
run;

/* Shows the dataset */
proc print data = work.details;
run;

/* Gives the details of the dataset */
proc contents data = work.details;
run;

/* To move the dataset from the work to different library, in this case it is sending the dataset from work to sashelp */
data arun.details;
set details;
run;

/* To view all the datasets in a particular library */
proc contents data = arun._all_ nods;
run;

/* Bringing the dataset from a library to the work library (environment)  */
data work.demo;
set sashelp.demographics;
run;

/* Subset the data according the given rule */
proc print data = demo;
where popagr < .1;
run;

/* To find the missing values in a dataset with a numeric variable */
proc print data	= demo;
where adolecent = .;
run;

proc print data = demo;
run;

/* Used for the data validation */
proc freq data = demo;
table name * cont;
run;

/* Using the proc means statement */
proc means data = demo;
run;

/* To check the frequency of the data in a particular user defined intervals (# of times)*/
proc freq data = sashelp.demographics;
table region * adolescentfpyear;
run;

/* Shows the entire univariate analysis for the whole dataset or with var we can also perform for a single variable */
proc univariate data = sashelp.demographics;
var pop;
run;

/* Filter a dataset with respect to an arguement (either eq(equalto =) or ne(notequalto)) */
proc print data = sashelp.demographics;
where region = 'EUR';
run;

/* If we want to filter the data by one or more arguments */
proc print data = sashelp.demographics;
where region in ('AMR' 'EUR');
run;

/* Filtering the data with two variables */
proc print data = sashelp.demographics;
where region in ('AMR' 'EUR') and pop gt 1000000;
run;

/* Filtering with between operator */
proc print data = sashelp.demographics;
where pop between 1000000 and 2000000;
run;

proc print data = sashelp.demographics;
where pop not between 1000000 and 2000000;
run;

/* Bringing the demographics dataset to the work library */
data work.demographics; /* Dataset creation */
set sashelp.demographics; /* which dataset to be created or from the dataset from which library*/
run;

/* Checking the contents of the dataset */
proc contents data = demographics;
run;

/* Check the entire dataset */
proc print data = demographics;
run;

/* Printing a single variable of a particular dataset */
proc print data = demographics;
var pop;
run;

/* To print more than one variable, just give a space between the variable names */
proc print data = demographics;
var pop;
run;

/* Gives the mean min max and the stddev of a variable, if we want any of the tests in univariate analysis we can get from the means but need to mention after the dataset name */
proc means data = demographics;
/* var pop; */
run;

proc means data = demographics range kurtosis;
run;

/* Gives all the univariate analysis */
proc univariate data = demographics;
var pop;
run;

proc freq data = demographics;
table region * adolescentfpyear;
run;

/* Checking the missing values in the adolescentfpyear variable from the dataset */
proc print data = demographics;
where adolescentfpyear = .;
run;

/* Creating a dataset in the work library */
data names;
input Name$ Age Gender$;
datalines;
abc 23 M
def 45 F
ghi 32 M
jkl 28 M
mno 47 F
;
run;

/* Gives the all the observations that have the specified character after the contains statement */
proc print data = demographics;
where region contains 'E';
run;

/* Similar to the contains statement if we want to filter the observations with a string or character and the length of the character is known */
proc print data = demographics;
where region like 'E__';
run;

/* If we dont know the length, but we know with which letter the string starts */
proc print data = demographics;
where region like 'E%';
run;


/* Using if condition */
data demographics;
set demographics; /* If set not specified it will create a new dataset with the give name after the data */
if region = 'AMR' and pop  >= 1000000 then region_code = 1;
run;

/* Using multiple else if conditions it will faster than just if then conditions */
/* Can also use a direct else condition after the if then statement if furthur conditions are unknown */

/* To remove a column in a dataset */
data demographics;
set demographics;
drop region_code;
run;

/* Using the sort statement */
proc sort data = demographics out = demo_sort;
by descending pop; /*If we want to do in a ascending order dont mention descending in this line*/
run;

/* Using the duplicate statements */
proc sort data = <dataset> nodupkey out = <dupremoveddf> dupout = <removeddupdf>;
by <variablename>;
run;

/* Adding labels to the variables of a dataset for comprehensive understanding of the variable */
data one;
input name$ m1 m2 m3;
datalines;
pranav 21 22 23
praveen 24 25 26
vinay 27 28 29
;
run;

data two;
set one;
label	names = 'Names'
		m1 = 'Maths Marks'
		m2 = 'Science Marks'
		m3 = 'Social Marks';
run;

proc contents data = two;
run;


/* To use the dollar format */
proc print data = one label;
var name m1 m2 m3;
format m3 dollar9.2; /* dollar9 indicates the dollar symbol and .2 indicates the decimal place */
label name = 'Name'
      m1 = 'Maths Marks'
      m2 = 'Science Marks';
run;

/* add a length statement after the input statement to say that the variable is more than 8 character length */
/* Length name$12 */
/* informat is used when the delimeter is in different format other than the expected seperated format */
/* dataset has a delimeter other than the blank */
data <datasetname>;
infile '<path of the dataset>' dlm = '<delimeter sign>';
input <column 1> <column 2> ...;
run;

/* using the proc step */
proc import datafile = '<dataset path>'
out = <new dataset name>
dbms = <file extension>
replace;
run;

/* when you are creating a dataset with seperator as comma */
data listinput;
infile datalines delimiter = ',';
input name$ age;
datalines;
pavan,23
kiran,24
ravi,25
;
run;
/* in the list input, if ',' is a delimeter, we need to write infile datalines delimeter = ',' */
data listinput;
infile datalines delimiter = ',:'; /* To handle multiple delimiters in the same file we can use this format delimiter = '<first delimiter><second delimiter>' */
input name$ age;
datalines;
pavan:34
kiran,42
ravi:28
;
run;


/* If semicolon is the delimeter in your data, then us the cards 4 statement instead of the datalines and input lines has to end with 4 semi colons */
data two;
infile cards4 dlm = ';';
input name$ age sal;
format sal dollar9.2;
cards4;
pavan;21;56000
kiran;25;60000
;;;;
run;

data columninput;
input name$ 1-11 area$ 12-22 age 23-27;
datalines;
pavan kumarramanthapur25
vinod babu basherbagh 28
;
run;

data formattedinput;
length IdNumber 4 Name$ 12. Team$ 6. MidSem 3 EndSem 3; /* To mention the length of each data in the respective variable */
input IdNumber Name$ Team$ MidSem EndSem;
datalines;
1023 David red 189 165
1049 Amelia yellow 145 124
1219 Alan red 210 192
1246 Ravishankar yellow 194 177
1078 Ashley red 127 118
1221 Jim yellow 220 .
;
run;


/* Create a user defined format */
proc format;
value $gender
'M' = 'Male'
'F' = 'Female'
'' = 'Not Entered';
run;

data gen;
input gen$;
datalines;
M
F
M
F
;
run;

proc print data = gen;
format gen $gender.;
run;

/* Infile Functions */
/* infile '<file path>' options (dlm, firstobs); */
/* dsd in inflie options helps us to avoid any extra quotes(eg. "name", 32, "45"), Commas are given main importance for speration while quotes are neglected*/
/* Firstobs = <row number> in infile option starts reading the raw data from the said row position */
/* Missover helps us to read the data that has missing values and affects the loading of the data */
/* obs = <row number> is used to stop the at the reading of raw data at specified row number */


data dsds;
infile datalines dsd;
input names:$12. m1 m2 m3 m4;
datalines;
pavan s,567,567,345,.
"vinod sharma",23,"457",89,7
;
run;

data missovers;
infile datalines missover;
input names$ m1 m2 m3 m4;
datalines;
madhu . . 14 15
pavan . . 13 12
suresh 14 11 13
;
run;

/* Importing a csv file */
proc import datafile = '<path of the file>'
out = <dataset name>
dbms = <file extension>
replace; /* replace statement replaces the old dataset if with a similar name */

/* Exporting the dataset */
proc export data = <dataset name>
outfile = '<Name and path of the file to be saved>'
dbms = <file extension>
replace;
delimiter = '<delimiter of the output file>';
run;


/* Example analysis on cars dataset from sashelp folder */
data car;
set sashelp.cars;
run;

proc print data = car;
run;

proc means data = car;
run;

proc means data = car;
var MSRP Invoice;
run;

proc means data = car median range min max;
run;

proc means data = car uclm median p50 q1 p25 max maxdec = 2 p90 missing;
run;

/* Checking the details of a continuos or discrete variable against a categorical variable */
proc means data = car;
var MPG_City MPG_Highway;
class origin;
run;

/* Further dividing the data with by statement, remember variable under by statement must have more categories than the class variable */
proc means data = car;
var MSRP Invoice;
class Type;
by Make;
run;

proc print data = sashelp.demographics;
run;

/* Changing variable names of the means output */
proc means data = car noprint;
var MSRP;
output out = Means_summary
mean = Average_price min = Min_price;
run;

proc print data = means_summary;
run;

/* proc summary with print gives the default output of proc means */
proc summary data = car;
var MSRP;
output out = means_summary1
mean = avg_price min = min_price;
run;


/* Playing with proc freq */
data car;
set sashelp.cars;
run;

proc freq data = car;
table make;
run;

proc freq data = car;
table make*type;
run;

/* without total percentage value */
proc freq data = car;
table make*type/ nopercent;
run;

/* without row percentage value */
proc freq data = car;
table make*type/ norow;
run;

/* Merging the datasets */
data A;
input EmpID$ Name$;
datalines;
E00632 Strauss
E01483 Lee
E01996 Nick
E04064 Waschk
;
run;

data B;
input EmpID$ Flight;
datalines;
E04064 5105
E00632 5250
E01996 5501
;
run;

proc sort data = A;
by EmpID;
run;

proc sort data = B;
by EmpID;
run;

/* If a particular EmpID which is in A and not there in B, then a=1 and b=0 */
/* the in statement creates a new variable in the PDV and contains either 1 or 0 */
data C;
merge A(in = a) B(in = b); /* the in = a/b statement is a different notation for merging logic, in this case it is a=1 and b=1 */
by EmpID;
if A and B;
run;

proc print data = C;
run;

/* One to many merge */
data one;
input X Y$;
datalines;
1 A
2 B
3 C
;
run;

data two;
input X E$;
datalines;
1 A1
1 A2
2 B1
3 C1
3 C2
;
run;

data three;
merge one two;
by X;
run;

data c;
input Num Var$;
datalines;
1 C1
2 C2
3 C3
4 C4
;
run;

data d;
input Num Var$;
datalines;
2 D1
3 D2
3 D4
;
run;

/* Appending two datasets into one, by statement in this used to concatonate by sorting a specific column */
data e;
set c d;
by Num;
run;


/* Splitting the cars dataset with respect to the region */
data car;
set sashelp.cars;
run;

data car_USA car_Europe car_Other;
set car;
if Origin = 'USA' then output car_USA;
else if Origin = 'Europe' then output car_Europe;
else output car_Other;
run;

/* Setting a title while printing the data */
title 'Cars from United States of America';
proc print data = car_USA;
run;

/* Splitting the cars data with select statement  */
data C_USA C_Europe C_other;
set car;
select (Origin); /* Upcase is used to convert the cases of all the records in the column to uppercase */
when ('USA') output C_USA;
when ('Europe') output C_Europe;
otherwise output C_other;
end;
run;

data employee;
infile cards delimiter = ',';
input EID fullname:$ 30. Title:$ 20.;/* SAS considers numeric variable as length 3, unless specificed more than 3, but if length under 3, it does not shrink */
cards;
1,Ms. Davolio Nancy,Sales Representative
2,Dr. Fuller Andrew,Vice President
3,Ms. Leverling Janet,Sales Representative
4,Mrs. Peacock Margaret,Sales Representative
5,Mr. Buchanan Stern,Sales Manager
6,Mr. Suyama Michael,Sales Representative
7,Mr. King Robert,Sales Representative
8,Ms. Callahan Laura,Inside Sales Coordinator
9,Ms. Dodsworth Anne,Sales Representative
;
run;

proc print data = employee;
run;

data employee1;
set employee;
Title_of_courtesy = scan(fullname, 1);
First_Name = scan(fullname, 3);
Last_Name = scan(fullname, 2);
run;

data employee2;
set employee1;
Last_Initial = substr(Last_Name, 1, 1);
run;

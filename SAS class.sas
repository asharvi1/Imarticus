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

data demo;
set sashelp.demographics;
run;

/* tranwrd() function is used to replce one word with another */
data demo_name;
set demo;
Name1 = tranwrd(NAME, 'CANADA', 'Hyderabad');
run;

proc print data = demo_name;
run;

/* Double pipe(||) operator is used to concatonate two variables */
/* If we concatonate two columns in this manner, the new created column will possess extra spaces between the words */
data demo_Name1;
set demo;
Address = name||','||region;
run;

/* To contradict the previous concatonation rule, we use trim() function to remove any spaces created while joining the two variables */
data demo_name2;
set demo;
Address = trim(name)||','||trim(region);
run;

/* Filtering with index function, in this case we are checking for the 'ITI' letters in the name variable */
data demo_filter;
set demo;
if index(upcase(name), 'ITI') > 0;
run;

proc print data = demo_filter;
run;

/* converting the name variable in demographics dataset to lowercase and then to upper case */
data demo_lowcase;
set demo;
name = lowcase(name);
run;

data demo_propcase;
set demo;
name = propcase(name);
run;

data demo_upcase;
set demo;
name = upcase(name);
run;

data demo_int;
set demo;
totalFR = int(totalFR);
run;

data demo_round;
set demo;
totalFR = round(totalFR); /* We can also add an extra arguement in the round function(round(variable, digits)), the extra second arguement acts as a number of digits to round off */
run;

data demo_ceil;
set demo;
totalFR = ceil(totalFR);
run;

data demo_floor;
set demo;
totalFR = floor(totalFR);
run;

/* Here it gives the nearest multiple of the variable */
data demo_round_digits;
set demo;
per = round(totalFR, 0.25);
perhalf = round(totalFR, 0.5);
run;

data sum;
tot = sum(1,2,3,4);
run;

data descript;
var1 = 12;
var2 = .;
var3 = 7;
var4 = 5;
varssum = sum(of var1-var4);
varmeans = mean(of var1-var4);
nummiss = nmiss(var1,var2,var3,var4);
cmiss = cmiss(of var1-var4);
run;

proc print data = descript;
run;

/* Date functions */
/* today() */
/* MDY(month, day, year) */
/* intck() */
/* intnx() */
/* weekday() */
/* year() */
/* month() */
/* day() */

data date;
input Date;
format date;
cards;
21/01/2017
01/02/2017
06/03/2017
;
run;

data todaydate;
date = today();
weekday = weekday(date);
run;

proc print data = todaydate;
format date date8.;
run;

/* input tells the sas that the entered string is in a specific format and change it to the default of the belonged category */
data conversions;
CVar1 = '32000';
CVar2 = '32.000';
CVar3 = '03may2008';
CVar4 = '030508';
NVar1 = input(CVar1, 5.);
NVar2 = input(CVar2, commax6.);
NVar3 = input(CVar3, date9.);
NVar4 = input(CVar4, ddmmyy6.);
run;

proc print data = conversions;
format NVar3 date9. NVar4 date9.;
run;

/* put is used to change the elements into the required format */
data conversion1;
nvar1 = 614;
nvar2 = 55000;
nvar3 = 366;
cvar1 = put(nvar1, 3.);
cvar2 = put(nvar2, dollar7.);
cvar3 = put(nvar3, date9.);
run;

proc contents data = conversion1;
run;

/* Loops in SAS */
data earnings;
amount = 1000;
rate = 0.075/12;
do month = 1 to 12 by 1;
earned+(amount+earned)*(rate);
output;
end;
run;

data cumm;
amount = 100;
do step = 1 to 10 by 1;
cum_amount+amount;
output;
end;
run;

data earnings3;
amount = 5000;
rate = 0.0625;
do qtr = 1 to 12;
earned+(amount+earned)*(rate/4);
output;
end;
run;

/* with output */
data question;
value = 2000;
do year = 1 to 20;
interest = value * 0.075;
value+interest;
output;
end;
run;

/* with output */
data question;
value = 2000;
do year = 1 to 20;
interest = value * 0.075;
value+interest;
end;
run;

proc print data = question;
run;


data mother;
input mid cid1 age1 sex1$ cid2 age2 sex2$ cid3 age3 sex3$;
cards;
1 1 2 f 2 5 m 3 10 f
2 1 10 m 2 12 m 3 13 f
3 1 7 f 2 20 f 3 23 m
;
run;

data child(keep= mid cid age sex);

set mother;

array c(1:3) cid1-cid3;
array a(1:3) age1-age3;
array s(1:3) sex1-sex3;

do i = 1 to 3;
cid = c(i);
age = a(i);
sex = s(i);

if not missing(cid) then output;

end;
run;


/* SQL Proc in SAS */
/* Proc SQl; */
/* select pop,popagr */
/* from demo; */ /* if we want a new dataset we can write from demo to demo1 */
/* where popagr > 0.5; */
/* order by pop desc; */
/* group by region; */
/* quit; */

/* Insert records to a table */
/* COALESCE function */
/* Summarize data */
/* Fuzzy merge */

/* Infile Statements */
/* obs */
/* firstobs */
/* dlm */
/* dsd */
/* missover */
/* truncover */

data demo;
set sashelp.demographics;
run;

proc sql;
select pop,popagr,region,pop+(pop*popagr) as new_pop
from demo
order by region; /* we can specify the order by with asc(for ascending) dsc(for descending) */
quit; /* for multiple sorting we have to specify the other variables after the first one with a comma and the sorting is done cummulatively */

/* To check the total number of records in a dataset */
proc sql;
select count(*) as total_rec  /* we can write any other function other than count, such as distinct(unique) */
from <dataset name>;
quit;

/* Table joins using SQL */

/* 	 	   |	R  |  SAS  | SAS SQL */
/* columns | cbind | merge | joins */
/* rows    | rbind | set   | */

proc sql;
create table <dataset name> as
select a.<column name>,
a.<column name>,
b.<column name>,
b.<column name>,
from <dataset1 name> as a, <dataset2 name> as b
where a.<column name> = b.<column name>
and a.<column name> = b.<column name>;
quit;

/* In order to do a left join */
proc sql;
create table <dataset name> as
select a.<column name>,
a.<column name>,
b.<column name>,
b.<column name>,
from <dataset1 name> left join <dataset2 name>
where a.<column name> = b.<column name>
and a.<column name> = b.<column name>;
quit;


data vitals;
input patient 3. date date10. pulse temp bps bpd;
cards;
101 25may2001 2 98.5 130 88
101 01jun2001 5 98.6 133 92
101 08jun2001 4 98.5 136 90
102 30jul2001 1 99.0 141 93
102 06aug2001 7 98.7 144 97
102 13aug2001 8 98.7 142 93
103 24jul2001 7 98.3 137 79
103 31jul2001 7 98.5 133 74
103 07aug2001 8 98.6 140 80
103 14aug2001 5 99.2 147 89
104 22aug2001 2 98.8 128 83
104 29aug2001 9 99.1 131 86
104 05sep2001 1 98.9 127 82
;
run;

data Dosing;
input patient 3. date med$ doses amt unit$;
format date date9.;
cards;
102 15186 A 2 1.2 mg
102 15198 A 3 1.0 mg
102 15200 A 2 1.2 mg
103 15180 B 3 3.5 mg
103 15187 B 3 3.5 mg
103 15195 B 3 3.5 mg
104 15209 A 2 1.5 mg
104 15216 A 2 1.5 mg
104 15223 A 2 1.5 mg
105 15144 B 1 4.5 mg
105 15151 B 2 3.0 mg
105 15158 B 1 5.0 mg
;
run;

data vitals1;
set vitals;
format date date9.;
run;

proc print data = vitals1;
run;

proc sql;
create table patient_rec as
select a.patient,
a.date,
a.med,
b.pulse,
b.temp
from dosing1 as a,vitals1 as b
where a.patient=b.patient
and a.date=b.date;
quit;

proc print data = patient_rec;
run;

proc sql;
create table patient_rec_LJ as
select a.patient,a.date,
a.med,b.pulse,b.temp
from dosing1 as a left join vitals1 as b
on a.patient=b.patient
and a.date=b.date;
quit;

proc print data = patient_rec_LJ;
run;


/* Performing a right join with sql */
proc sql;
create table patient_rec_RJ as
select a.patient,a.date,
a.med,b.pulse,b.temp
from dosing1 as a right join vitals1 as b
on a.patient=b.patient
and a.date=b.date;
quit;

proc print data = patient_rec_RJ;
run;

/* Performing a full join with sql */
proc sql;
create table patient_rec_FJ as
select a.patient,a.date,
a.med,b.pulse,b.temp
from dosing1 as a full join vitals1 as b
on a.patient=b.patient
and a.date=b.date;
quit;

proc print data = patient_rec_FJ;
run;

proc sql <options>;
quit;

proc sql;
select count(<column name>) as <new name>
from <dataset name>
group by <categorical column name>;
quit;

/* using a having clause */
proc sql;
select jobcode,avg(salary) as Avg
from <dataset name> group by <categorical column> having
avg(salary)>40000 order by jobcode;
quit;


data demo;
set sashelp.demographics;
run;

/* playing with the having clause */
proc sql;
select region,min(pop) as min_pop
from demo group by region having min(pop)>10000 order by region;
quit;

proc sql;
create table demo_amr as
select *
from demo
where popagr>0.01 and region = 'AMR';
quit;

proc sql;
create table demo_amr_having as
select *
from demo group by region having popagr>0.01 and region = 'AMR' order by region;
quit;

/* having clause checks with the condition after the grouping */
proc sql;
create table demo_high as
select region,min(pop) as min_pop
from demo group by region having min(pop)>10000 order by region;
quit;

/* Where statement check with the records */
proc sql;
create table demo_high1 as
select region, min(pop) as min_pop
from demo
where pop>10000
group by region;
quit;

/* Having does the artimatic operation after the sorting */
/* Where as where statement does the artimatic operation on the records directly */
proc sql;
create table demo_high2 as
select region, avg(pop) as avg_pop
from demo group by region having avg(pop)>20000000 order by region;
quit;

/* Coalesce function */
/* It checks the high fill rate for the common variable in a number of datasets */

/* Fuzzy merge can be through column wise and also approx merge with the record wise */

/* MACROS */
/* % and & are the macro trigger variables */

data demo;
set sashelp.demographics;
run;

/* Initiation of a reference variable */
%let region='AMR'; /* reference variable */
proc print data = demo;
title 'Table with only the America continent';
where region = &region;
run;
proc freq data=demo;
title 'No of records in America continent';
table region;
where region=&region;
run;

/* Initiation of a MACRO */

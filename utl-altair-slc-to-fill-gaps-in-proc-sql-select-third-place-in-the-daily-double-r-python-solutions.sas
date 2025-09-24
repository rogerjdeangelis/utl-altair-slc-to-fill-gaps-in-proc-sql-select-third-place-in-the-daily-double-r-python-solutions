%let pgm=utl-altair-slc-to-fill-gaps-in-proc-sql-select-third-place-in-the-daily-double-r-python-solutions;

%stop_submission;

Altair SLC to fill gaps in proc sql select third place in the daily double r python solutions

Problem: Pick the horse that comes in third in the daily double horse race
The daily double is usaully the first and second race

SELECT THIRD PLACE FOR HORSES IN THE DAILY DOUBLE

SORTED FOR DOCUMENTATION
ONLY. PRE SORTING IS
NOT NEEDED.

RACE   HORSE      TIME  Partition

  1 lady_Joyce    70.5    1
  1 gent_Thomas   85.0    2
  1 gent_Henry   102.0    3  THIRD PLACE
  1 gent_Alfred  112.0    4
  1 gent_William 112.0    5

  2 gent_John     99.0    1
  2 lady_Alice   100.0    2
  2 lady_Carol   102.0    3  THIRD PLACE
  2 lady_Mary    112.0    4
  2 lady_Barbara 113.0    5


CONTENTS  (proc sql does not support the rank function)
========
     1 slc r sql
       supports export/import

     2 slc python sql
       (see the compact json below)
       I could not get export/import tp work with python
       
github
https://tinyurl.com/yc3d84r5
https://github.com/rogerjdeangelis/utl-altair-slc-to-fill-gaps-in-proc-sql-select-third-place-in-the-daily-double-r-python-solutions

related to
https://communities.sas.com/t5/SAS-Programming/6th-max-value/m-p/703006#M215365

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
informat horse $12.;
   input race horse time;
cards4;
1 gent_Alfred 111
1 gent_Henry 102
1 gent_Thomas 85
1 gent_William 112
1 lady_Joyce 70.5
2 lady_Mary 112
2 gent_John 99
2 lady_Alice 100
2 lady_Barbara 113
2 lady_Carol 102
;;;;
run;quit;

/*       _                         _
/ |  ___| | ___   _ __   ___  __ _| |
| | / __| |/ __| | `__| / __|/ _` | |
| | \__ \ | (__  | |    \__ \ (_| | |
|_| |___/_|\___| |_|    |___/\__, |_|
                                |_|
*/


&_init_;
proc r;
export data=sd1.have r=have;
submit;
library(sqldf)
options(sqldf.dll = "d:/dll/sqlean.dll")
print(have)
want<-sqldf('
with
  ranked as (
select
  race
 ,horse
 ,time
 ,rank() over (
      partition by race
      order by time
  ) as rank
 from
    have

     )
 select
   *
  ,case
     when rank=3 then "THIRD PLACE"
     else NULL
   end as place
 from
   ranked
')
want
endsubmit;
import data=sd1.want r=want;
;quit;run;

proc print data=sd1.want;
run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

RACE    HORSE      TIME RANK    PLACE

 1  lady_Joyce     70.5  1
 1  gent_Thomas    85.0  2
 1  gent_Henry    102.0  3  THIRD PLACE
 1  gent_Alfred   111.0  4
 1  gent_William  112.0  5
 2  gent_John      99.0  1
 2  lady_Alice    100.0  2
 2  lady_Carol    102.0  3  THIRD PLACE
 2  lady_Mary     112.0  4
 2  lady_Barbara  113.0  5

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

983       FILENAME WPSWBHTM TEMP;
NOTE: Writing HTML(WBHTML) BODY file d:\wpswrk\_TD24756\#LN00031
984       ODS HTML(ID=WBHTML) BODY=WPSWBHTM GPATH="d:\wpswrk\_TD24756";
985       &_init_;
986       proc r;
NOTE: Using R version 4.5.1 (2025-06-13 ucrt) from d:\r451
987       export data=sd1.have r=have;
NOTE: Creating R data frame 'have' from data set 'SD1.have'

988       submit;
989       library(sqldf)
990       options(sqldf.dll = "d:/dll/sqlean.dll")
991       print(have)
992       want<-sqldf('
993       with
994         ranked as (
995       select
996         race
997        ,horse
998        ,time
999        ,rank() over (
1000            partition by race
1001            order by time
1002        ) as rank
1003       from
1004          have
1005       group
1006          by race )
1007       select
1008         *
1009      ,case when rank=3 then "THIRD PLACE" else NULL end as place
1010
1011       from
1012         ranked
1013      ')
1014      want
1015      endsubmit;

NOTE: Submitting statements to R:

Loading required package: gsubfn
Loading required package: proto
Loading required package: RSQLite
> library(sqldf)
> options(sqldf.dll = "d:/dll/sqlean.dll")
> print(have)
> want<-sqldf('
+ with
+   ranked as (
+ select
+   race
+  ,horse
+  ,time
+  ,rank() over (
+       partition by race
+       order by time
+   ) as rank
+  from
+     have
+  group
+     by race )
+  select
+    *
+ ,case when rank=3 then "THIRD PLACE" else NULL end as place
+
+  from
+    ranked
+ ')

NOTE: Processing of R statements complete

> want
1016      import data=sd1.want r=want;
NOTE: Creating data set 'SD1.want' from R data frame 'want'
NOTE: Column names modified during import of 'want'
NOTE: Data set "SD1.want" has 2 observation(s) and 5 variable(s)

1017      ;quit;run;
NOTE: Procedure r step took :
      real time : 1.339
      cpu time  : 0.031


1018      quit; run;
1019      ODS _ALL_ CLOSE;
1020      FILENAME WPSWBHTM CLEAR;

/*___        _                    _   _                             _
|___ \   ___| | ___   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
  __) | / __| |/ __| | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 / __/  \__ \ | (__  | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|_____| |___/_|\___| | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
                     |_|    |___/                                |_|
*/

&_init_;
OPTIONS NOERRORABEND;
%utlfkil(d:/json/sas_compatible.json);
options set=PYTHONHOME "D:\python310";
proc python;
submit;
import json
exec(open('c:/wpsoto/fn_pythonx.py').read());
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat')
print(have)
want=pdsql('''
with
  ranked as (
select
  race
 ,horse
 ,time
 ,rank() over (
      partition by race
      order by time
  ) as rank
 from
    have

     )
 select
   *
  ,case
     when rank=3 then "THIRD PLACE"
     else NULL
   end as place
 from
   ranked
''')

records = want.to_dict('records')
with open('d:/json/want.json', 'w') as f:
    json.dump(records, f, separators=(',', ':'), indent=None)
endsubmit;
quit;run;

&_init_;
filename myjson "d:/json/want.json";
libname myjson json fileref=myjson;

proc datasets lib=myjson;
run;
quit;

data work.frompython;
  set myjson.root;
run;

proc print data=fromPython;
run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

COMPRESSED JSON  Pyhton output

[{"race":1.0,"horse":"lady_Joyce","time":70.5,"rank":1,"place":null},
{"race":1.0,"horse":"gent_Thomas","time":85.0,"rank":2,"place":null},
{"race":1.0,"horse":"gent_Henry","time":102.0,"rank":3,"place":"THIRD PLACE"},
{"race":1.0,"horse":"gent_Alfred","time":111.0,"rank":4,"place":null},
{"race":1.0,"horse":"gent_William","time":112.0,"rank":5,"place":null},
{"race":2.0,"horse":"gent_John","time":99.0,"rank":1,"place":null},
{"race":2.0,"horse":"lady_Alice","time":100.0,"rank":2,"place":null},
{"race":2.0,"horse":"lady_Carol","time":102.0,"rank":3,"place":"THIRD PLACE"},
{"race":2.0,"horse":"lady_Mary","time":112.0,"rank":4,"place":null},
{"race":2.0,"horse":"lady_Barbara","time":113.0,"rank":5,"place":null}]



ORDINAL_ROOT    HORSE           PLACE         RACE    RANK    TIME

      1         lady_Joyce                       1       1      70.5
      2         gent_Thomas                      1       2      85.0
      3         gent_Henry      THIRD PLACE      1       3     102.0
      4         gent_Alfred                      1       4     111.0
      5         gent_William                     1       5     112.0
      6         gent_John                        2       1      99.0
      7         lady_Alice                       2       2     100.0
      8         lady_Carol      THIRD PLACE      2       3     102.0
      9         lady_Mary                        2       4     112.0
     10         lady_Barbara                     2       5     113.0

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1807      ODS _ALL_ CLOSE;
1808      FILENAME WPSWBHTM TEMP;
NOTE: Writing HTML(WBHTML) BODY file d:\wpswrk\_TD24756\#LN00056
1809      ODS HTML(ID=WBHTML) BODY=WPSWBHTM GPATH="d:\wpswrk\_TD24756";
1810      &_init_;
1811      OPTIONS NOERRORABEND;
1812      %utlfkil(d:/json/wan.json)
The file d:/json/wan.json does not exist
1813      options set=PYTHONHOME "D:\python310";
1814      proc python;
1815      submit;
1816      import json
1817      exec(open('c:/wpsoto/fn_pythonx.py').read());
1818      have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat')
1819      print(have)
1820      want=pdsql('''
1821      with
1822        ranked as (
1823      select
1824        race
1825       ,horse
1826       ,time
1827       ,rank() over (
1828            partition by race
1829            order by time
1830        ) as rank
1831       from
1832          have
1833
1834           )
1835       select
1836         *
1837        ,case
1838           when rank=3 then "THIRD PLACE"
1839           else NULL
1840         end as place
1841       from
1842         ranked
1843      ''')
1844
1845      records = want.to_dict('records')
1846      with open('d:/json/want.json', 'w') as f:
1847          json.dump(records, f, separators=(',', ':'), indent=None)
1848      endsubmit;

NOTE: Submitting statements to Python:

NOTE: <string>:16: SADeprecationWarning: The _ConnectionFairy.connection attribute is deprecated; please use 'driver_connection' (deprecated since: 2.0)


1849      quit;run;
NOTE: Procedure python step took :
      real time : 1.379
      cpu time  : 0.000


1850
1851      &_init_;
1852      filename myjson "d:/json/want.json";
1853      libname myjson json fileref=myjson;
NOTE: Library myjson assigned as follows:
      Engine:        JSON
      Physical Name: d:\json\want.json

Altair SLC

The DATASETS Procedure

            Directory

Libref           MYJSON
Engine           JSON
Physical Name    d:\json\want.json

           Members

            Member     Member
  Number    Name       Type

-----------------------------

       1    ALLDATA    DATA
       2    ROOT       DATA
1854
1855      proc datasets lib=myjson;
1856      run;
1857      quit;
NOTE: Procedure datasets step took :
      real time : 0.073
      cpu time  : 0.015


1858
1859      data work.frompython;
1860        set myjson.root;
1861      run;

NOTE: 10 observations were read from "MYJSON.ROOT"
NOTE: Data set "WORK.frompython" has 10 observation(s) and 6 variable(s)
NOTE: The data step took :
      real time : 0.004
      cpu time  : 0.000


1862
1863      proc print data=fromPython;
1864      run;quit;
NOTE: 10 observations were read from "WORK.fromPython"
NOTE: Procedure print step took :
      real time : 0.029
      cpu time  : 0.015


1865
1866      quit; run;
1867      ODS _ALL_ CLOSE;
1868      FILENAME WPSWBHTM CLEAR;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

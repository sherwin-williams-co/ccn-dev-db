create or replace PACKAGE SD_COMMON_TOOLS
/**************************************************************** 
This package will have store drafts specific tools

created : 11/10/2014 jxc517 CCN Project....
changed :
*****************************************************************/
IS

FUNCTION GET_HEX_VALUE_FOR_TRNSCTN_TYP
/******************************************************************
This function will return the hexadecimal conversion of the value passed in
based on the transaction type passed in

created : 11/10/2014 jxc517 CCN Project....
changed :
******************************************************************/
(IN_TRANSACTION_TYPE    IN     VARCHAR2
,IN_AMOUNT              IN     NUMBER) RETURN VARCHAR2;

PROCEDURE GENERATE_SECOND_WEEKDAY
/******************************************************************
This procedure will return the run date for the monthly process. This date would be
second weekday of the month.

This process will check if the second day of the month is saturday or sunday. 
If it is saturday or sunday, it will add 2 days to get the second weekday.
If it is Monday then, second weekday has to be next day, so add 1 day.
If not 2nd of the month itself is the second week day

It will then write the file with the date in the server

created : 02/29/2016 nxk927 CCN Project....
changed :
******************************************************************/
;

END SD_COMMON_TOOLS;
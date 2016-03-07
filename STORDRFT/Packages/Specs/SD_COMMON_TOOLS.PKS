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
This procedure will return the run date for the monthly process which should be 
2nd business day

Created : 02/29/2016 nxk927 CCN Project....
Changed :
******************************************************************/
;

END SD_COMMON_TOOLS;
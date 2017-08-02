create or replace PACKAGE SD_DAILY_LOAD
/**************************************************************** 
This package will load the existing CCN Store Drafts Oracle Database
created : 06/11/2013 jxc517 CCN Project....
changed :
*****************************************************************/
IS

PROCEDURE CCN_SD_DAILY_LOAD_SP(
/******************************************************************
This Procedure is a wrapper for the Initial Load of the store drafts tables
    * Loads all the store drafts tables

created : 06/11/2013 jxc517 CCN Project....
changed : 06/10/2017 nxk927 CCN Project....
          Passing the in_date parameter
******************************************************************/
IN_DATE IN DATE);

FUNCTION GET_DISC_AMT_TYPE
/******************************************************************
This function will return the hexadecimal conversion of the value passed in
based on the transaction type passed in

created : 11/10/2014 jxc517 CCN Project....
changed :
******************************************************************/
(IN_TRAN_GUID        IN   VARCHAR2
,IN_SEQNBR           IN   VARCHAR2
,IN_IND              IN   VARCHAR2) RETURN VARCHAR2;

END SD_DAILY_LOAD;


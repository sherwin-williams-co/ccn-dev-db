create or replace PACKAGE SD_PAID_DETAILS_LOAD
/**************************************************************** 
This package will update paid details in the existing CCN Store Drafts Oracle Database
created : 07/23/2014 jxc517 CCN Project....
changed :
*****************************************************************/
IS

PROCEDURE CCN_SD_PAID_LOAD_SUNTRUST_SP
/******************************************************************
This Procedure is a wrapper for the SUNTRUST Paid details update of the store drafts tables

created : 12/18/2014 jxc517 CCN Project....
changed : 
******************************************************************/
;

PROCEDURE CCN_SD_PAID_LOAD_ROYAL_SP
/******************************************************************
This Procedure is a wrapper for the ROYAL Paid details update of the store drafts tables

created : 12/18/2014 jxc517 CCN Project....
changed : 
******************************************************************/
;

PROCEDURE CCN_SD_PAID_LOAD_SP
/******************************************************************
This Procedure is a wrapper for the Paid details update of the store drafts tables

created : 07/23/2014 jxc517 CCN Project....
changed :
******************************************************************/
;

END SD_PAID_DETAILS_LOAD;


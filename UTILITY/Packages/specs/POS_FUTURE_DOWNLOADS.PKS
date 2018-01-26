create or replace PACKAGE POS_FUTURE_DOWNLOADS AS
/**********************************************************
This Package contains all the procedures used commonly for
Future Polling

Created : 01/18/2018 rxv940 CCN Project....
Changed :
**********************************************************/

PROCEDURE LEAD_BANK_FUTURE_DOWNLOAD_SP(
/**********************************************************
This procedure takes care of loading all future leads into
the POS table

Created : 01/18/2018 rxv940 CCN Project....
Changed :
**********************************************************/
    IN_SERVER_NAME  IN VARCHAR2,
    IN_LOGFILE      IN VARCHAR2);

PROCEDURE MEMBER_BANK_FUTURE_DOWNLOAD_SP(
/**********************************************************
This procedure takes care of loading all future members into
the POS table

Created : 01/18/2018 rxv940 CCN Project....
Changed :
**********************************************************/
    IN_SERVER_NAME  IN VARCHAR2,
    IN_LOGFILE      IN VARCHAR2);

PROCEDURE PROCESS_FUTURE_POS_DOWNLOADS(
/**********************************************************
This procedure takes care of loading all future members into
the POS table

Created : 01/18/2018 rxv940 CCN Project....
Changed :
**********************************************************/
    IN_SERVER_NAME  IN VARCHAR2,
    IN_LOGFILE      IN VARCHAR2);

END POS_FUTURE_DOWNLOADS;
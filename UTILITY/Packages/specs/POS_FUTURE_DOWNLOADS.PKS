create or replace PACKAGE POS_FUTURE_DOWNLOADS AS
/**********************************************************
This Package contains all the procedures used commonly for
Future Polling

Created : 01/18/2018 rxv940 CCN Project....
Changed :
**********************************************************/

PROCEDURE MEMBER_BANK_FUTURE_DOWNLOAD_SP;
/**********************************************************
This procedure takes care of loading all future members into
the POS table

Created : 01/18/2018 rxv940 CCN Project....
Changed :
**********************************************************/


PROCEDURE LEAD_BANK_FUTURE_DOWNLOAD_SP;
/**********************************************************
This procedure takes care of loading all future leads into
the POS table

Created : 01/18/2018 rxv940 CCN Project....
Changed :
**********************************************************/


END POS_FUTURE_DOWNLOADS;
CREATE OR REPLACE PACKAGE BNKNG_DEPST_TKT_INPUT_PKG AS 
/**********************************************************
This Package contains all the procedures that generates
files on the server

Created : 08/19/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE CREATE_DEPOSIT_TKT_INPUT_FILE(
/******************************************************************************
This procedure is intended to create the input deposit ticket file.
Corporate Treasury will then send the bank deposit ticket information. 
Depending on the request, either of the following will be done:
    1) Add a brand new bank account/routing number and attach store(s) to it
    2) Add a new store to an existing bank account/routing number
    3) Update existing bank account/routing number.  For example, a bank gets bought out and accounts are renumbered and/or routing number changes. 
      (Note, all of these events trigger printing of deposit tickets).

Created : 08/19/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_DATE  IN  DATE);

END BNKNG_DEPST_TKT_INPUT_PKG;


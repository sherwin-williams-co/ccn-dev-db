create or replace PACKAGE PRIME_SUB_PROCESS IS


FUNCTION RETRIEVE_POS_DATA_FNC(
/*******************************************************************************
This Function is used to return the POS_DOWNLOADS information

Created : 04/03/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
    IN_POS_ID    IN NUMBER,
    IN_FILE_NAME IN VARCHAR2) RETURN POS_DOWNLOADS_GL_PS%ROWTYPE;

PROCEDURE POS_DOWNLOADS_GL_PS_UPD_SP(
/*******************************************************************************
This procedure is used do update on the table POS_DOWNLOADS_GL_PS 

Created : 04/03/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
    IN_POS_DOWNLOADS_GL_PS_REC POS_DOWNLOADS_GL_PS%ROWTYPE);

PROCEDURE PRIME_SUB_DATA_INIT_LOAD_SP(LOAD_TYPE IN VARCHAR2);
/*******************************************************************************
This procedure is used to capture the changes done on tables into pos_downloads_gl_ps 
table

Created : 03/24/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/

PROCEDURE POS_TRG_EVENT_LOG(
    IN_ACCNT_NBR        IN VARCHAR2,
    IN_DATA_SOURCE      IN VARCHAR2,
    IN_DATA_OPERATION   IN VARCHAR2,
    IN_FILE_TYPE        IN VARCHAR2);
/*******************************************************************************
This procedure is used to capture the changes done on tables into pos_downloads_gl_ps 
table

Created : 03/31/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/

PROCEDURE GEN_POS_DATA_GL_PS_UPD_SP;
/*******************************************************************************
This procedure is used to create a GENERAL_LEDGER and PRIME_SUB init load file 
for the manual updates done.

Created : 04/06/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/

END;
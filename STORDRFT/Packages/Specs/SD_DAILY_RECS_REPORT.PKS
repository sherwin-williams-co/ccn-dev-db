create or replace PACKAGE          SD_DAILY_RECS_REPORT
/**************************************************************** 
This package will generate the daily recs based on the data recevied the previous day
created : 11/03/2014 jxc517 CCN Project....
changed : 02/27/207  axt754 Added two more procedures for split of 8,9 in daily reconciliation report
*****************************************************************/
IS

PROCEDURE DISPLAY_AMOUNTS(
/*****************************************************************************
	DISPLAY_AMOUNTS
	This procedure will display all the calculated values

created : 06/11/2014 jxc517 CCN Project....
changed :
******************************************************************************/
    IN_TRANSACTION_DATE DATE);

PROCEDURE SNTRST_STRE_DRAFTS_MNTN_AMT_ST(
/*****************************************************************************
	SNTRST_STRE_DRAFTS_MNTN_AMT_ST
	This procedure will display the suntrust bank daily drafts maintenance records
	for given transaction date.
  SUNTRUST DRAFT MAINT RECORDS WRITTEN (8) - STBD1300

created : 02/23/2017 axt754 CCN Project....

******************************************************************************/
    IN_TRANSACTION_DATE DATE);

PROCEDURE SD_AUDIT_REC_READ_AMT_SPLT(
/*****************************************************************************
	SD_AUDIT_REC_READ_AMT_SPLT
	This Procedure will display records of the daily drafts with amount change date,
	void date and stop pay date as passed date
  SUNTRUST DRAFT AUDIT RECORDS READ (9) - STBD1300

created : 02/23/2017 axt754 CCN Project....

******************************************************************************/
    IN_TRANSACTION_DATE DATE);



END SD_DAILY_RECS_REPORT;
create or replace PACKAGE SD_DAILY_RECS_REPORT
/**************************************************************** 
This package will generate the daily recs based on the data recevied the previous day
created : 11/03/2014 jxc517 CCN Project....
changed :
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

END SD_DAILY_RECS_REPORT;


/*
**************************************************************************** 
This script is to create new table SD_MISSING_PAYEE_DTLS for log missing payee information
created : 2/11/2019 kxm302 CCN Project.... 
changed : 
****************************************************************************
*/
CREATE TABLE SD_MISSING_PAYEE_DTLS
   (COST_CENTER_CODE          VARCHAR2(6),
	CHECK_SERIAL_NUMBER       VARCHAR2(10),
    PAYEE_UPD_IND	          VARCHAR2(1), 
	PAYEE_INFO_RECEIVED_DATE  DATE)
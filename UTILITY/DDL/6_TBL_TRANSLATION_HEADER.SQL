/*********************************************************** 
This table contains the header for the translated value

created : 12/14/2015   jxc517 CCN Project....
modified:
************************************************************/
CREATE TABLE TRANSLATION_HEADER
   (	HEADER_NAME            VARCHAR2(50) NOT NULL ENABLE, 
	HEADER_DESCRIPTION     VARCHAR2(100), 
	HEADER_EXPIRE_FLAG     VARCHAR2(1), 
	HEADER_EXPIRE_USER     VARCHAR2(20), 
	HEADER_EXPIRE_EFF_DATE DATE, 
	HEADER_TRANSLATE_SIZE  NUMBER, 
	HEADER_SYSTEM_OWNED    VARCHAR2(1), 
	 CONSTRAINT TRANSLATION_HEADER_PK PRIMARY KEY (HEADER_NAME)
   );


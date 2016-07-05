/*******************************************************************************
  The table is used to hold the banking batchload run date configuration information 
  CREATED : 06/21/2016 MXK766 CCN PROJECT....
  CHANGED : 
*******************************************************************************/
CREATE TABLE BANKING_PARAM
(
BATCH_NAME      VARCHAR2(1000) NOT NULL,
BATCH_DATE      DATE NOT NULL
);
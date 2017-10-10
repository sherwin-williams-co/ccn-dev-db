/********************************************************************************
Creating new DESCARTES_FEED_STATUS Table to hold the 
    Descartes Daily Feed details

Created : 10/06/2017 rxa457 CCN Project Team....

********************************************************************************/

CREATE TABLE DESCARTES_FEED_STATUS(JOB_NAME                             VARCHAR2(30)   NOT NULL, 
                                   SENDER_ID                            VARCHAR2(100)  NOT NULL, 
                                   RECEIVER_ID                          VARCHAR2(100)  NOT NULL, 
                                   DOC_TYPE                             VARCHAR2(100)  NOT NULL, 
                                   CTRL_SEQ_NBR                         NUMBER  (12,0) NOT NULL, 
                                   START_DATE                           DATE           , 
                                   END_DATE                             DATE           , 
                                   JOB_STATUS                           VARCHAR2(30)   , 
                                   TRANS_STATUS                         VARCHAR2(30)   , 
                                   FEED_CLOB                            CLOB           , 
                                   CONSTRAINT DESCARTES_FEED_STATUS_PK  PRIMARY KEY (JOB_NAME,SENDER_ID,DOC_TYPE,CTRL_SEQ_NBR)
                                   );

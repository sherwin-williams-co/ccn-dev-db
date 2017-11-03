create or replace PACKAGE CCN_DESCARTES_PROCESS AS

PROCEDURE GENERATE_DESCARTES_HRCHY_FILE
/**********************************************************
This process is used to build a pipe delimited hierarchy file for descartes

Created : 09/21/2017 jxc517 CCN Project Team...
Changed : 09/28/2017 rxa457 CCN project Team...
           Time format changed to hh24 on the header as per the document
**********************************************************/
;

PROCEDURE GNRT_DSCRTS_ADDRESS_INIT_FILE(
/**********************************************************
This process is used to build a pipe delimited hierarchy file for descartes

Created : 09/21/2017 jxc517 CCN Project Team...
Changed : 
**********************************************************/
    OUT_CLOB       OUT  CLOB,
    OUT_GUID       OUT  VARCHAR2);

PROCEDURE GNRT_DSCRTS_ADDRESS_CC_FILE(
/**********************************************************
This process is used to build a pipe delimited hierarchy file for descartes

Created : 09/21/2017 jxc517 CCN Project Team...
Changed : 
**********************************************************/
    IN_COST_CENTER_CODE  IN      VARCHAR2,
    IN_TRIGGER_ACTION    IN      VARCHAR2,
    OUT_CLOB                OUT  CLOB);

PROCEDURE DESCARTES_ADRS_FEED_CC_SP(
/**********************************************************
This process is used to build a pipe delimited hierarchy file for descartes

Created : 09/21/2017 jxc517 CCN Project Team...
Changed : 
**********************************************************/
    IN_DATE       IN      DATE,  
    OUT_REF_CUR      OUT  SYS_REFCURSOR);

PROCEDURE DESCARTE_ADRS_FEED_RESP_CC_UPD(
/**********************************************************
This process is used to build a pipe delimited hierarchy file for descartes

Created : 09/21/2017 jxc517 CCN Project Team...
Changed : 
**********************************************************/
    IN_GUID       IN      VARCHAR2,
    IN_CLOB       IN      CLOB);


PROCEDURE INSERT_DESCARTES_ADRS_FEED_CC (
/**********************************************************
    INSERT_DESCARTES_ADRS_FEED_CC

    This procedure is intended to insert into INSERT_DESCARTES_ADRS_FEED_CC
        table with the details related to the Descartes address details feed run

created : 10/11/2017 rxa457 CCN project....
Modified: 
**********************************************************/
    IN_COST_CENTER_CODE            IN  DESCARTES_ADRS_FEED_CC.COST_CENTER_CODE%TYPE,
    IN_TRIGGER_ACTION              IN  DESCARTES_ADRS_FEED_CC.TRIGGER_ACTION%TYPE
                                         );												 
END CCN_DESCARTES_PROCESS;
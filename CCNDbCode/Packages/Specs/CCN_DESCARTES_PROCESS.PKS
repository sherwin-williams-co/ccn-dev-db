create or replace PACKAGE CCN_DESCARTES_PROCESS AS

PROCEDURE GENERATE_DESCARTES_HRCHY_FILE
/**********************************************************
This process is used to build a pipe delimited hierarchy file for descartes

Created : 09/21/2017 jxc517 CCN Project Team...
Changed : 09/28/2017 rxa457 CCN project Team...
           Time format changed to hh24 on the header as per the document
**********************************************************/
;

FUNCTION GET_CTRL_SEQ_NBR (
/**********************************************************
	GET_CTRL_SEQ_NBR

	This function is intended to retrun the next control sequence number for the Descartes feed job

created : 10/06/2017 rxa457 CCN project....
Modified: 
**********************************************************/
    IN_SENDER_ID           IN  DESCARTES_FEED_STATUS.SENDER_ID%TYPE,
    IN_RECEIVER_ID         IN  DESCARTES_FEED_STATUS.RECEIVER_ID%TYPE,
    IN_DOC_TYPE            IN  DESCARTES_FEED_STATUS.DOC_TYPE%TYPE
                           ) RETURN NUMBER;

PROCEDURE INSERT_FEED_STATUS (
/**********************************************************
    INSERT_FEED_STATUS

    This procedure is intended to insert a record in the DESCARTES_FEED_STATUS
        table with the details related to the Descartes feed run

created : 10/06/2017 rxa457 CCN project....
Modified: 
**********************************************************/
    IN_JOB_NAME            IN  DESCARTES_FEED_STATUS.JOB_NAME%TYPE,
    IN_SENDER_ID           IN  DESCARTES_FEED_STATUS.SENDER_ID%TYPE,
    IN_RECEIVER_ID         IN  DESCARTES_FEED_STATUS.RECEIVER_ID%TYPE,
    IN_DOC_TYPE            IN  DESCARTES_FEED_STATUS.DOC_TYPE%TYPE,
    OUT_CTRL_SEQ_NBR       OUT DESCARTES_FEED_STATUS.CTRL_SEQ_NBR%TYPE
                            );

PROCEDURE UPDATE_FEED_STATUS (
/**********************************************************
    UPDATE_FEED_STATUS

    This procedure is intended to update DESCARTES_FEED_STATUS
        table with the details related to the Descartes feed run

created : 10/06/2017 rxa457 CCN project....
Modified: 
**********************************************************/
    IN_JOB_NAME            IN  DESCARTES_FEED_STATUS.JOB_NAME%TYPE,
    IN_SENDER_ID           IN  DESCARTES_FEED_STATUS.SENDER_ID%TYPE,
    IN_RECEIVER_ID         IN  DESCARTES_FEED_STATUS.RECEIVER_ID%TYPE,
    IN_DOC_TYPE            IN  DESCARTES_FEED_STATUS.DOC_TYPE%TYPE,
    IN_CTRL_SEQ_NBR        IN  DESCARTES_FEED_STATUS.CTRL_SEQ_NBR%TYPE,
    IN_TRANS_STATUS        IN  DESCARTES_FEED_STATUS.TRANS_STATUS%TYPE,
    IN_FEED_CLOB           IN  CLOB   
                             );
END CCN_DESCARTES_PROCESS;
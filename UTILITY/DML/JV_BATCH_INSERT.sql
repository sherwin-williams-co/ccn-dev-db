--code to insert the initial record for the Storedraft JV file
SET SCAN OFF;
REM INSERTING into BATCH_JOB
SET DEFINE OFF;

INSERT
  INTO BATCH_JOB
    (
      BATCH_JOB_NAME,
      BATCH_JOB_NUMBER,
      BATCH_JOB_STATUS,
      BATCH_JOB_START_DATE,
      BATCH_JOB_END_DATE,
      BATCH_JOB_LAST_RUN_DATE,
      TRANS_STATUS
    )
    VALUES
    (
      'BENEFIT_JOB',
      BATCH_JOB_NUMBER_SEQ.NEXTVAL,
      'COMPLETED',
      SYSDATE,
      NULL,
      '01-OCT-2014',
      'SUCCESSFUL'
    );
/*
created : nxk927 06/12/2017 
          table to load pnp data for the customer data to compare it with the legacy data
*/


CREATE TABLE POS_CCN_DISC
   (DISCFLAG      NUMBER,
    DISCPR        NUMBER,
    DISCRSN       VARCHAR2(20),
    ENTRYMODE     VARCHAR2(5),
    EXPREASON     VARCHAR2(30),
    GRP           VARCHAR2(5),
    NONTAXAMT     NUMBER,
    PCT           NUMBER,
    SEQNBR        NUMBER,
    SERIALNBR     VARCHAR2(15),
    SPCTAXAMT     NUMBER,
    TAXAMT        NUMBER,
    TRAN_GUID     RAW(16) NOT NULL,
    TYP           VARCHAR2(5),
    DISC_GUID     RAW(16),
    RLS_RUN_CYCLE NUMBER,
    LOAD_DATE     DATE
   );

  CREATE INDEX STORDRFT.CCN_DISC_INDEX ON STORDRFT.POS_CCN_DISC (TRAN_GUID, SEQNBR);

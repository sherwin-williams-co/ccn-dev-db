  CREATE TABLE TEMP_PCI_TERMINAL_INFO
   (COST_CENTER_CODE     VARCHAR2(4),
    PCI_TERMINAL_ID      VARCHAR2(50),
    TERM_NUMBER          VARCHAR2(50),
    STATIC_IP            VARCHAR2(50),
    NETMASK_IP           VARCHAR2(50),
    GATEWAY_IP           VARCHAR2(50),
    DNS_IP               VARCHAR2(50),
    COMM_SN              VARCHAR2(50),
    PAX_SN               VARCHAR2(50),
    PAX_UID              VARCHAR2(50),
    PCI_VALUE_LINK_MID   VARCHAR2(50),
    PCI_VAL_LINK_ALT_MID VARCHAR2(50))
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS delimited by NEWLINE
        SKIP 3
        badfile CCN_LOAD_FILES:'TEMP_PCI_TERMINAL_ID.bad'
        logfile CCN_LOAD_FILES:'TEMP_PCI_TERMINAL_ID.log'
        discardfile CCN_LOAD_FILES:'TEMP_PCI_TERMINAL_ID.dsc'
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (COST_CENTER_CODE     CHAR(4),
         PCI_TERMINAL_ID      CHAR(50),
         TERM_NUMBER          CHAR(50),
         STATIC_IP            CHAR(50),
         NETMASK_IP           CHAR(50),
         GATEWAY_IP           CHAR(50),
         DNS_IP               CHAR(50),
         COMM_SN              CHAR(50),
         PAX_SN               CHAR(50),
         PAX_UID              CHAR(50),
         PCI_VALUE_LINK_MID   CHAR(50),
         PCI_VAL_LINK_ALT_MID CHAR(50)))
      LOCATION
       ( 'PCI_TERMINAL_INFO.csv'
       )
    );

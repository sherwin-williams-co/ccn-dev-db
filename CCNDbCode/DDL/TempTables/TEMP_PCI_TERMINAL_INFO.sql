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
    PCI_VAL_LINK_ALT_MID VARCHAR2(50)
    ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( records delimited by newline skip 3
        badfile CCN_LOAD_FILES:'TEMP_PCI_TERMINAL_ID.bad'
        logfile CCN_LOAD_FILES:'TEMP_PCI_TERMINAL_ID.log'
        discardfile CCN_LOAD_FILES:'TEMP_PCI_TERMINAL_ID.dsc'
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LRTRIM
    missing field values are null 
   REJECT ROWS WITH ALL NULL FIELDS
       (
         COST_CENTER_CODE,
         PCI_TERMINAL_ID,
         TERM_NUMBER,
         STATIC_IP,
         NETMASK_IP,
         GATEWAY_IP,
         DNS_IP,
         COMM_SN,
         PAX_SN,
         PAX_UID,
         PCI_VALUE_LINK_MID,
         PCI_VAL_LINK_ALT_MID
        )
      )
      LOCATION
       ( 'PCI_TERMINAL_INFO.csv'
        )
    )
    REJECT LIMIT UNLIMITED;
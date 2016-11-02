/*
Below scripts will create tables needed for processors window

Created : 10/14/2016 jxc517 CCN Project Team....
*/
--Processor Groups
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PROCESSOR_GROUPS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PROCESSOR_GROUPS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PROCESSOR_GROUPS (
GROUP_ID       NUMBER,
GROUP_NAME     VARCHAR2(100),
EFFECTIVE_DATE DATE,
CREATED_BY     VARCHAR2(50),
CONSTRAINT PROCESSOR_GROUPS_PK PRIMARY KEY (GROUP_ID)
);
/

CREATE TABLE HIST_PROCESSOR_GROUPS (
GROUP_ID         NUMBER,
GROUP_NAME       VARCHAR2(100),
EFFECTIVE_DATE   DATE,
CREATED_BY       VARCHAR2(50),
HIST_LOAD_DATE   DATE
);
/

--Processors
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PROCESSORS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PROCESSORS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PROCESSORS (
    PROCESSOR_ID     NUMBER,
    PROCESSOR_NAME   VARCHAR2(200),
    PHONE_NUMBER     VARCHAR2(50),
    EFFECTIVE_DATE   DATE,
    CREATED_BY       VARCHAR2(50),
    CONSTRAINT PROCESSORS_PK PRIMARY KEY (PROCESSOR_ID)
);
/

CREATE TABLE HIST_PROCESSORS (
    PROCESSOR_ID     NUMBER,
    PROCESSOR_NAME   VARCHAR2(200),
    PHONE_NUMBER     VARCHAR2(50),
    EFFECTIVE_DATE   DATE,
    CREATED_BY       VARCHAR2(50),
    HIST_LOAD_DATE   DATE
);
/

--Processor Store Group Details
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRCSR_STR_GRP_DTLS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PRCSR_STR_GRP_DTLS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PRCSR_STR_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    STATE_CODE          VARCHAR2(2),
    CONSTRAINT PRCSR_STR_GRP_DTLS_PK PRIMARY KEY (GROUP_ID, STATE_CODE),
    CONSTRAINT PRCSR_STR_GRP_DTLS_FK1 FOREIGN KEY (GROUP_ID) REFERENCES PROCESSOR_GROUPS(GROUP_ID),
    CONSTRAINT PRCSR_STR_GRP_DTLS_FK2 FOREIGN KEY (PROCESSOR_ID) REFERENCES PROCESSORS(PROCESSOR_ID)
);
/

CREATE TABLE HIST_PRCSR_STR_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    STATE_CODE          VARCHAR2(2),
    HIST_LOAD_DATE      DATE
);
/

--Processor Store Admin Group Details
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRCSR_STR_ADMN_GRP_DTLS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PRCSR_STR_ADMN_GRP_DTLS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PRCSR_STR_ADMN_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    CONSTRAINT PRCSR_STR_ADMN_GRP_DTLS_PK PRIMARY KEY (GROUP_ID),
    CONSTRAINT PRCSR_STR_ADMN_GRP_DTLS_FK1 FOREIGN KEY (GROUP_ID) REFERENCES PROCESSOR_GROUPS(GROUP_ID),
    CONSTRAINT PRCSR_STR_ADMN_GRP_DTLS_FK2 FOREIGN KEY (PROCESSOR_ID) REFERENCES PROCESSORS(PROCESSOR_ID)
);
/

CREATE TABLE HIST_PRCSR_STR_ADMN_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    HIST_LOAD_DATE      DATE
);
/

--Processor Canada Group Details
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRCSR_CANADA_GRP_DTLS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PRCSR_CANADA_GRP_DTLS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PRCSR_CANADA_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    CONSTRAINT PRCSR_CANADA_GRP_DTLS_PK PRIMARY KEY (GROUP_ID),
    CONSTRAINT PRCSR_CANADA_GRP_DTLS_FK1 FOREIGN KEY (GROUP_ID) REFERENCES PROCESSOR_GROUPS(GROUP_ID),
    CONSTRAINT PRCSR_CANADA_GRP_DTLS_FK2 FOREIGN KEY (PROCESSOR_ID) REFERENCES PROCESSORS(PROCESSOR_ID)
);
/

CREATE TABLE HIST_PRCSR_CANADA_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    HIST_LOAD_DATE      DATE
);
/

--Processor Head Quarters Group Details
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRCSR_HEADQRTS_GRP_DTLS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PRCSR_HEADQRTS_GRP_DTLS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PRCSR_HEADQRTS_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    CONSTRAINT PRCSR_HEADQRTS_GRP_DTLS_PK PRIMARY KEY (GROUP_ID),
    CONSTRAINT PRCSR_HEADQRTS_GRP_DTLS_FK1 FOREIGN KEY (GROUP_ID) REFERENCES PROCESSOR_GROUPS(GROUP_ID),
    CONSTRAINT PRCSR_HEADQRTS_GRP_DTLS_FK2 FOREIGN KEY (PROCESSOR_ID) REFERENCES PROCESSORS(PROCESSOR_ID)
);
/

CREATE TABLE HIST_PRCSR_HEADQRTS_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    HIST_LOAD_DATE      DATE
);
/

--Processor Retirees Group Details
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRCSR_RETIREES_GRP_DTLS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PRCSR_RETIREES_GRP_DTLS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PRCSR_RETIREES_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    CONSTRAINT PRCSR_RETIREES_GRP_DTLS_PK PRIMARY KEY (GROUP_ID),
    CONSTRAINT PRCSR_RETIREES_GRP_DTLS_FK1 FOREIGN KEY (GROUP_ID) REFERENCES PROCESSOR_GROUPS(GROUP_ID),
    CONSTRAINT PRCSR_RETIREES_GRP_DTLS_FK2 FOREIGN KEY (PROCESSOR_ID) REFERENCES PROCESSORS(PROCESSOR_ID)
);
/

CREATE TABLE HIST_PRCSR_RETIREES_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    HIST_LOAD_DATE      DATE
);
/

--Processor Automotive Group Details
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRCSR_AUTO_GRP_DTLS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PRCSR_AUTO_GRP_DTLS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PRCSR_AUTO_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    CONSTRAINT PRCSR_AUTO_GRP_DTLS_PK PRIMARY KEY (GROUP_ID),
    CONSTRAINT PRCSR_AUTO_GRP_DTLS_FK1 FOREIGN KEY (GROUP_ID) REFERENCES PROCESSOR_GROUPS(GROUP_ID),
    CONSTRAINT PRCSR_AUTO_GRP_DTLS_FK2 FOREIGN KEY (PROCESSOR_ID) REFERENCES PROCESSORS(PROCESSOR_ID)
);
/

CREATE TABLE HIST_PRCSR_AUTO_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    HIST_LOAD_DATE      DATE
);
/

--Processor International Group Details
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRCSR_INTRNTL_GRP_DTLS';
    EXECUTE IMMEDIATE 'DROP TABLE HIST_PRCSR_INTRNTL_GRP_DTLS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE PRCSR_INTRNTL_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    CONSTRAINT PRCSR_INTRNTL_GRP_DTLS_PK PRIMARY KEY (GROUP_ID),
    CONSTRAINT PRCSR_INTRNTL_GRP_DTLS_FK1 FOREIGN KEY (GROUP_ID) REFERENCES PROCESSOR_GROUPS(GROUP_ID),
    CONSTRAINT PRCSR_INTRNTL_GRP_DTLS_FK2 FOREIGN KEY (PROCESSOR_ID) REFERENCES PROCESSORS(PROCESSOR_ID)
);
/

CREATE TABLE HIST_PRCSR_INTRNTL_GRP_DTLS (
    GROUP_ID            NUMBER,
    PROCESSOR_ID        NUMBER,
    EFFECTIVE_DATE      DATE,
    CREATED_BY          VARCHAR2(50),
    HIST_LOAD_DATE      DATE
);
/
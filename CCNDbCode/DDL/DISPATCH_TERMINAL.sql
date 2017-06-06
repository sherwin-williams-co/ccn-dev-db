/********************************************************************************
Creating new Cost Center Terminal Table to hold the Terminal home store attached to the cost center in case of Terminal Type cost centers 

Created : 04/11/2017 rxa457 CCN Project Team....
Created:
********************************************************************************/

CREATE TABLE DISPATCH_TERMINAL(
      COST_CENTER_CODE         VARCHAR2(6) NOT NULL , 
      CATEGORY               VARCHAR2(1) DEFAULT 'D' NOT NULL  , 
      HOME_STORE   VARCHAR2(6) NOT NULL , 
      CONSTRAINT DISPATCH_TERMINAL_PK PRIMARY KEY (COST_CENTER_CODE),
      CONSTRAINT DISPATCH_TERMINAL_FK1 FOREIGN KEY (COST_CENTER_CODE) REFERENCES COST_CENTER (COST_CENTER_CODE) ,
      CONSTRAINT DISPATCH_TERMINAL_FK2 FOREIGN KEY (HOME_STORE) REFERENCES COST_CENTER (COST_CENTER_CODE) 
);

create or replace PACKAGE CCN_GL_PS_ACCOUNTS_PKG
AS
TYPE REF_CURSOR IS REF CURSOR;
PROCEDURE GL_ACCOUNTS_PROG_UI_DELETE_SP(
/******************************************************************************
This procedure takes XML which has GL ACCOUNT NUMBER and DELETES 
Programs information given in the XML, that were attached to GL ACCOUNT NUMBER 

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
    <USER_ID>axt754</USER_ID>
    <GENERAL_LEDGER_ACCOUNTS_TBL>
      <GENERAL_LEDGER_ACCOUNTS>
            <GL_ACCOUNT_NUMBER>33388809</GL_ACCOUNT_NUMBER>
            </DESCRIPTION>
            <PROFIT_OR_LOSS>65</PROFIT_OR_LOSS>
            <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </GENERAL_LEDGER_ACCOUNTS>
    </GENERAL_LEDGER_ACCOUNTS_TBL>
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>      
</ACCOUNTS_UI>
   
Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate DELETE for ACCOUNTS, PROGRAMS and RELATION
        : 08/25/2017 axt754 -- No Delete of Existing Accounts
******************************************************************************/
    in_xml          IN          CLOB);
    
PROCEDURE PROGRAM_UI_DELETE_SP(
/******************************************************************************
This procedure takes XML as input Which has PROGRAM information 
and Deletes the PROGRAM related information

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <USER_ID>axt754</USER_ID>
   <PROGRAMS_TBL>
      <PROGRAMS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PROGRAMS>
    </PROGRAMS_TBL> 
</ACCOUNTS_UI>
   
Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate DELETE for ACCOUNTS, PROGRAMS and RELATION
        : 08/24/2017 axt754 -- If a Program has the accounts in relation donot delete program
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE PROG_GL_ACCOUNTS_UI_DELETE_SP(
/******************************************************************************
This procedure takes XML as input Which has PROGRAM information 
and Deletes the account information given in XML, attached to program
Or Deletes the PROGRAM related information

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <USER_ID>axt754</USER_ID>
   <PROGRAMS_TBL>
      <PROGRAMS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PROGRAMS>
    </PROGRAMS_TBL> 
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388809</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388810</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate DELETE for ACCOUNTS, PROGRAMS and RELATION
        : 08/24/2017 axt754 -- If a Program has the accounts in relation donot delete program
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE PROG_GL_ACCOUNTS_UI_UPSERT_SP(
/******************************************************************************
This procedure takes XML which has PROGRAM_NAME and Inserts/Updates 
the given ACCOUNT_NUMBERS in the XML to the the PROGRAM Or Inserts/Updates 
any PROGRAM related information

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <USER_ID>axt754</USER_ID>
   <PROGRAMS_TBL>
      <PROGRAMS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PROGRAMS>
    </PROGRAMS_TBL> 
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388809</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388810</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate UPSERT for ACCOUNTS, PROGRAMS and RELATION
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE GL_ACCOUNTS_PROG_UI_UPSERT_SP(
/******************************************************************************
This procedure takes XML which has GL_ACCOUNT_NUMBER and Inserts/Updates 
the given PROGRAMS in the XML to the the GL_ACCOUNT_NUMBER Or Updates given GL 
ACCOUNT information

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <USER_ID>axt754</USER_ID>
   <GENERAL_LEDGER_ACCOUNTS_TBL>
      <GENERAL_LEDGER_ACCOUNTS>
            <GL_ACCOUNT_NUMBER>33388809</GL_ACCOUNT_NUMBER>
            </DESCRIPTION>
            <PROFIT_OR_LOSS>65</PROFIT_OR_LOSS>
            <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </GENERAL_LEDGER_ACCOUNTS>
    </GENERAL_LEDGER_ACCOUNTS_TBL>
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example11</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>     
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate UPSERT for ACCOUNTS, PROGRAMS and RELATION
        : 08/25/2017 axt754 -- No Insert of New Accounts
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE GL_ACCOUNTS_PROG_UI_S_SP(
/****************************************************************************** 
This procedures account number as input and retrives programs that were associated
with the given account and the account information as well. 
Created : 08/15/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_accnt_nbr             IN      VARCHAR2
    ,out_gl_accnt_refcursor     OUT  SYS_REFCURSOR
    ,out_prg_accnt_refcursor    OUT  SYS_REFCURSOR);

PROCEDURE PROG_GL_ACCOUNTS_UI_S_SP(
/****************************************************************************** 
This procedure program name as input and gives the accounts related to Program
related information

Created : 08/15/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_prog_name             IN           VARCHAR2
    ,out_prg_refcursor          OUT        SYS_REFCURSOR
    ,out_prg_accnt_refcursor    OUT        SYS_REFCURSOR);

PROCEDURE PROGRAMS_UI_S_SP(
/****************************************************************************** 
This procedures takes program name as input and retrives the data from 
PROGRAMS Table, if the program name is not passed then retrives all the program
names from PROGRAMS Table

Created : 08/16/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_prog_name             IN           VARCHAR2
    ,out_prg_refcursor          OUT       SYS_REFCURSOR);

PROCEDURE GL_ACCOUNTS_UI_S_SP(
/****************************************************************************** 
This procedures takes GL_ACCOUNT_NUMBER as input and retrives the data from 
GENERAL_LEDGER_ACCOUNTS Table, if the GL_ACCOUNT_NUMBER is not passed then retrives all the accounts
from GENERAL_LEDGER_ACCOUNTS Table

Created : 08/16/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_accnt_nbr             IN           VARCHAR2
    ,out_gl_accnt_refcursor     OUT       SYS_REFCURSOR);

PROCEDURE GENERATE_PRIMESUB_DETAILS_RPT
/******************************************************************************
This procedure is intended to generate an PrimeSub details and email it to Pat team.

Filters:
Created : 08/16/2018 kxm302 CCN project Team....
******************************************************************************/
;

END CCN_GL_PS_ACCOUNTS_PKG;
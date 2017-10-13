create or replace PACKAGE CCN_GL_PS_ACCNTS_INIT_LOAD AS
 /****************************************************************************** 
This package is intended Load the data into tables gen_ledge_accounts and 
GL_PRIME_SUB_ACCOUNT_DTLS

created : 03/15/2017 axt754 -- CCN Project Team...

******************************************************************************/
PROCEDURE PRIME_GL_ACCOUNTS_MAIN_SP
/****************************************************************************** 
This procedures takes XML as input and Load the data into tables 
gen_ledge_accounts and GL_PRIME_SUB_ACCOUNT_DTLS

created : 03/15/2017 axt754 -- CCN Project Team

******************************************************************************/
      ;
     
END CCN_GL_PS_ACCNTS_INIT_LOAD;
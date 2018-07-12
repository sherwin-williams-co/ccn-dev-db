/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for LOAD_SWC_PN_SQFT_INT to CCN Team.
Created : 07/11/2018 kxm302 CCN Project 
Modified:
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
INSERT INTO MAILING_GROUP(GROUP_ID,
                          MAIL_ID
                          ) 
                  VALUES ('118',
                          'ccnoracle.team@sherwin.com'
                          );

REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
INSERT INTO MAILING_DETAILS(MAIL_CATEGORY,
                            GROUP_ID,
                            SUBJECT,
                            FROM_P,
                            MESSAGE,
                            SIGNATURE
                            )
                     VALUES('LOAD_SWC_PN_SQFT_INT',
                            '118',
                            'Load to CCN_SWC_PN_SQFT_INT failed',
                            'ccnoracle.team@sherwin.com',
                            'Loading data into CCN_SWC_PN_SQFT_INT failed',
                            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
                            );

COMMIT;

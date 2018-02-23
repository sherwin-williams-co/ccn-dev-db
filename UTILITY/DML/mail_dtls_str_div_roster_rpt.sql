/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for stores division roster report generation error.
Created : 02/13/2018 nxk927 CCN Project 
Modified:
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
INSERT INTO MAILING_GROUP(GROUP_ID,
                          MAIL_ID
                          ) 
                  VALUES ('74',
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
                     VALUES('STORES_DIV_ROSTER_RPT',
                            '74',
                            'Process failed while generating stores division roster report',
                            'ccnoracle.team@sherwin.com',
                            'Process failed while generating stores division roster report. Please check the error log file in the server',
                            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
                            );

COMMIT;

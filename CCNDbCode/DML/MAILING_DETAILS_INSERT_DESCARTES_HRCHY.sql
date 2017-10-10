/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for DESCARTES org HRCHY feed to report any file generation errors to CCN Team.
Created : 09/28/2017 rxa457 CCN Project 
Modified:
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
INSERT INTO MAILING_GROUP(GROUP_ID,
                          MAIL_ID
                          ) 
                  VALUES ('96',
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
                     VALUES('DESCARTES_HRCHY_FILE_ERROR',
                            '96',
                            'Error: DESCARTES Hierarchy Details File Generation Failed',
                            'ccnoracle.team@sherwin.com',
                            'Hierarchy Details File Generation for DESCARTES failed - Please refer attachment for Error log file',
                            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
                            );

COMMIT;

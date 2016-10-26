/*****************************************************************************
Below script is to store mailing details for installer retainage refund report

created : 10/26/2016 nxk927 CCN Project....
changed :
*****************************************************************************/
INSERT INTO MAILING_GROUP VALUES (53, 'ccnoracle.team@sherwin.com;storesarjv@sherwin.com');
INSERT INTO MAILING_DETAILS VALUES ('INSTALLER_RETAINAGE_REFUND', 53, 'Store Drafts Installer Retainage Refund Report', 'ccnoracle.team@sherwin.com', 'Below excel contains the details about INSTALLER RETAINAGE REFUND REPORT.', 'Thanks,' || CHR(10) ||'Keith D. Parker' || CHR(10) || 'IT Manager' || CHR(10) || 'Sherwin Williams - Stores IT');

COMMIT;

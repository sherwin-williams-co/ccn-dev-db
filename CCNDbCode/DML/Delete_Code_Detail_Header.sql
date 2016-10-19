/********************************************************************************
Below script will delete from CODE_DETAIL and CODE_HEADER

Created : 09/06/2016 vxv336 CCN Project Team
Modified: 10/19/2016 vxv336
                     Added SYSOUT
********************************************************************************/

DELETE FROM CODE_DETAIL WHERE CODE_HEADER_NAME IN ('DCM', 'ACM', 'RCM', 'SYSOUT');
DELETE FROM CODE_HEADER WHERE CODE_HEADER_NAME IN ('DCM', 'ACM', 'RCM', 'SYSOUT');
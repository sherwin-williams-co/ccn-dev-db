/*
Created :pxb712 -Update the message to be displayed in email content for the subject "PCI Terminal ID count and terminal number count do not match" 
*/

SET DEFINE OFF; 

Update MAILING_DETAILS set MESSAGE = 'Please find the attached excel sheet with the list of Cost Centers which do not have same number of PCI Terminal ID and terminal number.' where GROUP_ID = 28;

COMMIT;


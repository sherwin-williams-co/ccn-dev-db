/*
Change by rxv940 on 03/15/2018
Run this in Utility
 Removed code for mail category 'STORE_BANK_CARD_MERCHANT' and 'STORE_BANK_CARD_SERIAL'
 - Files are getting FTP'ed

*/
    -- Delete from MAILING_DETAILS
    DELETE 
      FROM MAILING_DETAILS 
     WHERE GROUP_ID IN ('64', '65');

    -- Delete from MAILING_GROUP
    DELETE 
      FROM MAILING_GROUP 
     WHERE GROUP_ID IN ('64', '65');


    -- Update the description to be meaningful
    UPDATE MAILING_DETAILS
       SET MESSAGE = 'Store Bank Card File generation failed - Please refer the log file'
     WHERE GROUP_ID IN ('66');   
    COMMIT;
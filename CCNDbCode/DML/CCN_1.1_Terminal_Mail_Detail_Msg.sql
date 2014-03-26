--Updating the Message for ADD_TERMINAL
UPDATE MAILING_DETAILS
   SET MESSAGE = 'Terminal XXXXX has been Added Successfully for Cost Center CCCCCC.'
 WHERE MAIL_CATEGORY = 'ADD_TERMINAL';

COMMIT;

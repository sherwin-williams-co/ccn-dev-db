/*
created: 12/14/2018 pxa852 CCn Project Team...
         Included SMIS team in the mailing group
*/

select * from mailing_group where group_id = '104';

update mailing_group
set MAIL_ID = 'ccnoracle.team@sherwin.com;smis@sherwin.com'
where group_id = '104';

select * from mailing_group where group_id = '104';

COMMIT;
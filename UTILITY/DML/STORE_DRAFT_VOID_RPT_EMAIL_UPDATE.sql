/*--------------------------------------------------------------------------------
Removing Katie.M.Pschesang@sherwin.com and adding lee.Niedenthal@sherwin.com to the distribution list. 
---------------------------------------------------------------------------------*/
select * from mailing_group where group_id = '39';

update mailing_group
set MAIL_ID = 'ccnoracle.team@sherwin.com;lee.Niedenthal@sherwin.com;tom.w.beifuss@sherwin.com'
where group_id = '39'; 

select * from mailing_group where group_id = '39';

COMMIT;
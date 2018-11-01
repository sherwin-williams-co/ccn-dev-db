/**********************************************************************************
Removing Katie.M.Pschesang@sherwin.com and adding lee.Niedenthal@sherwin.com to the distribution list.

Created : 11/01/2018 pxa852 CCN Project ASP-1160....
Modified:
**********************************************************************************/

select * from mailing_group where group_id = '39';

update mailing_group
set MAIL_ID = 'ccnoracle.team@sherwin.com;lee.Niedenthal@sherwin.com;tom.w.beifuss@sherwin.com'
where group_id = '39'; 

select * from mailing_group where group_id = '39';

COMMIT;
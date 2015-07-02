/********************************************************************
07/02/2015 axk326 CCN Project Team. 
Updating mailing_group table for daily DAD Comparison File.
*********************************************************************/
update mailing_group 
set mail_id = 'Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com;Abhitej.Kasula@sherwin.com;sinthujan.thamo@sherwin.com;durga.sowjanya.vanaparti@sherwin.com;smis@sherwin.com'
where group_id = '18';
commit;
/********************************************************************
11/25/2014. Updating mailing_group table for daily reconcile reports.
*********************************************************************/
update mailing_group 
set mail_id = 'Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com;Abhitej.Kasula@sherwin.com;sinthujan.thamo@sherwin.com;tim.sturtevant@sherwin.com;jeklodnick@sherwin.com;leonard.t.koestner@sherwin.com;katherine.m.veglia@sherwin.com'
where group_id = '12';
commit;
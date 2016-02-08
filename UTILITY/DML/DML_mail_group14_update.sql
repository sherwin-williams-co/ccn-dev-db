--removing daniel Carmen from the group 14 which is for HIER_TRNSFR_DAD_CHNG_TERRITORY
--removed daniel.r.carmen@sherwin.com
--nxk927 2/05/2015

UPDATE MAILING_GROUP
   SET MAIL_ID ='Keith.D.Parker@sherwin.com;Shahla.Husain@sherwin.com;Nirajan.Karki@sherwin.com;Jaydeep.Cheruku@sherwin.com;Abhitej.Kasula@sherwin.com;durga.sowjanya.vanaparti@sherwin.com;amarender.reddy.devidi@sherwin.com;mahesh.repala@sherwin.com;pmmalloy@sherwin.com;lboyd@sherwin.com'
 WHERE GROUP_ID = '14';

COMMIT;
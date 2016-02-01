--removing Naomi Myers from the group 8 which is for Territory Hierarchy Transfer
--removed naomi.myers@sherwin.com
--nxk927 1/29/2015

UPDATE MAILING_GROUP
   SET MAIL_ID ='Keith.D.Parker@sherwin.com;Shahla.Husain@sherwin.com;Nirajan.Karki@sherwin.com;Jaydeep.Cheruku@sherwin.com;Abhitej.Kasula@sherwin.com;durga.sowjanya.vanaparti@sherwin.com;amarender.reddy.devidi@sherwin.com;mahesh.repala@sherwin.com;pmmalloy@sherwin.com;Antoinette.E.Thomey@sherwin.com'
 WHERE GROUP_ID = '8';

COMMIT;
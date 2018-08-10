/*******************************************************************************
Alter table script to add descartes_delivery_code field to store tables.

CREATED : 08/09/2018 pxa852 CCN Project...
*******************************************************************************/

   alter table store add descartes_delivery_code VARCHAR2(1);

commit;
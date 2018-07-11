/*******************************************************************************
Alter table script to add cleansing flag to address_usa and address_can tables.
This field is added to track the standardized address changes.
This field will be set to 'Y' if user changes the standardized address from UI. 
These records will not be considered for cleansing process.
  CREATED : 07/10/2018 pxa852 CCN Project...
*******************************************************************************/

   alter table address_usa add cleansing_flag varchar2(1);
   alter table address_can add cleansing_flag varchar2(1);

commit;
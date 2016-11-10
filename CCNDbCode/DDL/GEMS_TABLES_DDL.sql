
/**********************************************************
Changed : 11/10/2016 sxh487 CCN Project....
          Dropping the two columns EMRG_CONTACT_NAME and EMRG_CONTACT_PHONE
          from the two tables EMP_GEMS_SYNC_TB and SWC_HR_GEMS_TB
**********************************************************/

alter table EMP_GEMS_SYNC_TB drop (EMRG_CONTACT_NAME, EMRG_CONTACT_PHONE); 
alter table SWC_HR_GEMS_TB drop (EMRG_CONTACT_NAME, EMRG_CONTACT_PHONE); 
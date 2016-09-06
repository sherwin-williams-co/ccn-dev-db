/******************************************************************************
External table for loading Credit Hierarchy data

created : 08/29/2016 vxv336 CCN project team
modified: 
*******************************************************************************/

  CREATE TABLE TEMP_CREDIT_HIER_ATTR_DTLS
   (Dist_num varchar2(10),
   ACM_Name	varchar2(200),
   DCM_Name	varchar2(200),
   DCO	    varchar2(10),
   DCO_DESC varchar2(200)
   )
   
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( records delimited by newline 
        FIELDS TERMINATED BY ',' 
        LRTRIM
        missing field values are null 
        (Dist_num,
         ACM_Name,
         DCM_Name,
         DCO,
         DCO_DESC
        )
           )
      LOCATION
       ( 'credit_hierarchy_attr.csv'
       )
    );
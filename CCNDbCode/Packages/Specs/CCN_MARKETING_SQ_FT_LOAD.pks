create or replace PACKAGE CCN_MARKETING_SQ_FT_LOAD AS
/****************************************************************************** 
This package is intended update the data in Marketing table 

Created : 12/05/2017 axt754 -- CCN Project Team...
Changed : 
******************************************************************************/
   
PROCEDURE UI_PROCESS_SQ_FT_LD
/****************************************************************************** 
This procedures takes care of following things as part of batch load process from UI
  # Get the data from UI
  # Upload the file on DB SERVER
  # call the batch process

Created : 12/05/2017 axt754 -- CCN Project Team
Changes :
******************************************************************************/
;

PROCEDURE BATCH_PROCESS_SQ_FT_LD
/****************************************************************************** 
This procedures takes care of following things as part of batch load process
  # Get the data from SWC_PN_SQFT_INT_V
  # Compares the data
  # updates the data if there are any changes

Created : 02/09/2018 axt754 -- CCN Project Team
Changes :
******************************************************************************/
;
PROCEDURE LOAD_SWC_PN_SQFT_INT
/******************************************************************************
This procedures takes care of following things as part of batch load process
  # Get the data from SWC_PN_SQFT_INT_V and load to CCN_SWC_PN_SQFT_INT table

Created : 07/10/2018 kxm302 -- CCN Project Team
*******************************************************************************/
;    
END CCN_MARKETING_SQ_FT_LOAD;
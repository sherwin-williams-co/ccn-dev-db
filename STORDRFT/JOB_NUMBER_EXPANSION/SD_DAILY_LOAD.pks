--------------------------------------------------------
--  File created - Tuesday-August-24-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package SD_DAILY_LOAD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "STORDRFT"."SD_DAILY_LOAD" AUTHID CURRENT_USER AS
/**************************************************************** 
This package will load the existing CCN Store Drafts Oracle Database
created : 06/11/2013 jxc517 CCN Project....
changed :
*****************************************************************/


PROCEDURE CCN_SD_DAILY_LOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the store drafts tables
    * Loads all the store drafts tables

created : 06/11/2013 jxc517 CCN Project....
changed : 06/10/2017 nxk927 CCN Project....
          Passing the in_date parameter
changed : 10/03/2017 nxk927 CCN Project....
          removing the date parameter for the daily load process
******************************************************************/
;

FUNCTION GET_DISC_AMT_TYPE
/******************************************************************
This function will return the discount and the discount type
based on the inidcator passed in

created : 06/10/2017 nxk927 CCN Project....
changed :
******************************************************************/
(IN_TRAN_GUID        IN   VARCHAR2
,IN_SEQNBR           IN   VARCHAR2
,IN_IND              IN   VARCHAR2) RETURN VARCHAR2;

PROCEDURE SD_UPDATE_DAILY_PARAM_SP
/******************************************************************
This Procedure resets the rundates for 9 reports
    * Updates dates on storedrft_param table

created : 09/17/2020 CCN Project

******************************************************************/
;

PROCEDURE DAILY_LOAD_CUSTOMER_TAXID_VW;
/******************************************************************************************
This Procedure is created to load CUSTOMER_TAXID_VW table as part of ccn_sd_daily_load cc_employee_tax_load
 01/29/2021 by VXT699 
******************************************************************************************/

END SD_DAILY_LOAD;

/

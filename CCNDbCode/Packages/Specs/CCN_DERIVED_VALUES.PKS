create or replace PACKAGE          "CCN_DERIVED_VALUES" AS 
/*********************************************************** 
This package SPEC is intended to derive values for CCN user   

created : 09/13/2018 kxm302 CCN Proeject Team.....
        : Derives Cost Center Manager Name ASP - 1128
************************************************************/

FUNCTION GET_CC_MANAGER_NAME(
/***********************************************************
This function will return Manager Name for given Cost Center Code

Created : 03/28/2018 sxg151 CCN Project ASP-1048
modified: 
************************************************************/
    IN_COST_CENTER_CODE     IN EMPLOYEE_DETAILS.COST_CENTER_CODE%TYPE)
RETURN VARCHAR2;

PROCEDURE CALCULATE_MARKETING_FIELDS(
/******************************************************************************
This procedures takes Marketing record as input and
calculates the sq foot values
created : 10/17/2018 pxa852 CCN Project Team...
Changed :
******************************************************************************/
    IO_MARKETING_REC    IN OUT   MARKETING%ROWTYPE);

END CCN_DERIVED_VALUES;
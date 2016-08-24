/**********************************************************
Script Name- ALTER_COST_CENTER_TABLE
Description- This SQL Script adds new columns std_cost_identifier
             and prim_cost_identifier in cost_center table
Created    - MXR916 07/11/2016
**********************************************************/

ALTER TABLE COST_CENTER 
  ADD std_cost_identifier VARCHAR2(2);


ALTER TABLE COST_CENTER 
  ADD prim_cost_identifier VARCHAR2(2);

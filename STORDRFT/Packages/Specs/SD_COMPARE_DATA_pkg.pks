create or replace PACKAGE SD_COMPARE_DATA_pkg
/**************************************************************** 
Purpose : Comapre Data Package is Used to get the Difference records and 
           Matching records between two table data.  
Created : 05/19/2016 axd783 CCN Project Team...
Changed :
*****************************************************************/
AS

PROCEDURE DIFF_DATA_sp(
/**************************************************************** 
Purpose : This will create a Diff .CSV formatted file on the the server 
          Input Parameters:
          in_TABLE_NAME1,in_TABLE_NAME2 : tables to be compared
          in_file_name : Name of the Diff file to be written on server
          in_key : Key columns to compare two tables      
Created : 05/19/2016 axd783 CCN Project Team...
Changed :
*****************************************************************/
    in_TABLE_NAME1  IN     VARCHAR2,
    in_TABLE_NAME2  IN     VARCHAR2,
    in_file_name    IN     VARCHAR2,
    in_key          IN     VARCHAR2 DEFAULT NULL);

PROCEDURE MATCH_DATA_sp(
/**************************************************************** 
Purpose : This will create a Diff .CSV formatted file on the the server 
          Input Parameters:
          in_TABLE_NAME1,in_TABLE_NAME2 : tables to be compared
          in_file_name : Name of the Match file to be written on server           
Created : 05/19/2016 axd783 CCN Project Team...
Changed :
*****************************************************************/
    in_TABLE_NAME1   IN     VARCHAR2,
    in_TABLE_NAME2   IN     VARCHAR2,
    in_file_name     IN     VARCHAR2);

END SD_COMPARE_DATA_pkg;
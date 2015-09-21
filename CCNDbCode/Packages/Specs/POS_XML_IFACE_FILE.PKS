create or replace PACKAGE  POS_XML_IFACE_FILE AS 

/*********************************************************** 
This package will hold all procedures/functions used to process 
POS_XML_DATA into Local table and PSO_XML_FILE generation

created : 09/21/2015 dxv848 CCN project
revisions: 

************************************************************/


PROCEDURE LOAD_POS_XML_IFACE_LOCAL 
/****************************************************************************
LOAD_POS_XML_IFACE_LOCAL
This procedure is used to load the local table POS_XML_IFACE_LOCAL from the table
POS_XML_IFACE
created : 09/01/2015 AXK326 CCN Project....
changed :
*****************************************************************************/
 
;

PROCEDURE CREATE_POS_FILE
/***************************************************************************** 
        CREATE_POS_FILE 

THIS PROCEDURE WILL BUILD THE US  AUTOMOTIVE DAILY STORE DRAFT ISSUES, VOIDS, STOP PAYS, 
AND REMOVE STOP PAYS 

Created : 09/02/2015 AXK326 CCN Project Team....
Modified:
*****************************************************************************/ 
;

END POS_XML_IFACE_FILE;
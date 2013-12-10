CREATE OR REPLACE PACKAGE CCN_DRM_CALL_METHODS
/*********************************************************** 
This package will hold all the method specific calls

created : 01/25/2012 tal CCN project
revisions: 

************************************************************/
IS

PROCEDURE CALL_GET_HIER
/*******************************************************
Procedure to generate request to call webservice method
getHier takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_INACTIVATENODES
/*******************************************************
Procedure to generate request to call webservice method
inactivateNodes takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_INSERTNODE
/*******************************************************
Procedure to generate request to call webservice method
INSERTNODE takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_ADDNODE
/*******************************************************
Procedure to generate request to call webservice method
ADDNODE takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_ANNULNODE
/*******************************************************
Procedure to generate request to call webservice method
ANNULNODE takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_DELETENODES
/*******************************************************
Procedure to generate request to call webservice method
DELETENODES takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_COPYNODE
/*******************************************************
Procedure to generate request to call webservice method
COPYNODE takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_SETHIERTOPNODE
/*******************************************************
Procedure to generate request to call webservice method
SETHIERTOPNODE takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_MOVENODES
/*******************************************************
Procedure to generate request to call webservice method
MOVENODES takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

PROCEDURE CALL_GETNODE
/*******************************************************
Procedure to generate request to call webservice method
GETNODE takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN CCN_DRM_APICALL.PARAMLIST
, O_REQUEST OUT XMLTYPE
);

END CCN_DRM_CALL_METHODS;


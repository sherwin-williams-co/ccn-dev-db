PACKAGE CCN_DRM_APICALL
/*********************************************************** 
This package will hold 
revisions: 

************************************************************/
IS

TYPE ParamList IS VARRAY(50) OF VARCHAR2(200);


HEADERFRAGMENT 	VARCHAR2(2000) :=  
                  '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
                  ||'<soap:Header>'
                  ||'    <wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" soap:mustUnderstand="1">'
                  ||'      <wsse:UsernameToken>'
                  ||'        <wsse:Username>epm_admin</wsse:Username>'
                  ||'        <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">hyper10n</wsse:Password>'
                  ||'      </wsse:UsernameToken>'
                  ||'    </wsse:Security>'
                  ||    '<AppParameters xmlns="http://drm.webservices.epm.oracle"><serverUrl xmlns="http://drm.webservices.epm.oracle">http://cphdrmdv.sw.sherwin.com:5240/Oracle/Drm/APIAdapter</serverUrl><sessionParams xmlns="http://drm.webservices.epm.oracle">ProductVersion=11.1.2,CultureName=en-US,TimeZoneOffset=-360</sessionParams></AppParameters>'
                  ||'  </soap:Header>'
                  ||'  <soap:Body xmlns:ns1="http://drm.webservices.epm.oracle">';
                  
CLOSEFRAGMENT VARCHAR2(200) := '  </soap:Body>'
                  ||'</soap:Envelope>';   
                  
HEADERREQ VARCHAR2(200) := '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
                  || '<soap:Body xmlns:ns1="http://drm.webservices.epm.oracle">';                  
CLOSERREQ VARCHAR2(200):='</soap:Body></soap:Envelope>';


PROCEDURE MAIN_CALL
/*******************************************************
Procedure is the main call where the rest of the
procedures are called, input is the method name and
parameters


Author : 

versions : init 07/20/2012 
*******************************************************/
( I_METHOD  	IN VARCHAR2
 ,I_PARAM_VAL   IN ParamList
, O_RESP 	OUT XMLTYPE
);


PROCEDURE READ_WSDL_PARAMS
/*******************************************************
Procedure reads the DRM WSDL and generates the parameter
list in the form of an XML


Author : 

versions : init 07/20/2012 
*******************************************************/
( I_METHOD  IN VARCHAR2
, O_PARAMS OUT XMLTYPE
);

PROCEDURE GENERATE_REQUEST_STRING
/*******************************************************
Procedure to generate request to call webservice 
inactivateNodes takes input as the array string for 
values

Author : 

versions : init 07/20/2012 
*******************************************************/
( I_PARAM_VAL  IN ParamList
, I_PARAM_LIST IN XMLTYPE
, O_REQUEST OUT VARCHAR2
);

PROCEDURE CALL_WEB_SERVICE
/*******************************************************
Procedure to call webservice for CCN project only.

Author : Keith D. Parker

versions : init 01/18/2012 kdp
*******************************************************/
(i_payload IN VARCHAR2
, o_response OUT VARCHAR2
, i_soapAction IN VARCHAR2
);

END CCN_DRM_APICALL;
/


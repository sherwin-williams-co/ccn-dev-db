CREATE OR REPLACE PACKAGE CONCENTRATION_TRANSFER_PKG
AS
/**********************************************************
  This Package is intended to be the wrapper for all banking
  related packages that are invoked from UI

created : 06/05/2015 nxk927/jxc517 CCN Project....
changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE LEAD_BANK_FROM_SP 
/*******************************************************************************
    This procedure is intended to select records from Lead bank table including the 
    members from the member bank table that we will be tranferred from.  

Created : 06/05/2015 nxk927/jxc517 CCN Project....
Changed : 
*******************************************************************************/
(IN_COST_CENTER_CODE IN     VARCHAR2
,OUT_REF_CUR   OUT  REF_CURSOR
,OUT_REF_CUR1   OUT  REF_CURSOR
);

PROCEDURE LEAD_BANK_TO_SP 
/*******************************************************************************
    This procedure is intended to select records from Lead bank table and the
    member bank table that we will tranfer the records to.

Created : 06/05/2015 nxk927/jxc517 CCN Project....
Changed : 
*******************************************************************************/
(IN_COST_CENTER_CODE IN     VARCHAR2
,OUT_REF_CUR   OUT  REF_CURSOR);


PROCEDURE MAKE_LEAD_PROCESS
/*******************************************************************************
    This procedure is the shortcut proc to make the member bank as the lead 
    and transfer all the other member to the new lead.

Created : 06/09/2015 nxk927/jxc517 CCN Project....
Changed : 
*******************************************************************************/
(IN_NEW_LEAD_CC IN     VARCHAR2
,IN_USER_ID      IN     VARCHAR2
,IN_EFFECTIVE_DATE IN     DATE);

PROCEDURE LEAD_TRANSFER_PROCESS(
/***********************************************************
	this procedure will be called from ui to transfer particular cost center
    from one lead to another
        
EXAMPLE INPUT:
<?XML VERSION="1.0" ENCODING="UTF-8"?>
<MEMBER_TRANSFER_UI>
    <USER_ID>XXXXXX</USER_ID>
    <FROM_LEAD_CC>701234</FROM_LEAD_CC>
    <TO_LEAD_CC>705678</TO_LEAD_CC>
    <MEMBER_STORES>
      <MEMBER>701451</MEMBER>
      <MEMBER>702000</MEMBER>
    </MEMBER_STORES>
</MEMBER_TRANSFER_UI>

CREATED : 06/08/2015 nxk927/jxc517
UPDATE  : 
************************************************************/
IN_XML           CLOB);

END CONCENTRATION_TRANSFER_PKG;


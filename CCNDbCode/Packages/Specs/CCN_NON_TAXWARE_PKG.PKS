create or replace PACKAGE CCN_NON_TAXWARE_PKG
AS
TYPE REF_CURSOR IS REF CURSOR;
PROCEDURE NON_TAXWARE_CURR_CONV_UI_SP (
/*******************************************************************************
This procedure is intended to return a ref cursor with data from
from the CURRENCY_CONVERSION, NON_TAXWARE_RATES, NON_TAXWARE_RATES_USA, with
Country code as input

created : 11/01/2017 axt754 CCN Project....
*******************************************************************************/
    IN_COUNTRY_CODE                   IN     CURRENCY_CONVERSION.COUNTRY_CODE%TYPE,
    IN_STATE_CODE                     IN     NON_TAXWARE_RATES_USA.STATE_CODE%TYPE,
    OUT_CURR_CONV_REF_CUR                OUT REF_CURSOR,
    OUT_NON_TW_RATES_REF_CUR             OUT REF_CURSOR
    );

PROCEDURE NON_TW_CURR_CONV_CC_UI_SP(
/*******************************************************************************
This procedure is intended to return a ref cursor with data from
from the CURRENCY_CONVERSION, NON_TAXWARE_RATES, NON_TAXWARE_RATES_USA, with
cost center code as input

created : 11/01/2017 axt754 CCN Project....
*******************************************************************************/
    IN_COST_CENTER                   IN      COST_CENTER.COST_CENTER_CODE%TYPE,
    OUT_CURR_CONV_REF_CUR                OUT REF_CURSOR,
    OUT_NON_TW_RATES_REF_CUR             OUT REF_CURSOR);

PROCEDURE NON_TAXWARE_UI_UPSERT_SP(
/******************************************************************************
This procedure is intended to INSERT/UPDATE the CURRENCY_CONVERSION TABLE and 
INSERT/UPDATE THE NON_TAXWARE_RATES, For a given country code
    
--XML Input
<NON_TAXWARE_UI>
   <USER_ID>axt754</USER_ID>
   <COUNTRY_CODE>ABW</COUNTRY_CODE>
   <CURRENCY_CONVERSION_TBL>
      <CURRENCY_CONVERSION>
         <EFFECTIVE_DATE>04-01-2014</EFFECTIVE_DATE>
         <EXPIRATION_DATE></EXPIRATION_DATE>
         <CONVERSION_RATE>1.79</CONVERSION_RATE>
         <DISPLAY_VAT_FLAG>yes</DISPLAY_VAT_FLAG>
         <CURRENCY_TYPE>AWG</CURRENCY_TYPE>
         <TAXID_NUMBER>5034215</TAXID_NUMBER>
         <TAXID_DESCRIPTION>TAX ID #</TAXID_DESCRIPTION>
         <VAT_TAX_ID></VAT_TAX_ID>
      </CURRENCY_CONVERSION>
   </CURRENCY_CONVERSION_TBL>
   <NON_TAXWARE_RATES_TBL>
      <NON_TAXWARE_RATES>
         <STATEMENT_TYPE>AW</STATEMENT_TYPE>
         <TAX_TYPE>VAT</TAX_TYPE>
         <TAX_CODE>70001</TAX_CODE>
         <TAX_RATE>1.5</TAX_RATE>
         <TAX_RATE_DESCRIPTION>1.500%</TAX_RATE_DESCRIPTION>
         <REGISTRATION_NUMBER></REGISTRATION_NUMBER>
         <EFFECTIVE_DATE>12-01-2015</EFFECTIVE_DATE>
         <EXPIRATION_DATE></EXPIRATION_DATE>
      </NON_TAXWARE_RATES>
      <NON_TAXWARE_RATES>
         <STATEMENT_TYPE>AA</STATEMENT_TYPE>
         <TAX_TYPE>SALES TAX</TAX_TYPE>
         <TAX_CODE>10001</TAX_CODE>
         <TAX_RATE>1.5</TAX_RATE>
         <TAX_RATE_DESCRIPTION>1.500%</TAX_RATE_DESCRIPTION>
         <REGISTRATION_NUMBER></REGISTRATION_NUMBER>
         <EFFECTIVE_DATE>12-01-2015</EFFECTIVE_DATE>
         <EXPIRATION_DATE></EXPIRATION_DATE>
      </NON_TAXWARE_RATES>
   </NON_TAXWARE_RATES_TBL>
   <NON_TAXWARE_RATES_USA_TBL>
      <NON_TAXWARE_RATES_USA>
         <STATE_CODE>HI</STATE_CODE>
         <STATEMENT_TYPE>AW</STATEMENT_TYPE>
         <TAX_TYPE>VAT</TAX_TYPE>
         <TAX_CODE>70001</TAX_CODE>
         <TAX_RATE>1.5</TAX_RATE>
         <TAX_RATE_DESCRIPTION>1.500%</TAX_RATE_DESCRIPTION>
         <REGISTRATION_NUMBER></REGISTRATION_NUMBER>
         <EFFECTIVE_DATE>12-01-2015</EFFECTIVE_DATE>
         <EXPIRATION_DATE></EXPIRATION_DATE>
      </NON_TAXWARE_RATES_USA>
      <NON_TAXWARE_RATES_USA>
         <STATE_CODE>OH</STATE_CODE>
         <STATEMENT_TYPE>AW</STATEMENT_TYPE>
         <TAX_TYPE>VAT</TAX_TYPE>
         <TAX_CODE>70001</TAX_CODE>
         <TAX_RATE>1.6</TAX_RATE>
         <TAX_RATE_DESCRIPTION>1.600%</TAX_RATE_DESCRIPTION>
         <REGISTRATION_NUMBER></REGISTRATION_NUMBER>
         <EFFECTIVE_DATE>12-01-2015</EFFECTIVE_DATE>
         <EXPIRATION_DATE></EXPIRATION_DATE>
      </NON_TAXWARE_RATES_USA>
   </NON_TAXWARE_RATES_USA_TBL>
</NON_TAXWARE_UI>
'
created : 11/01/2017 axt754 CCN Project....
*******************************************************************************/
--
    IN_ROW_DATA  IN  CLOB);

END CCN_NON_TAXWARE_PKG;
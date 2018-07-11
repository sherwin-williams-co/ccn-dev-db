create or replace PACKAGE CCN_CLEANSING_ADDRESS_PKG AS 

PROCEDURE CCN_CLEANSING_ADDRESS
/*******************************************************************************
This procedure is intended to create/update a standardized record in addres_usa and address_can tables.
If there is no record with address_type 'S' in address table for the record in addres_geo table, it will
create a new record in address table with the mailing address effective date.

If there is already record present in address table with address type 'S' and there is a change in address,
it will update the standardized address in ccn address table.

If there is any update to the mailing address, it will expire the existing standardized address record 
and create a new record with address type 'S'

Created :  07/06/2018 pxa852 Address Object....
Changed :
*******************************************************************************/
;

FUNCTION GET_USA_CLEANSING_FLAG_FNC ( 
/**********************************************************
This function will return 'Y' OR NULL
parameters: Address row

created : 07/10/2018 pxa852 CCN Project Team
**********************************************************/
IN_ADDRESS_USA_ROW   IN    ADDRESS_USA%ROWTYPE
)
RETURN varchar2;

FUNCTION GET_CAN_CLEANSING_FLAG_FNC ( 
/**********************************************************
This function will return 'Y' OR NULL
parameters: Address row

created : 07/10/2018 pxa852 CCN Project Team
**********************************************************/
IN_ADDRESS_CAN_ROW   IN    ADDRESS_CAN%ROWTYPE
)
RETURN varchar2;

END CCN_CLEANSING_ADDRESS_PKG;
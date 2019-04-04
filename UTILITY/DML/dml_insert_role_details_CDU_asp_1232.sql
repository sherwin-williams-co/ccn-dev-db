/*##############################################################################################################
This script creates a new role 'CSDU' and assign to Customer Deposits users 
Created : 03/22/2019 sxg151 CCN Project Team...
        : ASP-1232 Role Code for customer deposit
        : Grant access to Marissa Papas(map497),Jason E klodnick(jek74s)

--#############################################################################################################	
*/

Insert into ROLE_DETAILS values ('CSDU','Cust Deposit User','Y','Y','Y','Y',
'<USER_RULES>
    <CUSTOMER_DEPOSIT_WINDOW/>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
    <CUSTOMER_DEPOSIT_WINDOW>        
                <VALUE>ALL_FIELDS</VALUE>
    </CUSTOMER_DEPOSIT_WINDOW>
</USER_RULES_DESCRIPTION>');

select * from ROLE_DETAILS where role_code = 'CSDU';

select * from security_matrix where user_id in ('jek74s','map497');


Insert into SECURITY_MATRIX values ('jek74s','jek74s','CSDU');
Insert into SECURITY_MATRIX values ('map497','map497','CSDU');

select * from security_matrix where user_id in ('jek74s','map497');

COMMIT;
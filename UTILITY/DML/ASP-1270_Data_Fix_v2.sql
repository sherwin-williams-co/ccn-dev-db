/*******************************************************************************
ASP-1270: Deleting roles based on work already done through ASP-1268 where we granted
the super user role to these 2 users and therefore removing CCNUS1 role which is a lower
role and should not have been granted by version 1 of this script.
*******************************************************************************/
SELECT * 
  FROM security_matrix
 WHERE user_id IN ('pmm4br','lxb8vr','axh707','san760')
order by 1;

delete from security_matrix where user_id IN ('san760','axh707') and role_code ='CCNUS1';

COMMIT;

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('pmm4br','lxb8vr','axh707','san760')
order by 1;
   

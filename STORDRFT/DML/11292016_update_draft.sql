--Below scripts will manually update the Paid date, paid indicator, stop pay date and stop indicator as per email sent by Christopher T. Greve
--nxk927 11/29/2016

select * from STORE_DRAFTS where COST_CENTER_CODE = '701282' and CHECK_SERIAL_NUMBER = '0128246956';--DRAFT_NUMBER like '%4695%';

UPDATE STORE_DRAFTS
  SET PAID_DATE = NULL,
      PAY_INDICATOR = 'N',
      STOP_PAY_DATE = TRUNC(SYSDATE),
      STOP_INDICATOR = 'Y'
WHERE COST_CENTER_CODE = '701282'
  AND CHECK_SERIAL_NUMBER = '0128246956';
  
select * from STORE_DRAFTS where COST_CENTER_CODE = '701282' and CHECK_SERIAL_NUMBER = '0128246956';--DRAFT_NUMBER like '%4695%'; 
 
select * from STORE_DRAFTS where COST_CENTER_CODE = '703281' and CHECK_SERIAL_NUMBER = '0328154802';--DRAFT_NUMBER like '%5480%';

UPDATE STORE_DRAFTS
  SET PAID_DATE = NULL,
      PAY_INDICATOR = 'N',
      STOP_PAY_DATE = TRUNC(SYSDATE),
      STOP_INDICATOR = 'Y'
WHERE COST_CENTER_CODE = '703281'
  AND CHECK_SERIAL_NUMBER = '0328154802';
  
select * from STORE_DRAFTS where COST_CENTER_CODE = '703281' and CHECK_SERIAL_NUMBER = '0328154802';--DRAFT_NUMBER like '%5480%';

COMMIT;
/*##############################################################################################################
Created : 03/26/2019 dxp896 CCN Project Team..
          This script creates a new role and assign to
          William D. Hinkel (wdh255) and William N. Heideman (wnh478)

--#############################################################################################################*/

select * from security_matrix where user_id in ('wdh255','wnh478');

insert into SECURITY_MATRIX values ('wdh255','wdh255','CCNUS1');
insert into SECURITY_MATRIX values ('wdh255','wdh255','CCNUS2');
insert into SECURITY_MATRIX values ('wdh255','wdh255','HWUAGS');
insert into SECURITY_MATRIX values ('wnh478','wnh478','CCNUS1');
insert into SECURITY_MATRIX values ('wnh478','wnh478','CCNUS2');
insert into SECURITY_MATRIX values ('wnh478','wnh478','HWUAGS');

COMMIT;

select * from security_matrix where user_id in ('wdh255','wnh478');
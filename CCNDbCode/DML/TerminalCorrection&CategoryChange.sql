-- sxt410 05/01/2015
-- Terminal changes for Cost Center 705256...13536 terminal needs to be active...
select * from terminal where cost_center_code = '705256'  and polling_status_code = 'I'  and terminal_number  = '13536'  and effective_date = '14-MAR-1996';

UPDATE terminal
   SET expiration_date  = NULL
 WHERE cost_center_code = '705256'
   AND polling_status_code = 'I'
   AND terminal_number  = '13536'
   AND effective_date = '14-MAR-1996';



-- Delete record from Audit_log table for below Cost Center.
select * from audit_log where transaction_id in ('|76D132|', '|76D131|', '|76D133|') and table_name = 'ADMINISTRATION' order by transaction_id;

DELETE FROM audit_log
 WHERE transaction_id IN ('|76D132|', '|76D131|', '|76D133|')
   AND table_name = 'ADMINISTRATION';

-- Delete below Cost Center from other table before updating Category.
select * from administration where cost_center_code in ('76D132', '76D131', '76D133');

DELETE FROM administration
 WHERE cost_center_code IN ( '76D132', '76D131', '76D133');


-- Category changes from Admin(A) to Store(S) Change 76D132/76D131/76D133
select * from cost_center where cost_center_code in ('76D132', '76D131', '76D133');

UPDATE cost_center
   SET category = 'S'
 WHERE cost_center_code IN ('76D132', '76D131', '76D133');
COMMIT;
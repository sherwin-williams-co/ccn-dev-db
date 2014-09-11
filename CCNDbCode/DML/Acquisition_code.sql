/* Script to update acquisition code from 'CN' to 'CG' for below cost_center_codes */

UPDATE cost_center
SET    acquisition_code = 'GC'
WHERE  cost_center_code IN ( '82U632', '768851', '768904', '768930', '76C825' );
COMMIT;
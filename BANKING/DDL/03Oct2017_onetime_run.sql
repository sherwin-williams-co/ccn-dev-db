/*
created :  nxk927 10/05/2017
           This script was run in production pnp schema for the performance issues we had
*/
CREATE INDEX CCN_SALES_LINES_IX ON PNP.CCN_SALES_LINES(SALESNBR, RLS_RUN_CYCLE);
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'PNP', tabname=>'CCN_SALES_LINES', cascade=>true, estimate_percent=>null, method_opt=>'FOR ALL COLUMNS SIZE 1');
EXEC DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'PNP');
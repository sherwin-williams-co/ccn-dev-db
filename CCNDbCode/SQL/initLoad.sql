/*************************************************************************
                         INITLOAD

  Load the CCN database from data downloaded from the Legacy IDMS CCN
  database.

  initLoad.sql code to run to get summaries

  Created:  mdh 2011
  Revised:  kdp 11/17/2011
            mdh 11/15/2012
************************************************************************/
set serveroutput on;
set timing on;
set heading off;
set verify off;

declare

BEGIN

      common_tools.ALTER_ALL_TRIGGERS ( 'DISABLE' );
      dbms_output.put_line('CCN Table Triggers have been DISABLED');

      initload.DELETE_CCN_TABLES();
      commit;
      dbms_output.put_line('CCN Tables Deleted');

      initLoad.LOAD_COST_CENTER_TABLE();
      dbms_output.put_line('Loaded COST_CENTER TABLE');

      initLoad.LOAD_STORE_TABLE();
      dbms_output.put_line('Loaded STORE TABLE');

      initLoad.LOAD_ADMINISTRATION_TABLE();
      dbms_output.put_line('Loaded ADMINISTRATION TABLE');

      initLoad.LOAD_REAL_ESTATE_TABLE();
      dbms_output.put_line('Loaded REAL_ESTATE Table');

      initLoad.LOAD_OTHER_TABLE();
      dbms_output.put_line('Loaded OTHER Table');

      initLoad.LOAD_PHONE_TABLE();
      dbms_output.put_line('Loaded PHONE Table');

      initLoad.LOAD_STATUS_TABLE();
      dbms_output.put_line('Loaded STATUS Table');

      initLoad.LOAD_TYPE_TABLE();
      dbms_output.put_line('Loaded TYPE Table');

      initLoad.LOAD_ADDRESS_USA_TABLE();
      dbms_output.put_line('Loaded ADDRESS_USA Table');

      initLoad.LOAD_ADDRESS_CAN_TABLE();
      dbms_output.put_line('Loaded ADDRESS_CA Table');

      initLoad.LOAD_ADDRESS_MEX_TABLE();
      dbms_output.put_line('Loaded ADDRESS_MEX Table');

      initLoad.LOAD_ADDRESS_OTH_TABLE();
      dbms_output.put_line('Loaded ADDRESS_OTHER Table');

      initLoad.LOAD_MARKETING_TABLE();
      dbms_output.put_line('Loaded MARKETING Table');

      initLoad.LOAD_SALES_MANAGER_TABLE();
      commit;
      dbms_output.put_line('Loaded SALES_MANAGER Table');

      initLoad.LOAD_TERRITORY_TABLE();
      commit;
      dbms_output.put_line('Loaded TERRITORY Table');

      initLoad.LOAD_SALES_REP_TABLE();
      commit;
      dbms_output.put_line('Loaded SALES_REP Table');

      initLoad.LOAD_TERRITORY_ASSIGN_TABLE();
      commit;
      dbms_output.put_line('Loaded TERRITORY ASSIGNMENT Table');

      initLoad.UPDT_TERRITORY_TABLE();
      dbms_output.put_line('Updates TERRITORY Table');

       commit;
      initLoad.LOAD_POLLING_TABLE();
      dbms_output.put_line('Loaded POLLING Table');

      initLoad.LOAD_BANK_CARD_TABLE();
      dbms_output.put_line('Loaded BANK_CARD Table');

      initLoad.LOAD_TERMINAL_TABLE();
      dbms_output.put_line('Loaded TERMINAL Table');

      initLoad.LOAD_TAXWARE_TABLE();
      dbms_output.put_line('Loaded TAXWARE Table');

      initLoad.LOAD_POLLING_DWLD_RSN_TABLE();
      dbms_output.put_line('Loaded POLLING_DWLD_RSN Table');

      common_tools.ALTER_ALL_TRIGGERS ( 'ENABLE' );
      dbms_output.put_line('CCN Table Triggers have been ENABLED' );
	
exception
		when others then 
			dbms_output.put_line('CCN init errors unknown error ' || sqlerrm );
end;
/

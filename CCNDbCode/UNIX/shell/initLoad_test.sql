--initLoad.sql code to run to get summaries
--mdh 11/07/2012
set serveroutput on;
set timing on;
set heading off;
set verify off;

declare

begin

      common_tools.ALTER_ALL_TRIGGERS ('DISABLE');
      dbms_output.put_line('CCN Tables Deleted');
      dbms_output.put_line('Loaded COST_CENTER TABLE');
      dbms_output.put_line('Loaded STORE TABLE');
      dbms_output.put_line('Loaded ADMINISTRATION TABLE');
      dbms_output.put_line('Loaded REAL_ESTATE Table');
      dbms_output.put_line('Loaded OTHER Table');
      dbms_output.put_line('Loaded PHONE Table');
      dbms_output.put_line('Loaded STATUS Table');
      dbms_output.put_line('Loaded TYPE Table');
      dbms_output.put_line('Loaded ADDRESS_USA Table');
      dbms_output.put_line('Loaded ADDRESS_CA Table');
      dbms_output.put_line('Loaded ADDRESS_MEX Table');
      dbms_output.put_line('Loaded ADDRESS_OTHER Table');
      dbms_output.put_line('Loaded MARKETING Table');
      dbms_output.put_line('Loaded SALES_MANAGER Table');
      dbms_output.put_line('Loaded TERRITORY Table');
      dbms_output.put_line('Loaded SALES_REP Table');
      dbms_output.put_line('Loaded TERRITORY ASSIGNMENT Table');
      dbms_output.put_line('Updates TERRITORY Table');
      dbms_output.put_line('Loaded POLLING Table');
      dbms_output.put_line('Loaded BANK_CARD Table');
      dbms_output.put_line('Loaded TERMINAL Table');
      common_tools.ALTER_ALL_TRIGGERS('ENABLE');
end;
/

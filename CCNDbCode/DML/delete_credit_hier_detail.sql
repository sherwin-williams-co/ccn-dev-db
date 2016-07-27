begin
  
  for cur in (select fk.owner, fk.constraint_name , fk.table_name 
    from all_constraints fk, all_constraints pk 
     where fk.CONSTRAINT_TYPE = 'R' and 
           pk.owner = 'COSTCNTR' and
           fk.r_owner = pk.owner and
           fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME and 
           pk.TABLE_NAME = 'HIERARCHY_HEADER') loop
    execute immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  end loop;
  
  delete from hierarchy_detail where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';
  delete from hierarchy_description where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';
  delete FROM hierarchy_header where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';

for cur in (select fk.owner, fk.constraint_name , fk.table_name 
   from all_constraints fk, all_constraints pk 
    where fk.CONSTRAINT_TYPE = 'R' and 
          pk.owner = 'COSTCNTR' and
          fk.r_owner = pk.owner and
          fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME and 
          pk.TABLE_NAME = 'HIERARCHY_HEADER') loop
    execute immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end loop;  
end;
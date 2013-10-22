PROCEDURE PROC_IEX(ip IN varchar2) is
pragma autonomous_transaction;
begin
insert into test_iex values(ip);
commit;
end;
/


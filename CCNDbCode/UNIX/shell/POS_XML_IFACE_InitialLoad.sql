/*
insert POS_XML_IFACE data into POS_XML_IFACE_LOCAL table
*/
declare

cursor POS_CUR is
    SELECT GUID  ,               
           QUEUE_NAME ,                      
           BROKER_NAME  ,                       
           MESSAGE_ID,                            
           PUT_TIME   ,           
           XML_DOCUMENT ,                 
           SHRED_TS        ,      
           CREATED_TS  ,
           STATUS 
      FROM POS_XML_IFACE PF,
           XMLTABLE('/CCN/header/tranId'
	                PASSING PF.XML_DOCUMENT
                  COLUMNS VALUE VARCHAR2(20) PATH 'text()')X
     WHERE X.VALUE = '13'
       AND TRUNC(PF.CREATED_TS) < TRUNC(SYSDATE)-1;    

v_count     integer := 0;
v_Tcount    integer := 0;

 
BEGIN

    FOR POS_REC in POS_CUR LOOP
        BEGIN
            insert into POS_XML_IFACE_LOCAL values POS_REC;
            if v_count > 100 then
                commit;
                v_count := 0;
            end if;

            v_count  := v_count + 1;
            v_Tcount := v_Tcount + 1;
        
		EXCEPTION
            WHEN others THEN
                DBMS_OUTPUT.PUT_LINE('error read message GUID ' || POS_REC.GUID ||' error '|| SUBSTR(SQLERRM,1,500));
        END;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || v_Tcount);
    DBMS_OUTPUT.PUT_LINE('0');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
end;
/



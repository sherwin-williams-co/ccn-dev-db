-- created by rxv940 on 12/15/2017
-- Run this in Utils schema
-- Cleanup of POS_ID for OS_DOWNLOADS_GL_PS

SET SERVEROUTPUT ON 
BEGIN 
    FOR J IN (SELECT POS_ID 
                FROM POS_DOWNLOADS_GL_PS
               ORDER BY CREATE_DT 
              ) LOOP

        UPDATE POS_DOWNLOADS_GL_PS
           SET POS_ID = SEQ_TST.NEXTVAL
         WHERE POS_ID = J.POS_ID;  

    END LOOP;
    COMMIT;
END;       


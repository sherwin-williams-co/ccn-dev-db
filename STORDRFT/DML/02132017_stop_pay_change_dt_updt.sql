/*
created : 02/10/2017 nxk927
          updating the change date to sent the stop pay indicator to suntrust to make sure the checks won't be cashed.
          '0292613080','0350020012','0709719165','0771415858','0526961818','0808427041','0301637245' drafts were already marked as paid
           This drafts will have separate update scripts just incase we don't have to run it.

            SELECT *
              FROM STORE_DRAFTS SD
             WHERE CHECK_SERIAL_NUMBER  in ('0710116039','0243020138','0747511178','0752210880','0264010216','0527514020','0539911545','0755911021','0853857597',
                                             '0711816645','0347610131','0704634112','0430114546','0263719395','0278848155','0319020756','0803827468','0700013774',
                                             '0228614939','0321914038','0106915879','0152510285','0177619095','0139053391','0735527483','0325112258','0332510023',
                                             '0434237921','0756213138','0226348035','0532764412','0399310192','0354917239','0168011252','0235013547','0292710076',
                                             '0750812067','0122366636','0108312844','0310315221','0124012766','0176615987','0129913000','0737736744','0202514162',
                                             '0212217509','0738515220','0569713258','0225375799','0507220663','0742131519','0858210156','0769724444','0225184225',
                                             '0139642078','0139642060','0303013361','0216532705','0217314467','0195316922','0278848437','0735714784','0759710031',
                                             '0399510049','0721817872','0820097954','0866320021','0704634195','0504817214','0207815192','0325463057','0759710023',
                                             '0827511452','0721422079','0160710182','0342010170','0758856199','0755513512','0845527449','0253610752','0431923234',
                                             '0265210310','0350918207','0113960066','0192515724','0263721243','0382625556','0752710806','0820011120','0757012489',
                                             '0859614331','0729918870','0216726182','0323315036','0738516111','0716614425','0297012437','0737739235','0325112274',
                                             '0532312006','0828610501','0242222024','0292613098','0262010259','0356210104','0721032548','0709018147','0521720235',
                                             '0720339092','0732643374','0316517515','0118515774','0753210798','0189619372','0709318794','0317142701','0169014727',
                                             '0358027571','0227017027','0853858462','0132276353','0125217356','0228236253','0243551603','0717496038','0245669585',
                                             '0717496061','0128243797','0706015997','0729815068','0770115277','0329912000','0290910058','0790010045','0817393002',
                                             '0189619406','0746014513','0119913945','0590711065','0825611908','0318911930','0320516198','0124936212','0198610248',
                                             '0169113735','0366521573','0121438055','0145049847','0145049862','0186410015','0740314901','0525410296','0345910350',
                                             '0180918500','0136614385','0239121437','0500027479','0859614554','0264912007','0755421245','0218413631','0526498282',
                                             '0100117084','0346810088','0346810096','0254312432','0221920861','0745817205','0718718679','0125612572','0176618379',
                                             '0538811126','0724828546','0507220705','0527274724','0535915763','0739419307','0244111167','0274010529','0251430286',
                                             '0189155872','0756213161','0866320799','0130116007','0503023582','0307513663','0532812823','0722918117','0178710026',
                                             '0737742098','0223024126','0196827398','0229615703','0820014009','0176618940','0168011336','0122619588','0122369622',
                                             '0176618023','0218537389','0859614844','0544210107','0864518659','0176618775','0176618817','0216116665','0216116673',
                                             '0757012679','0220262398','0544210123','0190811315','0249113226','0354610149','0291210722','0430515718','0358810000',
                                             '0101718120','0868510124','0211269279','0439017047','0198711491','0179517610','0223692211','0226359586','0859615023',
                                             '0863811048','0172217366','0190118653','0127734655','0822516001','0738112911','0198220444','0857810311','0722626330',
                                             '0176619336','0211268891','0430011007','0528380801','0717497309','0737741900','0820014652','0895910123','0740731625',
                                             '0226359578','0526499926','0526499793','0223246802','0118914340','0717496665','0542238282','0320516214','0859615080',
                                             '0859614927','0126063163','0176619195','0211418579','0170610067','0255232332','0211268917','0256111063','0526392410',
                                             '0523969509','0755422508','0867714099')
               AND CHECK_SERIAL_NUMBER NOT IN (SELECT CHECK_SERIAL_NUMBER
                                                 FROM SD_BANK_FILE_SENT_DETAILS
                                                WHERE SEND_INDICATOR        = 'Y'
                                                  AND PROCESS_DATE          >=  NVL(SD.STOP_PAY_DATE, PROCESS_DATE))

           212 ROWS SELECTED

           SELECT *
              FROM STORE_DRAFTS SD
             WHERE CHECK_SERIAL_NUMBER  in ('0292613080','0350020012','0709719165','0771415858','0526961818','0808427041','0301637245')  
               AND CHECK_SERIAL_NUMBER NOT IN (SELECT CHECK_SERIAL_NUMBER
                                                 FROM SD_BANK_FILE_SENT_DETAILS
                                                WHERE SEND_INDICATOR        = 'Y'
                                                  AND PROCESS_DATE          >=  NVL(SD.STOP_PAY_DATE, PROCESS_DATE))
           7 ROWS SELECTED
*/


DECLARE
BEGIN
FOR REC IN (SELECT *
              FROM STORE_DRAFTS SD
             WHERE CHECK_SERIAL_NUMBER  in ('0710116039','0243020138','0747511178','0752210880','0264010216','0527514020','0539911545','0755911021','0853857597',
                                             '0711816645','0347610131','0704634112','0430114546','0263719395','0278848155','0319020756','0803827468','0700013774',
                                             '0228614939','0321914038','0106915879','0152510285','0177619095','0139053391','0735527483','0325112258','0332510023',
                                             '0434237921','0756213138','0226348035','0532764412','0399310192','0354917239','0168011252','0235013547','0292710076',
                                             '0750812067','0122366636','0108312844','0310315221','0124012766','0176615987','0129913000','0737736744','0202514162',
                                             '0212217509','0738515220','0569713258','0225375799','0507220663','0742131519','0858210156','0769724444','0225184225',
                                             '0139642078','0139642060','0303013361','0216532705','0217314467','0195316922','0278848437','0735714784','0759710031',
                                             '0399510049','0721817872','0820097954','0866320021','0704634195','0504817214','0207815192','0325463057','0759710023',
                                             '0827511452','0721422079','0160710182','0342010170','0758856199','0755513512','0845527449','0253610752','0431923234',
                                             '0265210310','0350918207','0113960066','0192515724','0263721243','0382625556','0752710806','0820011120','0757012489',
                                             '0859614331','0729918870','0216726182','0323315036','0738516111','0716614425','0297012437','0737739235','0325112274',
                                             '0532312006','0828610501','0242222024','0292613098','0262010259','0356210104','0721032548','0709018147','0521720235',
                                             '0720339092','0732643374','0316517515','0118515774','0753210798','0189619372','0709318794','0317142701','0169014727',
                                             '0358027571','0227017027','0853858462','0132276353','0125217356','0228236253','0243551603','0717496038','0245669585',
                                             '0717496061','0128243797','0706015997','0729815068','0770115277','0329912000','0290910058','0790010045','0817393002',
                                             '0189619406','0746014513','0119913945','0590711065','0825611908','0318911930','0320516198','0124936212','0198610248',
                                             '0169113735','0366521573','0121438055','0145049847','0145049862','0186410015','0740314901','0525410296','0345910350',
                                             '0180918500','0136614385','0239121437','0500027479','0859614554','0264912007','0755421245','0218413631','0526498282',
                                             '0100117084','0346810088','0346810096','0254312432','0221920861','0745817205','0718718679','0125612572','0176618379',
                                             '0538811126','0724828546','0507220705','0527274724','0535915763','0739419307','0244111167','0274010529','0251430286',
                                             '0189155872','0756213161','0866320799','0130116007','0503023582','0307513663','0532812823','0722918117','0178710026',
                                             '0737742098','0223024126','0196827398','0229615703','0820014009','0176618940','0168011336','0122619588','0122369622',
                                             '0176618023','0218537389','0859614844','0544210107','0864518659','0176618775','0176618817','0216116665','0216116673',
                                             '0757012679','0220262398','0544210123','0190811315','0249113226','0354610149','0291210722','0430515718','0358810000',
                                             '0101718120','0868510124','0211269279','0439017047','0198711491','0179517610','0223692211','0226359586','0859615023',
                                             '0863811048','0172217366','0190118653','0127734655','0822516001','0738112911','0198220444','0857810311','0722626330',
                                             '0176619336','0211268891','0430011007','0528380801','0717497309','0737741900','0820014652','0895910123','0740731625',
                                             '0226359578','0526499926','0526499793','0223246802','0118914340','0717496665','0542238282','0320516214','0859615080',
                                             '0859614927','0126063163','0176619195','0211418579','0170610067','0255232332','0211268917','0256111063','0526392410',
                                             '0523969509','0755422508','0867714099')
               AND CHECK_SERIAL_NUMBER NOT IN (SELECT CHECK_SERIAL_NUMBER
                                                 FROM SD_BANK_FILE_SENT_DETAILS
                                                WHERE SEND_INDICATOR        = 'Y'
                                                  AND PROCESS_DATE          >=  NVL(SD.STOP_PAY_DATE, PROCESS_DATE))) LOOP


    UPDATE STORE_DRAFTS SD
       SET CHANGE_DATE                = TRUNC(SYSDATE)
     WHERE CHECK_SERIAL_NUMBER        = REC.CHECK_SERIAL_NUMBER;

    INSERT INTO SD_BANK_FILE_SENT_DETAILS VALUES (REC.COST_CENTER_CODE, REC.CHECK_SERIAL_NUMBER, TRUNC(SYSDATE), 'Y');
END LOOP;
END;
/
--COMMIT AFTER VALIDATING THE DATA
COMMIT;

/


--BELOW DRAFTS ARE ALREADY MARKED AS PAID (5 DRAFTS WERE SENT OUT BY CHRIS FOR THEM TO BE MARKED AS PAID)
--WAITING FOR THE CONFIRMATION FROM CHRIS.
DECLARE
BEGIN
FOR REC IN (SELECT *
              FROM STORE_DRAFTS SD
             WHERE CHECK_SERIAL_NUMBER  in ('0292613080','0350020012','0709719165','0771415858','0526961818','0808427041','0301637245')  
               AND CHECK_SERIAL_NUMBER NOT IN (SELECT CHECK_SERIAL_NUMBER
                                                 FROM SD_BANK_FILE_SENT_DETAILS
                                                WHERE SEND_INDICATOR        = 'Y'
                                                  AND PROCESS_DATE          >=  NVL(SD.STOP_PAY_DATE, PROCESS_DATE))) LOOP

    UPDATE STORE_DRAFTS SD
       SET CHANGE_DATE                = TRUNC(SYSDATE),
           STOP_PAY_DATE              = TRUNC(SYSDATE),
           STOP_INDICATOR             = 'Y',
           STOP_PAY_MARKED_BY_CCN_IND = 'Y',
           OPEN_INDICATOR             = 'N',
           PAY_INDICATOR              = 'N'
     WHERE CHECK_SERIAL_NUMBER        = REC.CHECK_SERIAL_NUMBER;

     INSERT INTO SD_BANK_FILE_SENT_DETAILS VALUES (REC.COST_CENTER_CODE, REC.CHECK_SERIAL_NUMBER, TRUNC(SYSDATE), 'Y');

END LOOP;
END;
/
--COMMIT AFTER VALIDATING THE DATA
COMMIT;
/
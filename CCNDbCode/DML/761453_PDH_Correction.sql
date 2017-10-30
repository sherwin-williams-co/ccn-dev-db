/*
Below script will correct the data for Pricing district hierarchy issue

Created : 10/25/2017 jxc517 CCN Project Team....
*/

/*
HRCHY_HDR_NAME      HR HRCHY_DTL_PREV_LVL_VAL    HRCHY_DTL_CURR_LVL_VAL   HRCHY_DTL_NEXT_LVL_VAL   HRCHY_DTL_EFF_DATE   HRCHY_DTL_EXP_DATE   HRCHY_DTL_DESC         HRCHY_DTL_CURR_ROW_VAL   UPPER_LVL_VER_VALUE  
------------------- -- ------------------------- ------------------------ ------------------------ -------------------- -------------------- ---------------------- ------------------------ ---------------------
PRICE_DISTRICT      2  81301                     81301761453              ~~~                      16-JUN-2017 00:00:00 23-OCT-2017 00:00:00 TROIS-RIVIERES-EAST    761453                   

HRCHY_HDR_NAME      HR HRCHY_DTL_PREV_LVL_VAL    HRCHY_DTL_CURR_LVL_VAL   HRCHY_DTL_NEXT_LVL_VAL   HRCHY_DTL_EFF_DATE   HRCHY_DTL_EXP_DATE   HRCHY_DTL_DESC         HRCHY_DTL_CURR_ROW_VAL   UPPER_LVL_VER_VALUE  
------------------- -- ------------------------- ------------------------ ------------------------ -------------------- -------------------- ---------------------- ------------------------ ---------------------
PRICE_DISTRICT      2  81301                     81301761453              ~~~                      24-OCT-2017 00:00:00                      TROIS-RIVIERES-EAST    761453                   
PRICE_DISTRICT      2  81301                     81301761453              ~~~                      21-OCT-2017 00:00:00                      TROIS-RIVIERES-EAST    761453                   

<HRCHY_DTL_LEVEL>02</HRCHY_DTL_LEVEL><HRCHY_DTL_PREV_LVL_VAL>81301</HRCHY_DTL_PREV_LVL_VAL><HRCHY_DTL_CURR_LVL_VAL>81301761453</HRCHY_DTL_CURR_LVL_VAL><HRCHY_DTL_NEXT_LVL_VAL>~~~        </HRCHY_DTL_NEXT_LVL_VAL><HRCHY_DTL_EFF_DATE>20170616</HRCHY_DTL_EFF_DATE><HRCHY_DTL_EXP_DATE>20171020</HRCHY_DTL_EXP_DATE><HRCHY_DTL_CURR_ROW_VAL>761453</HRCHY_DTL_CURR_ROW_VAL><HRCHY_DTL_DESC>TROIS-RIVIERES-EAST</HRCHY_DTL_DESC></HIERARCHY_DETAIL>
<HRCHY_DTL_LEVEL>02</HRCHY_DTL_LEVEL><HRCHY_DTL_PREV_LVL_VAL>81301</HRCHY_DTL_PREV_LVL_VAL><HRCHY_DTL_CURR_LVL_VAL>81301761453</HRCHY_DTL_CURR_LVL_VAL><HRCHY_DTL_NEXT_LVL_VAL>~~~        </HRCHY_DTL_NEXT_LVL_VAL><HRCHY_DTL_EFF_DATE>20170616</HRCHY_DTL_EFF_DATE><HRCHY_DTL_EXP_DATE>20171020</HRCHY_DTL_EXP_DATE><HRCHY_DTL_CURR_ROW_VAL>761453</HRCHY_DTL_CURR_ROW_VAL><HRCHY_DTL_DESC>TROIS-RIVIERES-EAST</HRCHY_DTL_DESC></HIERARCHY_DETAIL>
<HRCHY_DTL_LEVEL>02</HRCHY_DTL_LEVEL><HRCHY_DTL_PREV_LVL_VAL>81301</HRCHY_DTL_PREV_LVL_VAL><HRCHY_DTL_CURR_LVL_VAL>81301761453</HRCHY_DTL_CURR_LVL_VAL><HRCHY_DTL_NEXT_LVL_VAL>~~~        </HRCHY_DTL_NEXT_LVL_VAL><HRCHY_DTL_EFF_DATE>20170616</HRCHY_DTL_EFF_DATE><HRCHY_DTL_EXP_DATE>20171023</HRCHY_DTL_EXP_DATE><HRCHY_DTL_CURR_ROW_VAL>761453</HRCHY_DTL_CURR_ROW_VAL><HRCHY_DTL_DESC>TROIS-RIVIERES-EAST</HRCHY_DTL_DESC></HIERARCHY_DETAIL>
*/

SELECT * FROM HIERARCHY_DETAIL_FUTURE WHERE HRCHY_DTL_CURR_LVL_VAL = '81301761453' AND HRCHY_HDR_NAME = 'PRICE_DISTRICT';
--2 Row(s) Selected

DELETE FROM HIERARCHY_DETAIL_FUTURE WHERE HRCHY_DTL_CURR_LVL_VAL = '81301761453' AND HRCHY_HDR_NAME = 'PRICE_DISTRICT';
--2 Row(s) Deleted

SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_DTL_CURR_LVL_VAL = '81301761453' AND HRCHY_HDR_NAME = 'PRICE_DISTRICT';
--1 Row(s) Selected

UPDATE HIERARCHY_DETAIL SET HRCHY_DTL_EXP_DATE = NULL WHERE HRCHY_DTL_CURR_LVL_VAL = '81301761453' AND HRCHY_HDR_NAME = 'PRICE_DISTRICT';
--1 Row(s) Selected

COMMIT;
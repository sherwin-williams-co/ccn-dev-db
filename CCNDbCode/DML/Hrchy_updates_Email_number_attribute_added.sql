/*
     Created: 05/08/2017 axt754 CCN Project Team..
     This script do the updates  UPPER_LVL_VER_VALUE field in 
     HIERARCHY_DETAIL, 
     HIERARCHY_DETAIL_HST and 
     HIERARCHY_DETAIL_FUTURE 
     tables to associate the values provided in the excel with the new attribute "Email_Number",
     for CREDIT_HIERARCHY and District - 4th level
*/
-- MANUAL BACKUP OF DATA BEFORE STARTING UPDATES
SELECT *
  FROM HIERARCHY_DETAIL
 WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY'
   AND HRCHY_DTL_LEVEL = 4

SELECT *
  FROM HIERARCHY_DETAIL_HST
 WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY'
   AND HRCHY_DTL_LEVEL = 4

SELECT *
  FROM HIERARCHY_DETAIL_FUTURE
 WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY'
   AND HRCHY_DTL_LEVEL = 4

-- BEGIN UPDATES 
SET SERVEROUTPUT ON;
BEGIN
for rec in (Select '00020' as DCO, '035' as email_number from dual union
Select '00022' as DCO, '035' as email_number from dual union
Select '00023' as DCO, '015' as email_number from dual union
Select '00079' as DCO, '025' as email_number from dual union
Select '00080' as DCO, '016' as email_number from dual union
Select '00081' as DCO, '016' as email_number from dual union
Select '00082' as DCO, '011' as email_number from dual union
Select '00083' as DCO, '015' as email_number from dual union
Select '00084' as DCO, '030' as email_number from dual union
Select '00085' as DCO, '020' as email_number from dual union
Select '00086' as DCO, '015' as email_number from dual union
Select '00087' as DCO, '030' as email_number from dual union
Select '00088' as DCO, '015' as email_number from dual union
Select '00089' as DCO, '027' as email_number from dual union
Select '00092' as DCO, '012' as email_number from dual union
Select '00093' as DCO, '021' as email_number from dual union
Select '00109' as DCO, '019' as email_number from dual union
Select '00110' as DCO, '021' as email_number from dual union
Select '00112' as DCO, '030' as email_number from dual union
Select '00113' as DCO, '016' as email_number from dual union
Select '00117' as DCO, '030' as email_number from dual union
Select '00118' as DCO, '015' as email_number from dual union
Select '00119' as DCO, '022' as email_number from dual union
Select '00120' as DCO, '023' as email_number from dual union
Select '00121' as DCO, '022' as email_number from dual union
Select '00123' as DCO, '028' as email_number from dual union
Select '00124' as DCO, '022' as email_number from dual union
Select '00125' as DCO, '028' as email_number from dual union
Select '00126' as DCO, '027' as email_number from dual union
Select '00127' as DCO, '023' as email_number from dual union
Select '00128' as DCO, '008' as email_number from dual union
Select '00129' as DCO, '028' as email_number from dual union
Select '00130' as DCO, '023' as email_number from dual union
Select '00131' as DCO, '035' as email_number from dual union
Select '00132' as DCO, '035' as email_number from dual union
Select '00133' as DCO, '023' as email_number from dual union
Select '00135' as DCO, '022' as email_number from dual union
Select '00136' as DCO, '028' as email_number from dual union
Select '00137' as DCO, '006' as email_number from dual union
Select '00139' as DCO, '009' as email_number from dual union
Select '00141' as DCO, '028' as email_number from dual union
Select '00142' as DCO, '003' as email_number from dual union
Select '00143' as DCO, '009' as email_number from dual union
Select '00144' as DCO, '010' as email_number from dual union
Select '00145' as DCO, '030' as email_number from dual union
Select '00146' as DCO, '002' as email_number from dual union
Select '00147' as DCO, '030' as email_number from dual union
Select '00148' as DCO, '030' as email_number from dual union
Select '00150' as DCO, '001' as email_number from dual union
Select '00151' as DCO, '007' as email_number from dual union
Select '00152' as DCO, '029' as email_number from dual union
Select '00153' as DCO, '003' as email_number from dual union
Select '00154' as DCO, '005' as email_number from dual union
Select '00155' as DCO, '030' as email_number from dual union
Select '00156' as DCO, '004' as email_number from dual union
Select '00159' as DCO, '030' as email_number from dual union
Select '00160' as DCO, '024' as email_number from dual union
Select '00161' as DCO, '030' as email_number from dual union
Select '00162' as DCO, '014' as email_number from dual union
Select '00163' as DCO, '011' as email_number from dual union
Select '00164' as DCO, '014' as email_number from dual union
Select '00165' as DCO, '013' as email_number from dual union
Select '00166' as DCO, '017' as email_number from dual union
Select '00168' as DCO, '013' as email_number from dual union
Select '00169' as DCO, '011' as email_number from dual union
Select '00170' as DCO, '018' as email_number from dual union
Select '00171' as DCO, '011' as email_number from dual union
Select '00172' as DCO, '030' as email_number from dual union
Select '00173' as DCO, '012' as email_number from dual union
Select '00175' as DCO, '019' as email_number from dual union
Select '00176' as DCO, '011' as email_number from dual union
Select '00177' as DCO, '016' as email_number from dual union
Select '00179' as DCO, '019' as email_number from dual union
Select '00180' as DCO, '021' as email_number from dual union
Select '00181' as DCO, '030' as email_number from dual union
Select '00182' as DCO, '016' as email_number from dual union
Select '00183' as DCO, '016' as email_number from dual union
Select '00184' as DCO, '019' as email_number from dual union
Select '00185' as DCO, '019' as email_number from dual union
Select '00186' as DCO, '030' as email_number from dual union
Select '00187' as DCO, '014' as email_number from dual union
Select '00188' as DCO, '019' as email_number from dual union
Select '00189' as DCO, '021' as email_number from dual union
Select '00362' as DCO, '030' as email_number from dual union
Select '00452' as DCO, '030' as email_number from dual union
Select '00453' as DCO, '030' as email_number from dual union
Select '00454' as DCO, '030' as email_number from dual union
Select '00455' as DCO, '030' as email_number from dual union
Select '00557' as DCO, '030' as email_number from dual union
Select '00558' as DCO, '026' as email_number from dual union
Select '00688' as DCO, '019' as email_number from dual union
Select '00690' as DCO, '024' as email_number from dual union
Select '00799' as DCO, '030' as email_number from dual union
Select '00850' as DCO, '032' as email_number from dual union
Select '00858' as DCO, '024' as email_number from dual union
Select '00860' as DCO, '024' as email_number from dual union
Select '00868' as DCO, '024' as email_number from dual union
Select '00869' as DCO, '032' as email_number from dual union
Select '00870' as DCO, '024' as email_number from dual union
Select '00878' as DCO, '024' as email_number from dual union
Select '00879' as DCO, '024' as email_number from dual union
Select '00880' as DCO, '024' as email_number from dual union
Select '00889' as DCO, '024' as email_number from dual union
Select '00890' as DCO, '024' as email_number from dual union
Select '00898' as DCO, '024' as email_number from dual union
Select '00954' as DCO, '026' as email_number from dual union
Select '00975' as DCO, '033' as email_number from dual union
Select '00976' as DCO, '030' as email_number from dual union
Select '01212' as DCO, '025' as email_number from dual union
Select '09680' as DCO, '030' as email_number from dual) LOOP

    dbms_output.put_line('Begin Update for DCO: '||rec.dco);

    UPDATE HIERARCHY_DETAIL
       SET UPPER_LVL_VER_VALUE = XMLTYPE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE, '/attributes'),
                                                 '</attributes>', 
                                                 '<upper_lvl_ver_desc><Name>EMAIL_NUMBER</Name><Value>'||rec.email_number||'</Value></upper_lvl_ver_desc>'||'</attributes>'))
     WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY'
       AND HRCHY_DTL_LEVEL = 4
       AND SUBSTR(CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE, 'DCO'), 2) = rec.dco;

    dbms_output.put_line('Number of Records updated in HIERARCHY_DETAIL table are: '||SQL%ROWCOUNT);

    UPDATE HIERARCHY_DETAIL_HST
       SET UPPER_LVL_VER_VALUE = XMLTYPE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE, '/attributes'),
                                                 '</attributes>', 
                                                 '<upper_lvl_ver_desc><Name>EMAIL_NUMBER</Name><Value>'||rec.email_number||'</Value></upper_lvl_ver_desc>'||'</attributes>'))
     WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY'
       AND HRCHY_DTL_LEVEL = 4
       AND SUBSTR(CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE, 'DCO'), 2) = rec.dco;

    dbms_output.put_line('Number of Records updated in HIERARCHY_DETAIL_HST table are: '||SQL%ROWCOUNT);

    UPDATE HIERARCHY_DETAIL_FUTURE
       SET UPPER_LVL_VER_VALUE = XMLTYPE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE, '/attributes'),
                                                 '</attributes>', 
                                                 '<upper_lvl_ver_desc><Name>EMAIL_NUMBER</Name><Value>'||rec.email_number||'</Value></upper_lvl_ver_desc>'||'</attributes>'))
     WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY'
       AND HRCHY_DTL_LEVEL = 4
       AND SUBSTR(CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE, 'DCO'), 2) = rec.dco;

    dbms_output.put_line('Number of Records updated in HIERARCHY_DETAIL_FUTURE table are: '||SQL%ROWCOUNT);


END LOOP;
-- Commit the complete transaction
COMMIT;
END;
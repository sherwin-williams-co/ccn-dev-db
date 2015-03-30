BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
    COMMON_TOOLS.ALTER_ALL_TRIGGERS ('DISABLE');
END;
/

SET DEFINE OFF;  
Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'7',
'010103020355',
'01010302035501',
'0101030203550101',
'19-MAR-2014',
NULL,
NULL,
'01',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted

Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'6',
'0101030203',
'010103020355',
'01010302035501',
'19-MAR-2014',
NULL,
NULL,
'55',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted

Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'5',
'01010302',
'0101030203',
'010103020355',
'19-MAR-2014',
NULL,
NULL,
'03',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted

Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'5',
'01010302',
'0101030278',
'010103027855',
'19-MAR-2014',
NULL,
NULL,
'78',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted



Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'4',
'010103',
'01010306',
'0101030600',
'19-MAR-2014',
NULL,
NULL,
'06',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted



Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'4',
'010109',
'01010900',
'0101090017',
'19-MAR-2014',
NULL,
NULL,
'00',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted

Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'3',
'0101',
'010109',
'01010900',
'19-MAR-2014',
NULL,
NULL,
'09',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted

Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'6',
'0101030278',
'010103027855',
'01010302785501',
'19-MAR-2014',
NULL,
NULL,
'55',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted


Insert into HIERARCHY_DETAIL
values
('GLOBAL_HIERARCHY',
'7',
'010103027855',
'01010302785501',
'0101030278550101',
'19-MAR-2014',
NULL,
NULL,
'01',
'<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted

COMMIT;

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
    COMMON_TOOLS.ALTER_ALL_TRIGGERS ('ENABLE');
END;
/
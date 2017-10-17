--Changed : 10/17/2017 rxv940 
--        : Added a Hot fix for Prod issues on 10/17/2017

ALTER TABLE POS_DOWNLOADS MODIFY POLLING_REQUEST_ID VARCHAR2(4000);

DECLARE
V_POS_DOWNLOADS CCN_UTILITY.POS_DOWNLOADS%ROWTYPE;
V_ERROR         VARCHAR2(1000);
BEGIN
V_POS_DOWNLOADS := POS_DATA_GENERATION.RETURN_POS_DOWNLOADS(NULL,'TerritoryUpdate_201710171036853418000.XML');
V_POS_DOWNLOADS.POLLING_REQUEST_ID:='573660f4-16bd-4eb3-a2e9-59ba67c650a0';
V_POS_DOWNLOADS.COMMENTS:=V_POS_DOWNLOADS.COMMENTS||CHR(10)||'. Polling response is : '||'573660f4-16bd-4eb3-a2e9-59ba67c650a0 Polling information sent to stores :[1010, 1243, 1107, 1280, 1360, 1454, 1562, 1785, 1807, 1909, 1910, 1035, 1036, 1058, 1060, 1096, 1159, 1171, 1176, 1186, 1187, 1232, 1238, 1244, 1283, 1284, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1037, 1038, 1039, 1040, 1041, 1042, 1044, 1045, 1046, 1050, 1051, 1053, 1054, 1055, 1056, 1057, 1059, 1061]';
V_POS_DOWNLOADS.UPDATE_DT:=SYSDATE;
POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP(V_POS_DOWNLOADS);
COMMIT;
END;
/

DECLARE
V_POS_DOWNLOADS CCN_UTILITY.POS_DOWNLOADS%ROWTYPE;
V_ERROR         VARCHAR2(1000);
BEGIN
V_POS_DOWNLOADS := POS_DATA_GENERATION.RETURN_POS_DOWNLOADS(NULL,'TerritoryUpdate_201710171012293356000.XML');
V_POS_DOWNLOADS.POLLING_REQUEST_ID:='b5f2cb36-0cc6-403b-88ec-2a647acdc4e4';
V_POS_DOWNLOADS.COMMENTS:=V_POS_DOWNLOADS.COMMENTS||CHR(10)||'. Polling response is : '||'b5f2cb36-0cc6-403b-88ec-2a647acdc4e4 Polling information sent to stores :[1010, 1243, 1107, 1280, 1360, 1454, 1562, 1785, 1807, 1909, 1910, 1035, 1036, 1058, 1060, 1096, 1159, 1171, 1176, 1186, 1187, 1232, 1238, 1244, 1283, 1284, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1037, 1038, 1039, 1040, 1041, 1042, 1044, 1045, 1046, 1050, 1051, 1053, 1054, 1055, 1056, 1057, 1059, 1061]';
V_POS_DOWNLOADS.UPDATE_DT:=SYSDATE;
POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP(V_POS_DOWNLOADS);
COMMIT;
END;
/

DECLARE
V_POS_DOWNLOADS CCN_UTILITY.POS_DOWNLOADS%ROWTYPE;
V_ERROR         VARCHAR2(1000);
BEGIN
V_POS_DOWNLOADS := POS_DATA_GENERATION.RETURN_POS_DOWNLOADS(NULL,'StoreUpdate_201710171036788101000.XML');
V_POS_DOWNLOADS.POLLING_REQUEST_ID:='b5f2cb36-0cc6-403b-88ec-2a647acdc4e4';
V_POS_DOWNLOADS.COMMENTS:=V_POS_DOWNLOADS.COMMENTS||CHR(10)||'. Polling response is : '||'0c39c3b7-d5b5-447b-81f8-6b6517565f1c Polling information sent to stores :[1010, 1243, 1107, 1280, 1360, 1454, 1562, 1785, 1807, 1909, 1910, 1035, 1036, 1058, 1060, 1096, 1159, 1171, 1176, 1186, 1187, 1232, 1238, 1244, 1283, 1284, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1037, 1038, 1039, 1040, 1041, 1042, 1044, 1045, 1046, 1050, 1051, 1053, 1054, 1055, 1056, 1057, 1059, 1061]';
V_POS_DOWNLOADS.UPDATE_DT:=SYSDATE;
POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP(V_POS_DOWNLOADS);
COMMIT;
END;
/

DECLARE
V_POS_DOWNLOADS CCN_UTILITY.POS_DOWNLOADS%ROWTYPE;
V_ERROR         VARCHAR2(1000);
BEGIN
V_POS_DOWNLOADS := POS_DATA_GENERATION.RETURN_POS_DOWNLOADS(NULL,'StoreUpdate_201710171012442888000.XML');
V_POS_DOWNLOADS.POLLING_REQUEST_ID:='743fc36a-6278-4c33-ade6-1acf5862242a';
V_POS_DOWNLOADS.COMMENTS:=V_POS_DOWNLOADS.COMMENTS||CHR(10)||'. Polling response is : '||'743fc36a-6278-4c33-ade6-1acf5862242a Polling information sent to stores :[1010, 1243, 1107, 1280, 1360, 1454, 1562, 1785, 1807, 1909, 1910, 1035, 1036, 1058, 1060, 1096, 1159, 1171, 1176, 1186, 1187, 1232, 1238, 1244, 1283, 1284, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1037, 1038, 1039, 1040, 1041, 1042, 1044, 1045, 1046, 1050, 1051, 1053, 1054, 1055, 1056, 1057, 1059, 1061]';
V_POS_DOWNLOADS.UPDATE_DT:=SYSDATE;
POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP(V_POS_DOWNLOADS);
COMMIT;
END;
/
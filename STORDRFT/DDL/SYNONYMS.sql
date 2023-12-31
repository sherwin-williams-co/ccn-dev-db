CREATE OR REPLACE SYNONYM COST_CENTER FOR COSTCNTR.COST_CENTER;
CREATE OR REPLACE SYNONYM CCN_COMMON_TOOLS FOR CCN_UTILITY.CCN_COMMON_TOOLS;

CREATE OR REPLACE SYNONYM BATCH_JOB FOR CCN_UTILITY.BATCH_JOB;
CREATE OR REPLACE SYNONYM CCN_BATCH_PKG FOR CCN_UTILITY.CCN_BATCH_PKG;
CREATE OR REPLACE SYNONYM MAIL_PKG FOR CCN_UTILITY.MAIL_PKG;

CREATE OR REPLACE SYNONYM EMPLOYEE_DETAILS FOR COSTCNTR.EMPLOYEE_DETAILS;
CREATE OR REPLACE SYNONYM PHONE_NBR FOR COSTCNTR.CCN_PHONE_INFO_VW;
CREATE OR REPLACE SYNONYM HIERARCHY_DETAIL FOR COSTCNTR.HIERARCHY_DETAIL;
CREATE OR REPLACE SYNONYM HIERARCHY_DETAIL_VIEW FOR COSTCNTR.HIERARCHY_DETAIL_VIEW;

/*
--below script should be executed in store draft user
CREATE OR REPLACE SYNONYM SD_UI_INTERFACE_APP_PKG FOR STORDRFT.SD_UI_INTERFACE_APP_PKG;
CREATE OR REPLACE SYNONYM SD_UI_REPORTS_PKG FOR STORDRFT.SD_UI_REPORTS_PKG;
CREATE OR REPLACE SYNONYM SD_PICK_LIST_PKG FOR STORDRFT.SD_PICK_LIST_PKG;
*/

/* These SYNONYM belongs to STOREDRFT_JV_VW View */
CREATE OR REPLACE SYNONYM SHW_DSERV_CP2D11E_DBLU.STOREDRFT_JV_VW FOR STOREDRFT_JV_VW;
CREATE OR REPLACE SYNONYM STDRFTUSR.STOREDRFT_JV_VW FOR STOREDRFT_JV_VW;

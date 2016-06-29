/*******************************************************************************
  The table is used to hold the tracking information of ticket orders
  CREATED : 06/21/2016 MXK766 CCN PROJECT....
  CHANGED : 
*******************************************************************************/
CREATE TABLE TEMP_TICKORD_TRACKING_T
(
ORDER_ID              VARCHAR2(100),
ORDER_TRACKING_NUMBER VARCHAR2(100),
EXTERNAL_ORDER_ID_GUI VARCHAR2(100),
CREATE_DT             DATE NOT NULL
);
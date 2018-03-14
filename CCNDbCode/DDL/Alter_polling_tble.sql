/*
Created: 03/14/2018 nxk927 
         this will alter the polling and polling_hst table to add polling start date and stop date
*/

ALTER TABLE POLLING
  ADD (POLLING_START_DATE DATE,
      POLLING_STOP_DATE DATE);

ALTER TABLE POLLING_HST
  ADD (POLLING_START_DATE DATE,
       POLLING_STOP_DATE DATE);
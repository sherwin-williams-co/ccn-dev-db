/*
Below script will remove terminal 20310 from 702937 and add it to 701387

Email Request from "Adam C. Jenkins/Sherwin-Williams":
On the 21st, we assigned a couple terminals to stores. Store 1387 was assigned 20310 as their 2nd terminal, however it did not appear to be saved.
Stores POS team assigned that number as well and now that store (1387) has sales for that terminal.

On that same day, new store 2937 was assigned a terminal, and was assigned the same one since the previous wasn't saved.
Is it at all possible to remove terminal 20310 from store 2937 and assign it to store 1387?

We also need to send email, as terminal/PCI mistmatch

Created : 10/24/2016 jxc517 CCN Project Team....
          
*/
SELECT * FROM TERMINAL WHERE COST_CENTER_CODE = '702937' AND TERMINAL_NUMBER = '20310';
--1 Row(s) Selected
DELETE FROM TERMINAL WHERE COST_CENTER_CODE = '702937' AND TERMINAL_NUMBER = '20310';
--1 Row(s) Deleted

--PCI_TERMINAL_ID, PCI_VALUE_LINK_MID, PCI_VAL_LINK_ALT_MID
INSERT INTO TERMINAL VALUES ('701387', 'P', '20310', '21-OCT-2016', NULL, NULL, NULL, NULL, NULL, NULL);
--1 Row(s) Inserted

COMMIT;

BEGIN
CCN_BUSINESS_RULES_PKG.PCI_TERMINAL_COUNT_CHECK('701387',
                           '<POLLING_UI>
                            <TERMINAL_TABLE>
                            <TERMINAL>
                            <TERMINAL_NUMBER>16795</TERMINAL_NUMBER>
                            <PCI_TERMINAL_ID>07941703</PCI_TERMINAL_ID>
                            </TERMINAL>
                            <TERMINAL>
                            <TERMINAL_NUMBER>20310</TERMINAL_NUMBER>
                            <PCI_TERMINAL_ID></PCI_TERMINAL_ID>
                            </TERMINAL>
                            </TERMINAL_TABLE>
                            </POLLING_UI>');
END;
/

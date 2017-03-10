/*
Below script will remove ' LOGO' from the CODE_DETAIL_DESCRIPTION

Email Request from Ellen:
--
Pat,
  If you could remove the word LOGO then this field would work for company name.

Thank you,
Ellen Rampton
The Sherwin Williams Company
101 Prospect Ave, Cleveland, OH  44115
216-515-4020

-----Pat M. Malloy/Sherwin-Williams wrote: -----
To: Ellen J. Rampton/Sherwin-Williams@SWCBD
From: Pat M. Malloy/Sherwin-Williams
Date: 03/03/2017 04:39PM
Cc: Dan M. Jacobson/Sherwin-Williams@SWCBD, Keith D. Parker/Sherwin-Williams@SWCBD, Lisette Torres/CLE/Sherwin-Williams@SWCBD
Subject: Re: Fw: Re: STORE DATAMAP

We could probably remove LOGO from the description.  It is redundant.  Let me know what you think.

Patricia M. Malloy
PSG SMIS Operations
216-566-2287

Created : 03/10/2017 rxv940 CCN Project Team....
          
*/

/*

CREATE TABLE CODE_DETAIL_BKP AS 
SELECT * FROM CODE_DETAIL
WHERE CODE_HEADER_NAME = 'PRI_LOGO_GROUP_IND';

*/

UPDATE CODE_DETAIL
SET CODE_DETAIL_DESCRIPTION = REPLACE(CODE_DETAIL_DESCRIPTION, ' LOGO', '')
WHERE CODE_HEADER_NAME = 'PRI_LOGO_GROUP_IND';

COMMIT;
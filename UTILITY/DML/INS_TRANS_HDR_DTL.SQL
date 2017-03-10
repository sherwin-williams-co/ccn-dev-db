/*

Created:	rxv940 CCN Project Team....

This is to populate the TRANSLATION_HEADER and TRANSLATION_DETAIL tables with values provided by Ellen. See below mail for more details,

To: Keith D. Parker/Sherwin-Williams@SWCBD
From: Ellen J. Rampton/Sherwin-Williams
Date: 03/06/2017 09:34AM
Cc: Lisette Torres/CLE/Sherwin-Williams@SWCBD, Jaydeep Cheruku/Sherwin-Williams@SWCBD, Vigneshkumar Rajagopal/NA/Sherwin-Williams@SWCBD, Pat M. Malloy/Sherwin-Williams@SWCBD, Dan M. Jacobson/Sherwin-Williams@SWCBD
Subject: Re: Fw: Re: STORE DATAMAP

Keith,
   Now that Pat removed the word LOGO the description field will work for co-nm field.

  The only issue we have left with the store datamap is web address, do you think you can add a place for this in the new CCN?


CN)      (www.sherwin-williams.ca
CO)      (brands.sherwin-williams.com/colorwhee
CP)      (www.columbiapaint.com
DP)      (www.duron.com
FB)      (www.flexbon.com
FP)      (brands.sherwin-williams.com/frazee
GP)      (www.generalpolymers.com
KP)      (brands.sherwin-williams.com/kwal
MB)      (www.mabpaints.com
MZ)      (www.mautzpaint.com
PK)      (brands.sherwin-williams.com/parker
SW)      (www.sherwin-williams.com
 

 Let me know.

Thanks,
Ellen Rampton
The Sherwin Williams Company
101 Prospect Ave, Cleveland, OH  44115
216-515-4020

*/


DECLARE
V_CNT_HDR NUMBER;
V_CNT_DTL NUMBER;
BEGIN

	SELECT COUNT(1) INTO V_CNT_HDR FROM TRANSLATION_HEADER WHERE HEADER_NAME = 'STATEMENT_WEB-ADDR';
	
	IF V_CNT_HDR = 0 THEN 

		INSERT INTO TRANSLATION_HEADER
		(
		  HEADER_NAME
		, HEADER_DESCRIPTION
		, HEADER_EXPIRE_FLAG
		)
		SELECT 
		  'STATEMENT_WEB-ADDR'
		, 'STATEMENT_TYPE to WEB_ADDRESS'
		, 'N'
		FROM DUAL;

	END IF;

	SELECT COUNT(1) INTO V_CNT_DTL FROM TRANSLATION_DETAIL WHERE HEADER_NAME = 'STATEMENT_WEB-ADDR';
	
	IF V_CNT_DTL = 0 THEN 
		
		INSERT INTO TRANSLATION_DETAIL
		(
		  HEADER_NAME
		, DETAIL_VALUE
		, DETAIL_TRANSLATION
		, DETAIL_EXPIRE_FLAG
		, DETAIL_SEQ_NUMBER
		)
		SELECT 'STATEMENT_WEB-ADDR', 'CN', 'www.sherwin-williams.ca', 'N', 1 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'CO', 'brands.sherwin-williams.com/colorwheel', 'N', 2 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'CP', 'www.columbiapaint.com', 'N', 3 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'DP', 'www.duron.com', 'N', 4 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'FB', 'www.flexbon.com', 'N', 5 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'FP', 'brands.sherwin-williams.com/frazee', 'N', 6 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'GP', 'www.generalpolymers.com', 'N', 7 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'KP', 'brands.sherwin-williams.com/kwal', 'N', 8 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'MB', 'www.mabpaints.com', 'N', 9 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'MZ', 'www.mautzpaint.com', 'N', 10 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'PK', 'brands.sherwin-williams.com/parker', 'N', 11 FROM DUAL UNION
		SELECT 'STATEMENT_WEB-ADDR', 'SW', 'www.sherwin-williams.com', 'N', 12  FROM DUAL;

	END IF;

	COMMIT;

EXCEPTION
	WHEN OTHES THEN 
	DBMS_OUTPUT.PUT_LINE(SQLCODE || ' - ' || SQLERRM);
	ROLLBACK;

END;


/*
   script name: DML_BANK_DEP_TICK_BAG_EXCLD_CCS.sql
   Created by : 03/07/2018 axt754 CCN Project Team...
                This Script Inserts data into BANK_DEP_TICK_BAG_EXCLD_CCS table
*/


-- BEGIN UPDATES 
SET DEFINE OFF;
SET SERVEROUTPUT ON;
INSERT INTO BANK_DEP_TICK_BAG_EXCLD_CCS(SELECT '701414'  ,'SHERLINK ONLINE PAYMENTS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('06/09/1998 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '701427'  ,'DUNKIRK'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/21/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '702751'  ,'M/W DIV-P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/08/1996 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '702752'  ,'EAST DIV - P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/01/1996 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '702753'  ,'S/E DIV - P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/08/1996 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '702754'  ,'S/W DIV - P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/08/1996 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '702755'  ,'HIGHWAY DIRECT SLS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('02/25/1998 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '702879'  ,'ST MAARTEN-COLE BAY'  ,'P'  ,'S'  ,'ANT'  ,TO_DATE('07/14/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '708517'  ,'CAMPBELL'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/01/1978 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '761453'  ,'TROIS-RIVIERES-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/14/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '761456'  ,'CHICOUTIMI'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/24/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '761491'  ,'KELOWNA-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/29/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '761833'  ,'SYDNEY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/21/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763493'  ,'CALGARY-SOUTH TRAIL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/26/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763494'  ,'SURREY-NEWTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/04/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763495'  ,'ST CATHARINES-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/04/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763496'  ,'LONDON-NORTH EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763575'  ,'ST JEROME'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763576'  ,'CHARLOTTETOWN-PEI'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/18/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763577'  ,'BARRIE-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/31/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763579'  ,'OKOTOKS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763581'  ,'GEORGETOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/14/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763582'  ,'HAMILTON-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/11/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763583'  ,'WINNIPEG-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763584'  ,'LAVAL-ST DOROTHEE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/28/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763590'  ,'CAMBRIDGE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/24/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763591'  ,'BARRHAVEN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/16/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763592'  ,'GATINEAU-HULL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/05/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763593'  ,'ANCASTER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763594'  ,'PORT COQUITLAM'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/31/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763595'  ,'TORONTO-NORTH YORK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/29/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763596'  ,'CHATEAUGUAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/29/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763597'  ,'AIRDRIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '763598'  ,'BURLINGTON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/30/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768129'  ,'SAINT-JEAN RICHELIEU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/09/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768502'  ,'CHATHAM'  ,'Q'  ,'S'  ,'CAN'  ,TO_DATE('01/01/1900 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768503'  ,'NEPEAN-OTTAWA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768612'  ,'GUELPH-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/07/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768614'  ,'ORILLIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/28/2017 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768681'  ,'COLE HARBOUR-DARTMOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/14/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768702'  ,'MISSISSAUGA-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/19/1991 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768704'  ,'TORONTO CARLAW-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/24/1991 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768705'  ,'WATERLOO'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/19/1991 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768706'  ,'SCARBOROUGH-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/24/1991 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768707'  ,'HAMILTON-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/18/1991 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768708'  ,'LONDON-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/20/1991 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768709'  ,'OTTAWA COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/07/1992 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768712'  ,'MONTREAL VILLE D-ANJOU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/1993 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768713'  ,'MOUNT ROYAL MONTREAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/1993 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768714'  ,'QUEBEC CITY SAINTE-FOY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/02/1993 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768715'  ,'LAVAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/08/1993 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768717'  ,'SURREY-PORT KELLS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/11/1994 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768720'  ,'ST CATHARINES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/09/1995 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768721'  ,'RICHMOND-BRIDGEPORT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/20/1995 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768723'  ,'TORONTO-CALEDONIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/29/1996 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768724'  ,'DARTMOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/30/1996 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768725'  ,'SHERBROOKE-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/24/1997 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768726'  ,'OAKVILLE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/12/1997 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768727'  ,'WINDSOR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/26/1997 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768728'  ,'BROSSARD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/04/1998 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768729'  ,'OSHAWA-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/03/1998 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768732'  ,'OTTAWA-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/19/2000 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768734'  ,'DIEPPE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/06/2000 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768735'  ,'SUDBURY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/08/2001 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768736'  ,'SURREY COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/17/2001 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768738'  ,'CALGARY COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/25/2002 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768740'  ,'BARRIE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/12/2002 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768742'  ,'NIAGARA FALLS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/16/2003 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768743'  ,'HAMILTON-MOUNTAIN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2003 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768744'  ,'HALIFAX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/26/2004 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768745'  ,'MISSISSAUGA-PORT CREDIT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/10/2004 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768746'  ,'BURLINGTON-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/01/2004 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768747'  ,'CALGARY-EAST HILLS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/31/2005 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768748'  ,'AURORA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/22/2005 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768749'  ,'THORNHILL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/16/2005 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768750'  ,'WOODBRIDGE-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/28/2005 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768753'  ,'EDMONTON SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/19/2005 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768754'  ,'KITCHENER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('02/27/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768755'  ,'AJAX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/07/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768756'  ,'PITT MEADOWS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/24/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768759'  ,'ETOBICOKE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/22/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768761'  ,'WHISTLER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/31/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768762'  ,'OAKVILLE-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768763'  ,'TORONTO-LEASIDE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/27/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768764'  ,'HAMILTON-MAIN ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/23/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768765'  ,'VANCOUVER FALSE CREEK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768766'  ,'GUELPH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768767'  ,'VANCOUVER KERRISDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768768'  ,'SURREY CLOVERDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/24/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768769'  ,'PETERBOROUGH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/18/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768770'  ,'BRAMPTON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/02/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768771'  ,'MARKHAM-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/10/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768772'  ,'BRANTFORD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/23/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768773'  ,'MONTREAL ST LEONARD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768774'  ,'REPENTIGNY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/13/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768775'  ,'TROIS-RIVIERES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/29/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768776'  ,'MISSISSAUGA-MEADOWVALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/23/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768777'  ,'NORTH VANCOUVER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/30/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768778'  ,'WINNIPEG-REGENT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768779'  ,'GATINEAU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/22/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768780'  ,'TORONTO-CORKTOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/07/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768781'  ,'ROYAL OAK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768782'  ,'MONTREAL-WEST ISLAND'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768784'  ,'BURNABY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/11/2010 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768785'  ,'OTTAWA-ORLEANS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/16/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768786'  ,'LEVIS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/27/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768790'  ,'MILTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/17/2010 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768791'  ,'BELLEFEUILLE-ST JEROME'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/29/2010 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768792'  ,'VICTORIA-DOWNTOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/23/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768793'  ,'MASCOUCHE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2010 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768794'  ,'BRAMPTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/09/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768795'  ,'SURREY-WHITE ROCK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/22/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768796'  ,'KINGSTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/21/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768797'  ,'ABBOTSFORD-S FRASER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/26/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768804'  ,'OTTAWA-KANATA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/14/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768806'  ,'MISSISSAUGA-ERINDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/25/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768807'  ,'TORONTO-KEELE ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/20/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768808'  ,'WINNIPEG-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/18/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768809'  ,'WHITBY-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/08/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768810'  ,'KITCHENER-WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/21/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768811'  ,'SASKATOON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/11/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768812'  ,'OTTAWA-BANK STREET'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/24/2013 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768813'  ,'TORONTO-SCARBOROUGH EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/27/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768815'  ,'EAST GWILLIMBURY-NEWMARKET'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/09/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768816'  ,'LONDON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/10/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768817'  ,'BURNABY-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768818'  ,'VAUGHAN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/29/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768819'  ,'WATERDOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/21/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768820'  ,'LONGUEUIL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/11/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768821'  ,'SAINTE JULIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/11/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768822'  ,'WINNIPEG-CENTRAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/17/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768823'  ,'LOWER SACKVILLE-HALIFAX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/26/2012 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768824'  ,'COURTICE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/29/2013 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768825'  ,'MISSISSAUGA-DUNDAS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/25/2013 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768826'  ,'TORONTO-ETOBICOKE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/11/2013 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768827'  ,'ST THERESE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/14/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768828'  ,'BELLEVILLE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/11/2013 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768829'  ,'MONCTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/22/2013 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768830'  ,'MONTREAL-ST ANTOINE WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/30/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768831'  ,'BRAMPTON-WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/04/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768832'  ,'TORONTO-WILLOWDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/05/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768835'  ,'QUEBEC CITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768836'  ,'LAVAL-WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/27/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768837'  ,'BROSSARD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/09/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768838'  ,'VILLE ST-LAURENT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/09/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768839'  ,'ST EUSTACHE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/12/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768840'  ,'LASALLE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/16/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768841'  ,'MOUNT PEARL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('02/19/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768843'  ,'ST JOHN''S'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/03/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768844'  ,'VAUDREUIL-DORION'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/24/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768845'  ,'ABBOTSFORD-RIVERSIDE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768846'  ,'VANCOUVER-ARBUTUS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768849'  ,'BRANDON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768850'  ,'BURNABY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768851'  ,'CALGARY COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768852'  ,'CALGARY CENTRAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768853'  ,'CALGARY HUNTERHORN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768854'  ,'CALGARY NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768855'  ,'CALGARY NORTHEAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768856'  ,'CALGARY-RANCHLANDS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768857'  ,'CALGARY-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768858'  ,'CAMBRIDGE BRANCH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768859'  ,'CAMPBELL RIVER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768860'  ,'CHILLIWACK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768861'  ,'COQUITLAM'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768862'  ,'COURTENAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768863'  ,'CRANBROOK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768864'  ,'TORONTO-FRONT ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768865'  ,'DUNCAN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768866'  ,'EDMONTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768867'  ,'EDMONTON NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768868'  ,'EDMONTON-SE COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768869'  ,'EDMONTON SOUTHPOINT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768870'  ,'EDMONTON WESTGATE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768871'  ,'VANCOUVER COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768872'  ,'FLEETWOOD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768873'  ,'FORT MCMURRAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768874'  ,'GOLDSTREAM'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768875'  ,'GRANDE PRAIRIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768876'  ,'HAMILTON-UPPER OTTAWA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768877'  ,'KAMLOOPS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768878'  ,'KELOWNA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768879'  ,'LANGLEY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768880'  ,'LETHBRIDGE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768881'  ,'LLOYDMINSTER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768882'  ,'LONDON-STANELY ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768883'  ,'LONDON SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768884'  ,'MAPLE RIDGE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768886'  ,'MISSISSAUGA-RIDGEWAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768887'  ,'MONTREAL-ST LAURENT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768888'  ,'MOOSE JAW'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768889'  ,'NANAIMO'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768890'  ,'NEW WESTMINSTER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768892'  ,'NORTH VANCOUVER-MARINE DR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768893'  ,'PENTICTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768894'  ,'PICKERING'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768896'  ,'PRINCE ALBERT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768897'  ,'PRINCE GEORGE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768901'  ,'PRINCE RUPERT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768903'  ,'RED DEER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768904'  ,'REGINA COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768905'  ,'REGINA EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768906'  ,'ETOBICOKE-REXDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768907'  ,'RICHMOND HILL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768908'  ,'RICHMOND SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768909'  ,'SARNIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768910'  ,'SASKATOON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768911'  ,'SASKATOON-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768913'  ,'SHERWOOD PARK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768914'  ,'ST ALBERT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768916'  ,'WINNIPEG-ST VITAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768917'  ,'RICHMOND'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768918'  ,'SURREY-CENTRAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768919'  ,'SURREY-DELTA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768920'  ,'THUNDER BAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768921'  ,'VERNON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768922'  ,'VICTORIA COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768923'  ,'VANCOUVER-VICTORIA DR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768924'  ,'VICTORIA-GORDON HEAD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768925'  ,'WATERLOO'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768926'  ,'WEST KELOWNA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768930'  ,'WINNIPEG COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768931'  ,'WINNIPEG EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768935'  ,'HALIFAX-BAYER''S LAKE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/28/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768936'  ,'BRAMPTON-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/28/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768937'  ,'MONTREAL-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768938'  ,'RED DEER-NORTH-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768940'  ,'SAINT JOHN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/30/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768941'  ,'SHERBROOKE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/13/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768942'  ,'TORONTO-DANFORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768943'  ,'MARKHAM-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/12/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768944'  ,'SCARBOROUGH-GOLDEN MILE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/11/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768945'  ,'FREDERICTON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/16/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768946'  ,'L''ANCIENNE-LORETTE-QUEBEC CITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/04/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768947'  ,'WHITBY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/27/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768948'  ,'DOLLARD-DES-ORMEAUX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/09/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '768953'  ,'WINDSOR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/17/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '771493'  ,'MONCTON-PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/03/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '771494'  ,'LONDON-PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/03/2016 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '778703'  ,'BRAMPTON PF'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/26/1991 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '778716'  ,'MONTREAL-NORD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/26/1994 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '778718'  ,'LANGLEY-VANCOUVER FACILITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/22/1994 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '778737'  ,'WINNIPEG-PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/31/2003 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '778739'  ,'CALGARY PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/27/2002 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '778842'  ,'WINNIPEG-PF LARGE EQUIPMENT '  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/29/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779001'  ,'AUTO SCARBOROUGH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779002'  ,'AUTO MISSISSAUGA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779003'  ,'AUTO CALGARY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779004'  ,'AUTO SAINT CATHERINE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779005'  ,'AUTO LANGLEY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779007'  ,'AUTO LONDON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779008'  ,'01/18 AUTO VICTORIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/01/2013 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779009'  ,'AUTO KITCHENER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779010'  ,'AUTO DARTMOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779011'  ,'AUTO EDMONTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779012'  ,'AUTO HAMILTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779015'  ,'AUTO VILLE D''ANJOU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779016'  ,'AUTO REGINA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/19/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779018'  ,'AUTO QUEBEC CITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/22/2015 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779022'  ,'AUTO WINNIPEG'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/23/2009 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779024'  ,'AUTO OTTAWA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/22/2008 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779026'  ,'AUTO BARRIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779029'  ,'AUTO ST HYACINTHE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '779081'  ,'AUTO MONCTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/08/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '791431'  ,'ELKHART FACILITY'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/02/2011 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '792760'  ,'PF FINANCIAL SERVICES POS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('07/07/2004 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '799162'  ,'AUTO CHERRY HILL'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/03/2007 ','MM/DD/YYYY') , 'TICK'  from Dual Union
SELECT '701085'  ,'LIVONIA'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/22/1988 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '701106'  ,'BINGHAMTON'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('10/01/1978 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '701414'  ,'SHERLINK ONLINE PAYMENTS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('06/09/1998 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '701650'  ,'CUYAHOGA FALLS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('07/01/1978 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '701761'  ,'ALMA'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('08/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '701894'  ,'KOKOMO'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702052'  ,'COLUMBUS-MIDTOWN'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('06/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702172'  ,'ORLANDO-SOUTH'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/12/1983 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702331'  ,'MACON-RIVERSIDE'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('06/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702335'  ,'BRADENTON-COMMERCIAL'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('02/12/1999 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702370'  ,'OCALA-MAIN'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702372'  ,'OCALA-COLLEGE PARK'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('09/02/1985 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702435'  ,'WINTERVILLE F/C CTR'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/03/2001 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702472'  ,'ALPHARETTA-WINDWARD'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('09/16/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702594'  ,'SURF CITY'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('10/31/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702751'  ,'M/W DIV-P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/08/1996 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702752'  ,'EAST DIV - P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/01/1996 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702753'  ,'S/E DIV - P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/08/1996 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702754'  ,'S/W DIV - P&L DIRECT SALES'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('04/08/1996 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702755'  ,'HIGHWAY DIRECT SLS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('02/25/1998 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '702879'  ,'ST MAARTEN-COLE BAY'  ,'P'  ,'S'  ,'ANT'  ,TO_DATE('07/14/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '703072'  ,'DICKINSON'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '703144'  ,'ST LOU - ARNOLD'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('03/16/1989 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '703229'  ,'SARTELL'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('08/15/2000 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '703326'  ,'WINSTON SALEM'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('03/31/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '705248'  ,'ROCHESTER F/C CTR'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/28/1995 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '705335'  ,'SYOSSET-OYSTER BAY'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('03/21/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '705400'  ,'MOUNT CRAWFORD-HARRISBURG F/C CTR'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('10/27/2010 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '705490'  ,'EAST HANOVER'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('09/14/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '705797'  ,'HOPEWELL'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('02/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '705931'  ,'WAYNESBORO'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('09/01/1978 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '707091'  ,'INDIANOLA'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('02/01/1979 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '707189'  ,'DENVER-E EVANS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/29/1986 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '707710'  ,'WHARTON'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('08/01/1978 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '707717'  ,'PARIS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('06/01/1978 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '707763'  ,'AMORY'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/11/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '708003'  ,'TUCSON-BROADWAY'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/29/1986 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '708070'  ,'SAN FRANCISCO-4TH ST'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/31/1987 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '708164'  ,'TORRANCE'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/23/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '708226'  ,'LAS VEGAS F/C CTR'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('07/12/1996 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '708517'  ,'CAMPBELL'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/01/1978 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '761453'  ,'TROIS-RIVIERES-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/14/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '761456'  ,'CHICOUTIMI'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/24/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '761491'  ,'KELOWNA-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/29/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '761833'  ,'SYDNEY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/21/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763493'  ,'CALGARY-SOUTH TRAIL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/26/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763494'  ,'SURREY-NEWTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/04/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763495'  ,'ST CATHARINES-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/04/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763496'  ,'LONDON-NORTH EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763575'  ,'ST JEROME'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763576'  ,'CHARLOTTETOWN-PEI'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/18/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763577'  ,'BARRIE-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/31/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763579'  ,'OKOTOKS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763581'  ,'GEORGETOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/14/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763582'  ,'HAMILTON-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/11/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763583'  ,'WINNIPEG-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763584'  ,'LAVAL-ST DOROTHEE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/28/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763590'  ,'CAMBRIDGE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/24/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763591'  ,'BARRHAVEN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/16/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763592'  ,'GATINEAU-HULL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/05/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763593'  ,'ANCASTER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763594'  ,'PORT COQUITLAM'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/31/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763595'  ,'TORONTO-NORTH YORK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/29/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763596'  ,'CHATEAUGUAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/29/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763597'  ,'AIRDRIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '763598'  ,'BURLINGTON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/30/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768129'  ,'SAINT-JEAN RICHELIEU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/09/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768502'  ,'CHATHAM'  ,'Q'  ,'S'  ,'CAN'  ,TO_DATE('01/01/1900 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768503'  ,'NEPEAN-OTTAWA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768612'  ,'GUELPH-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/07/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768614'  ,'ORILLIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/28/2017 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768681'  ,'COLE HARBOUR-DARTMOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/14/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768702'  ,'MISSISSAUGA-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/19/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768704'  ,'TORONTO CARLAW-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/24/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768705'  ,'WATERLOO'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/19/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768706'  ,'SCARBOROUGH-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/24/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768707'  ,'HAMILTON-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/18/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768708'  ,'LONDON-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/20/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768709'  ,'OTTAWA COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/07/1992 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768712'  ,'MONTREAL VILLE D-ANJOU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/1993 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768713'  ,'MOUNT ROYAL MONTREAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/1993 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768714'  ,'QUEBEC CITY SAINTE-FOY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/02/1993 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768715'  ,'LAVAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/08/1993 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768717'  ,'SURREY-PORT KELLS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/11/1994 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768720'  ,'ST CATHARINES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/09/1995 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768721'  ,'RICHMOND-BRIDGEPORT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/20/1995 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768723'  ,'TORONTO-CALEDONIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/29/1996 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768724'  ,'DARTMOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/30/1996 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768725'  ,'SHERBROOKE-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/24/1997 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768726'  ,'OAKVILLE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/12/1997 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768727'  ,'WINDSOR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/26/1997 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768728'  ,'BROSSARD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/04/1998 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768729'  ,'OSHAWA-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/03/1998 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768732'  ,'OTTAWA-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/19/2000 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768734'  ,'DIEPPE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/06/2000 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768735'  ,'SUDBURY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/08/2001 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768736'  ,'SURREY COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/17/2001 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768738'  ,'CALGARY COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/25/2002 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768740'  ,'BARRIE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/12/2002 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768742'  ,'NIAGARA FALLS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/16/2003 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768743'  ,'HAMILTON-MOUNTAIN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2003 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768744'  ,'HALIFAX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/26/2004 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768745'  ,'MISSISSAUGA-PORT CREDIT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/10/2004 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768746'  ,'BURLINGTON-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/01/2004 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768747'  ,'CALGARY-EAST HILLS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/31/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768748'  ,'AURORA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/22/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768749'  ,'THORNHILL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/16/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768750'  ,'WOODBRIDGE-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/28/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768753'  ,'EDMONTON SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/19/2005 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768754'  ,'KITCHENER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('02/27/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768755'  ,'AJAX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/07/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768756'  ,'PITT MEADOWS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/24/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768759'  ,'ETOBICOKE-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/22/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768761'  ,'WHISTLER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/31/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768762'  ,'OAKVILLE-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768763'  ,'TORONTO-LEASIDE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/27/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768764'  ,'HAMILTON-MAIN ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/23/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768765'  ,'VANCOUVER FALSE CREEK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768766'  ,'GUELPH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768767'  ,'VANCOUVER KERRISDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/28/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768768'  ,'SURREY CLOVERDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/24/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768769'  ,'PETERBOROUGH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/18/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768770'  ,'BRAMPTON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/02/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768771'  ,'MARKHAM-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/10/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768772'  ,'BRANTFORD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/23/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768773'  ,'MONTREAL ST LEONARD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768774'  ,'REPENTIGNY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/13/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768775'  ,'TROIS-RIVIERES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/29/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768776'  ,'MISSISSAUGA-MEADOWVALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/23/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768777'  ,'NORTH VANCOUVER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/30/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768778'  ,'WINNIPEG-REGENT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/31/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768779'  ,'GATINEAU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/22/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768780'  ,'TORONTO-CORKTOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/07/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768781'  ,'ROYAL OAK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768782'  ,'MONTREAL-WEST ISLAND'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768784'  ,'BURNABY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/11/2010 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768785'  ,'OTTAWA-ORLEANS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/16/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768786'  ,'LEVIS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/27/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768790'  ,'MILTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/17/2010 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768791'  ,'BELLEFEUILLE-ST JEROME'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/29/2010 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768792'  ,'VICTORIA-DOWNTOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/23/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768793'  ,'MASCOUCHE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2010 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768794'  ,'BRAMPTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/09/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768795'  ,'SURREY-WHITE ROCK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/22/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768796'  ,'KINGSTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/21/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768797'  ,'ABBOTSFORD-S FRASER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/26/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768804'  ,'OTTAWA-KANATA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/14/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768806'  ,'MISSISSAUGA-ERINDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/25/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768807'  ,'TORONTO-KEELE ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/20/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768808'  ,'WINNIPEG-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/18/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768809'  ,'WHITBY-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/08/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768810'  ,'KITCHENER-WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/21/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768811'  ,'SASKATOON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/11/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768812'  ,'OTTAWA-BANK STREET'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/24/2013 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768813'  ,'TORONTO-SCARBOROUGH EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/27/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768815'  ,'EAST GWILLIMBURY-NEWMARKET'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/09/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768816'  ,'LONDON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/10/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768817'  ,'BURNABY-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768818'  ,'VAUGHAN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/29/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768819'  ,'WATERDOWN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/21/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768820'  ,'LONGUEUIL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/11/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768821'  ,'SAINTE JULIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/11/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768822'  ,'WINNIPEG-CENTRAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/17/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768823'  ,'LOWER SACKVILLE-HALIFAX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/26/2012 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768824'  ,'COURTICE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/29/2013 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768825'  ,'MISSISSAUGA-DUNDAS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/25/2013 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768826'  ,'TORONTO-ETOBICOKE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('07/11/2013 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768827'  ,'ST THERESE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/14/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768828'  ,'BELLEVILLE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/11/2013 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768829'  ,'MONCTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/22/2013 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768830'  ,'MONTREAL-ST ANTOINE WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/30/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768831'  ,'BRAMPTON-WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/04/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768832'  ,'TORONTO-WILLOWDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/05/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768835'  ,'QUEBEC CITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/15/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768836'  ,'LAVAL-WEST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/27/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768837'  ,'BROSSARD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/09/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768838'  ,'VILLE ST-LAURENT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/09/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768839'  ,'ST EUSTACHE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/12/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768840'  ,'LASALLE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/16/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768841'  ,'MOUNT PEARL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('02/19/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768843'  ,'ST JOHN''S'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('08/03/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768844'  ,'VAUDREUIL-DORION'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/24/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768845'  ,'ABBOTSFORD-RIVERSIDE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768846'  ,'VANCOUVER-ARBUTUS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768849'  ,'BRANDON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768850'  ,'BURNABY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768851'  ,'CALGARY COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768852'  ,'CALGARY CENTRAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768853'  ,'CALGARY HUNTERHORN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768854'  ,'CALGARY NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768855'  ,'CALGARY NORTHEAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768856'  ,'CALGARY-RANCHLANDS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768857'  ,'CALGARY-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768858'  ,'CAMBRIDGE BRANCH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768859'  ,'CAMPBELL RIVER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768860'  ,'CHILLIWACK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768861'  ,'COQUITLAM'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768862'  ,'COURTENAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768863'  ,'CRANBROOK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768864'  ,'TORONTO-FRONT ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768865'  ,'DUNCAN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768866'  ,'EDMONTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768867'  ,'EDMONTON NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768868'  ,'EDMONTON-SE COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768869'  ,'EDMONTON SOUTHPOINT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768870'  ,'EDMONTON WESTGATE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768871'  ,'VANCOUVER COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768872'  ,'FLEETWOOD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768873'  ,'FORT MCMURRAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768874'  ,'GOLDSTREAM'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768875'  ,'GRANDE PRAIRIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768876'  ,'HAMILTON-UPPER OTTAWA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768877'  ,'KAMLOOPS'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768878'  ,'KELOWNA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768879'  ,'LANGLEY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768880'  ,'LETHBRIDGE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768881'  ,'LLOYDMINSTER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768882'  ,'LONDON-STANELY ST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768883'  ,'LONDON SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768884'  ,'MAPLE RIDGE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768886'  ,'MISSISSAUGA-RIDGEWAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768887'  ,'MONTREAL-ST LAURENT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768888'  ,'MOOSE JAW'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768889'  ,'NANAIMO'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768890'  ,'NEW WESTMINSTER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768892'  ,'NORTH VANCOUVER-MARINE DR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768893'  ,'PENTICTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768894'  ,'PICKERING'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768896'  ,'PRINCE ALBERT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768897'  ,'PRINCE GEORGE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768901'  ,'PRINCE RUPERT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768903'  ,'RED DEER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768904'  ,'REGINA COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768905'  ,'REGINA EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768906'  ,'ETOBICOKE-REXDALE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768907'  ,'RICHMOND HILL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768908'  ,'RICHMOND SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768909'  ,'SARNIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768910'  ,'SASKATOON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768911'  ,'SASKATOON-EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768913'  ,'SHERWOOD PARK'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768914'  ,'ST ALBERT'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768916'  ,'WINNIPEG-ST VITAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768917'  ,'RICHMOND'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768918'  ,'SURREY-CENTRAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768919'  ,'SURREY-DELTA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768920'  ,'THUNDER BAY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768921'  ,'VERNON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768922'  ,'VICTORIA COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768923'  ,'VANCOUVER-VICTORIA DR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768924'  ,'VICTORIA-GORDON HEAD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768925'  ,'WATERLOO'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768926'  ,'WEST KELOWNA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768930'  ,'WINNIPEG COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768931'  ,'WINNIPEG EAST'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/01/2014 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768935'  ,'HALIFAX-BAYER''S LAKE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/28/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768936'  ,'BRAMPTON-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/28/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768937'  ,'MONTREAL-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768938'  ,'RED DEER-NORTH-COMMERCIAL'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/30/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768940'  ,'SAINT JOHN'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/30/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768941'  ,'SHERBROOKE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/13/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768942'  ,'TORONTO-DANFORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/21/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768943'  ,'MARKHAM-SOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/12/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768944'  ,'SCARBOROUGH-GOLDEN MILE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/11/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768945'  ,'FREDERICTON-NORTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/16/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768946'  ,'L''ANCIENNE-LORETTE-QUEBEC CITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/04/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768947'  ,'WHITBY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/27/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768948'  ,'DOLLARD-DES-ORMEAUX'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('05/09/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '768953'  ,'WINDSOR'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/17/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '771493'  ,'MONCTON-PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/03/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '771494'  ,'LONDON-PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('10/03/2016 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '778703'  ,'BRAMPTON PF'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/26/1991 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '778716'  ,'MONTREAL-NORD'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/26/1994 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '778718'  ,'LANGLEY-VANCOUVER FACILITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/22/1994 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '778737'  ,'WINNIPEG-PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/31/2003 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '778739'  ,'CALGARY PRODUCT FINISHES'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/27/2002 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '778842'  ,'WINNIPEG-PF LARGE EQUIPMENT '  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('04/29/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779001'  ,'AUTO SCARBOROUGH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779002'  ,'AUTO MISSISSAUGA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779003'  ,'AUTO CALGARY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779004'  ,'AUTO SAINT CATHERINE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779005'  ,'AUTO LANGLEY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779007'  ,'AUTO LONDON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779008'  ,'01/18 AUTO VICTORIA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('03/01/2013 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779009'  ,'AUTO KITCHENER'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779010'  ,'AUTO DARTMOUTH'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779011'  ,'AUTO EDMONTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779012'  ,'AUTO HAMILTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779015'  ,'AUTO VILLE D''ANJOU'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779016'  ,'AUTO REGINA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/19/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779018'  ,'AUTO QUEBEC CITY'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('12/22/2015 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779022'  ,'AUTO WINNIPEG'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('11/23/2009 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779024'  ,'AUTO OTTAWA'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('09/22/2008 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779026'  ,'AUTO BARRIE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779029'  ,'AUTO ST HYACINTHE'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('06/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '779081'  ,'AUTO MONCTON'  ,'P'  ,'S'  ,'CAN'  ,TO_DATE('01/08/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '791431'  ,'ELKHART FACILITY'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('05/02/2011 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '792760'  ,'PF FINANCIAL SERVICES POS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('07/07/2004 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '799162'  ,'AUTO CHERRY HILL'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('12/03/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '799325'  ,'AUTO CHARLESTON'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('08/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '799701'  ,'AUTO FT COLLINS'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('08/08/2007 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '799748'  ,'AUTO GRAND PRAIRIE'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('08/01/2006 ','MM/DD/YYYY') , 'BAG'  from Dual Union
SELECT '799752'  ,'AUTO MESQUITE'  ,'P'  ,'S'  ,'USA'  ,TO_DATE('09/02/2008 ','MM/DD/YYYY') , 'BAG'  from Dual);
-- Commit the complete transaction
COMMIT;
SELECT * FROM BANK_DEP_TICK_BAG_EXCLD_CCS;
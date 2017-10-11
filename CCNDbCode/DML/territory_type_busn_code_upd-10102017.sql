/*
Created : 10/140/2017 nxk927
          Updating the TERRITORY_TYPE_BUSN_CODE and cost center name
          Cost Centers 755520, 754444 and 754555 have cost center name length greater than 35, so using only 35 characters
          
          Business rule verified in Production for TERRITORY_TYPE_BUSN_CODE
          SELECT *
            FROM CODE_DETAIL
           WHERE CODE_DETAIL.CODE_HEADER_NAME  = 'TERRITORY_TYPE_BUSN_CODE'
             AND CODE_DETAIL.CODE_DETAIL_VALUE IN ('MS','CM','RR','NR','PM');
*/
DECLARE
CURSOR CC_CUR IS
    SELECT '754819' COST_CENTER_CODE, 'CLEVELAND MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756618' COST_CENTER_CODE, 'CLEVELAND COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755998' COST_CENTER_CODE, 'MID OHIO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758487' COST_CENTER_CODE, 'MID OHIO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754173' COST_CENTER_CODE, 'PORTLAND RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756875' COST_CENTER_CODE, 'PORTLAND RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756453' COST_CENTER_CODE, 'SPOKANE MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q009' COST_CENTER_CODE, 'SPOKANE RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756929' COST_CENTER_CODE, 'CASCADE MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758406' COST_CENTER_CODE, 'BOISE NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q326' COST_CENTER_CODE, 'GREEN BAY RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q765' COST_CENTER_CODE, 'GREEN BAY RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756514' COST_CENTER_CODE, 'MILWAUKEE MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754169' COST_CENTER_CODE, 'CHICAGO METRO NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754569' COST_CENTER_CODE, 'CHICAGO METRO COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754943' COST_CENTER_CODE, 'CHICAGO METRO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756755' COST_CENTER_CODE, 'CHICAGO METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758362' COST_CENTER_CODE, 'SOUTH BEND RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q353' COST_CENTER_CODE, 'CENTRAL IL RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756865' COST_CENTER_CODE, 'FORT WAYNE NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754298' COST_CENTER_CODE, 'BOSTON MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755989' COST_CENTER_CODE, 'BOSTON RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758319' COST_CENTER_CODE, 'NORTHEAST PA COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758341' COST_CENTER_CODE, 'NORTHEAST PA COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756660' COST_CENTER_CODE, 'WESTERN NEW YORK MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754502' COST_CENTER_CODE, 'UPSTATE NY PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754506' COST_CENTER_CODE, 'BALTIMORE RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755572' COST_CENTER_CODE, 'CAPITAL COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q410' COST_CENTER_CODE, 'METRO NEW YORK MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q418' COST_CENTER_CODE, 'METRO NEW YORK PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q431' COST_CENTER_CODE, 'METRO NEW YORK MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756269' COST_CENTER_CODE, 'METRO NEW JERSEY COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q450' COST_CENTER_CODE, 'METRO NEW JERSEY RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754026' COST_CENTER_CODE, 'LONG ISLAND MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758462' COST_CENTER_CODE, 'LONG ISLAND RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q466' COST_CENTER_CODE, 'LONG ISLAND RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755520' COST_CENTER_CODE, 'CENTRAL PENNSYLVANIA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755542' COST_CENTER_CODE, 'DELMAR RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755549' COST_CENTER_CODE, 'DELMAR MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758305' COST_CENTER_CODE, 'NEW JERSEY COASTAL COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755538' COST_CENTER_CODE, 'NEW JERSEY WEST PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754216' COST_CENTER_CODE, 'RALEIGH METRO PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '757846' COST_CENTER_CODE, 'RALEIGH METRO COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756438' COST_CENTER_CODE, 'CHARLOTTE METRO COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754087' COST_CENTER_CODE, 'GREENSBORO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755652' COST_CENTER_CODE, 'GREENSBORO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754916' COST_CENTER_CODE, 'ATLANTA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755733' COST_CENTER_CODE, 'ATLANTA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756785' COST_CENTER_CODE, 'ATLANTA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754457' COST_CENTER_CODE, 'BIRMINGHAM COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '757812' COST_CENTER_CODE, 'GEORGIA SOUTH PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q558' COST_CENTER_CODE, 'CHATTANOOGA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q500' COST_CENTER_CODE, 'SOUTHERN ALABAMA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q589' COST_CENTER_CODE, 'SOUTHERN ALABAMA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754444' COST_CENTER_CODE, 'SOUTHWEST FLORIDA METRO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754555' COST_CENTER_CODE, 'SOUTHWEST FLORIDA METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754296' COST_CENTER_CODE, 'SOUTH FLORIDA METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754451' COST_CENTER_CODE, 'SOUTH FLORIDA METRO NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q519' COST_CENTER_CODE, 'SOUTH FLORIDA METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754041' COST_CENTER_CODE, 'ORLANDO PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754095' COST_CENTER_CODE, 'ORLANDO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754235' COST_CENTER_CODE, 'EAST COAST FLORIDA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754541' COST_CENTER_CODE, 'EAST COAST FLORIDA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q213' COST_CENTER_CODE, 'EAST COAST FLORIDA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q217' COST_CENTER_CODE, 'EAST COAST FLORIDA COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754599' COST_CENTER_CODE, 'PUERTO RICO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754903' COST_CENTER_CODE, 'PUERTO RICO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756026' COST_CENTER_CODE, 'PUERTO RICO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756599' COST_CENTER_CODE, 'PUERTO RICO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q508' COST_CENTER_CODE, 'PUERTO RICO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q511' COST_CENTER_CODE, 'CARIBBEAN COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q544' COST_CENTER_CODE, 'CARIBBEAN MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754170' COST_CENTER_CODE, 'MEMPHIS PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754251' COST_CENTER_CODE, 'MEMPHIS MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756643' COST_CENTER_CODE, 'LOUISIANA NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758346' COST_CENTER_CODE, 'LOUISIANA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q517' COST_CENTER_CODE, 'LOUISIANA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q546' COST_CENTER_CODE, 'LOUISIANA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q573' COST_CENTER_CODE, 'LOUISIANA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756164' COST_CENTER_CODE, 'AUSTIN NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756952' COST_CENTER_CODE, 'HOUSTON MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q670' COST_CENTER_CODE, 'HOUSTON MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754926' COST_CENTER_CODE, 'VALLEY COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q650' COST_CENTER_CODE, 'MID-TEXAS RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754768' COST_CENTER_CODE, 'CALIFORNIA NORTH RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q036' COST_CENTER_CODE, 'CALIFORNIA CENTRAL MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754911' COST_CENTER_CODE, 'CALIFORNIA BAY COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754972' COST_CENTER_CODE, 'CALIFORNIA BAY MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755515' COST_CENTER_CODE, 'CALIFORNIA BAY MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755874' COST_CENTER_CODE, 'CALIFORNIA BAY MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755975' COST_CENTER_CODE, 'CALIFORNIA BAY MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756464' COST_CENTER_CODE, 'CALIFORNIA BAY RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756966' COST_CENTER_CODE, 'CALIFORNIA BAY MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '758454' COST_CENTER_CODE, 'CALIFORNIA BAY RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754014' COST_CENTER_CODE, 'LOS ANGELES MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754668' COST_CENTER_CODE, 'LOS ANGELES COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754951' COST_CENTER_CODE, 'LOS ANGELES PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q045' COST_CENTER_CODE, 'LOS ANGELES RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756783' COST_CENTER_CODE, 'SAN DIEGO PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q072' COST_CENTER_CODE, 'SAN DIEGO NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q075' COST_CENTER_CODE, 'SAN DIEGO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q077' COST_CENTER_CODE, 'SAN DIEGO PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q085' COST_CENTER_CODE, 'SAN DIEGO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756740' COST_CENTER_CODE, 'CAL COAST RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q031' COST_CENTER_CODE, 'CAL COAST MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q033' COST_CENTER_CODE, 'CAL COAST RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q100' COST_CENTER_CODE, 'SAN FERNANDO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756426' COST_CENTER_CODE, 'DALLAS-FT WORTH MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754675' COST_CENTER_CODE, 'NEW MEXICO NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755895' COST_CENTER_CODE, 'DENVER PROP MAINT REP' COST_CENTER_NAME, 'PM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q163' COST_CENTER_CODE, 'SALT LAKE CITY MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q166' COST_CENTER_CODE, 'SALT LAKE CITY RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '754750' COST_CENTER_CODE, 'LAS VEGAS MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '755906' COST_CENTER_CODE, 'LAS VEGAS MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q060' COST_CENTER_CODE, 'LAS VEGAS MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '75Q124' COST_CENTER_CODE, 'SOUTHERN COLORADO RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756817' COST_CENTER_CODE, 'MIDWEST NEW RES REP' COST_CENTER_NAME, 'NR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '756521' COST_CENTER_CODE, 'TEXARKANA COMM REP' COST_CENTER_NAME, 'CM' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q271' COST_CENTER_CODE, 'SOUTHWEST ONTARIO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '766036' COST_CENTER_CODE, 'QUEBEC MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q856' COST_CENTER_CODE, 'QUEBEC MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q863' COST_CENTER_CODE, 'QUEBEC RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q867' COST_CENTER_CODE, 'QUEBEC MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '766310' COST_CENTER_CODE, 'EASTERN CANADA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '766317' COST_CENTER_CODE, 'TORONTO METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '766986' COST_CENTER_CODE, 'TORONTO METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q272' COST_CENTER_CODE, 'TORONTO METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q273' COST_CENTER_CODE, 'TORONTO METRO MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q242' COST_CENTER_CODE, 'BRITISH COLUMBIA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q246' COST_CENTER_CODE, 'BRITISH COLUMBIA MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q253' COST_CENTER_CODE, 'NORTHERN ALBERTA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q255' COST_CENTER_CODE, 'NORTHERN ALBERTA RES REPAINT REP' COST_CENTER_NAME, 'RR' TERRITORY_TYPE_BUSN_CODE FROM DUAL UNION
    SELECT '76Q236' COST_CENTER_CODE, 'SASKMAN MULTI SEG REP' COST_CENTER_NAME, 'MS' TERRITORY_TYPE_BUSN_CODE FROM DUAL;

BEGIN
    FOR REC IN CC_CUR LOOP
       UPDATE COST_CENTER_CODE
          SET COST_CENTER_NAME = SUBSTR(REC.COST_CENTER_NAME,1,35)
        WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE
          AND COST_CENTER_NAME <>SUBSTR(REC.COST_CENTER_NAME,1,35);

      UPDATE TERRITORY
          SET TERRITORY_TYPE_BUSN_CODE = REC.TERRITORY_TYPE_BUSN_CODE
        WHERE COST_CENTER_CODE         = REC.COST_CENTER_CODE
          AND TERRITORY_TYPE_BUSN_CODE<> REC.TERRITORY_TYPE_BUSN_CODE;
    COMMIT;

    POS_DATA_GENERATION.POS_MASTER_SP(REC.COST_CENTER_CODE);
    COMMIT;
    END LOOP;
END;

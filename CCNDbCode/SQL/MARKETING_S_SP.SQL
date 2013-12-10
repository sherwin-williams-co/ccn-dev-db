CREATE OR REPLACE PROCEDURE MARKETING_S_SP  ( IN_COST_CENTER                 IN  MARKETING.COST_CENTER_CODE%TYPE
                          , IN_MARKETING_TYPE              IN  MARKETING.MARKETING_TYPE%TYPE                          
                          , OUT_MARKETING_REF_CUR          IN  OUT sys_refcursor)
/*******************************************************************************
	MARKETING_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the MARKETING table.  

created : 03/20/2012 tal CCN Project....
changed : 09/12/2012 TAL included eff-date exp-date logic
changed : 04/03/2013 BLR error message pointing to wrong procedure
changed : 05/29/2013 BLR CCNA-408 add marketing fields via record expansion. 
          Fields are mkt_brand, mkt_mission, mkt_sales_floor_size,
          mkt_warehouse_size, & mkt_real_estate_setting.
*******************************************************************************/
        as                  
v_code number;
v_errm varchar2(500);
v_curr_date date := sysdate;
MKT_STATS varchar2(07);
MKT_ROW    MARKETING%ROWTYPE;

	BEGIN

		  OPEN OUT_MARKETING_REF_CUR FOR
			  
			  select  S.*  
               ,( S.mkt_brand || S.mkt_mission || S.mkt_sales_floor_size || 
                  S.mkt_warehouse_size || S.mkt_real_estate_setting) as MKT_STATS
               from MARKETING S              
			  where S.cost_center_code        = in_cost_center         
         and  S.marketing_type          = nvl(in_marketing_type, marketing_type) 
			   and (S.effective_date         <=  v_curr_date  
			   and (S.expiration_date is null or expiration_date  >=  v_curr_date)
  );
	  
  EXCEPTION
	  WHEN OTHERS THEN 
      v_code  := SQLCODE;
      v_errm  := substr(sqlerrm,1,200);
      errpkg.raise_err(v_code,     'MARKETING_S_SP, ' || ' ' ||
             'COST_CENTER_CODE is ' || in_COST_CENTER   || ';  ' ||
             'MARKETING_TYPE is '   || in_MARKETING_TYPE || '; ' || v_errm);
                     
	END MARKETING_S_SP;


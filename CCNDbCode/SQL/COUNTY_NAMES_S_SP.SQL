PROCEDURE COUNTY_NAMES_S_SP (
/*******************************************************************************
	COUNTY_NAMES_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the COUNTY_NAME table. For a State_code entered a Ref_Cursor will be 
  returned pointing to a table of all the County_Names for that State_Code

created : 06/07/2013 tal CCN Project....
changed : 
*******************************************************************************/
     in_STATE_CODE  IN  COUNTY_NAMES.STATE_CODE%TYPE
		,out_REF_CUR    OUT sys_refcursor   )
        IS
        
v_code number;
v_errm varchar2(500);

	BEGIN

		  OPEN out_REF_CUR FOR
			  
			  SELECT * 
			  FROM COUNTY_NAMES
			  where state_code = in_STATE_CODE;
	  
  EXCEPTION
	  WHEN OTHERS THEN 
      v_code  := SQLCODE;
      v_errm  := substr(SQLERRM,1,200);
      errpkg.raise_err(v_code, 'COUNTY_NAMES_S_SP, ' || ' ' ||
             ' STATE_CODE is ' || in_STATE_CODE || '; ' || v_errm);
                     
	END COUNTY_NAMES_S_SP;
/


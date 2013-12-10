CREATE OR REPLACE function COMPUTE_EXPIRATION_DATE
/******************************************************************************
	COMPUTE_EXPIRATOIN_DATE (in_date)
  
		This function will be used to read in a date and subtract one day
    from that date (effective) and return a new date (expiration) which
    is one day prior.
    
    The an input date must be passed.  
    This function will return a new (expiration) date. 

created : 12/04/2012 mdh Cost Center Nucleus project.....
revised:
******************************************************************************/
  ( in_date  in  date 
   ) return date 
   IS 

v_return_date date ;
v_curr_date date := sysdate;
v_code number;
v_errm varchar(500);

begin
 	if in_date is not null then
    	v_return_date := in_date - 1; -- input date minus 1 day
	else
		v_return_date := v_curr_date - 1;  -- default date
	end if; 
	return(v_return_date);
   
end COMPUTE_EXPIRATION_DATE;


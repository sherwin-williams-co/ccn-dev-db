--script to run Hyperion file for the year 2013
BEGIN
  FOR each_pay IN(SELECT * FROM HYP_BRWD_2013 where week_nbr ='02' ORDER BY check_dt)
  loop
      HYPERION_INTERFACE_PKG_BRWD.build_interface(each_pay.week_nbr, each_pay.check_dt);
  END loop;
  
END;
/
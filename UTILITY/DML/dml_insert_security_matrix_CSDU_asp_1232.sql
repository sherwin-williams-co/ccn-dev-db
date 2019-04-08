/*##############################################################################################################
Created : 04/08/2019 sxg151 CCN Project Team...
        : ASP-1232 : Grant access to Lee Niedenthal(LXN782) as per Jason Klodnick emial on April 8th 2019.
                     Grant access to David Flors (DAF328) and Owen Pullar (OTP173) as per Marissa Papas.
--#############################################################################################################	
*/
select * from security_matrix where user_id in ( 'otp173','daf328','lxn782');


Insert into SECURITY_MATRIX values ('otp173','otp173','CSDU');
Insert into SECURITY_MATRIX values ('daf328','daf328','CSDU');
Insert into SECURITY_MATRIX values ('lxn782','lxn782','CSDU');

select * from security_matrix where user_id in ( 'otp173','daf328','lxn782');

COMMIT;

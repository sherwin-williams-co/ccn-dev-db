/*
Below script will grant CCN View access on cost center and store drafts to interns
Owen Pullar: OTP173 
David Flors: DAF328

Created : 9/27/2018 kxm302 CCN Project Team....
Changed :
*/

INSERT INTO SECURITY_MATRIX VALUES ('otp173', 'otp173', 'CCNUS1');
INSERT INTO SECURITY_MATRIX VALUES ('otp173', 'otp173', 'SDUS');
INSERT INTO SECURITY_MATRIX VALUES ('daf328', 'daf328', 'CCNUS1');
INSERT INTO SECURITY_MATRIX VALUES ('daf328', 'daf328', 'SDUS');

COMMIT;
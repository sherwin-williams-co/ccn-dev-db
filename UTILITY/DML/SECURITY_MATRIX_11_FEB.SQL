--Adding new users MXT696, MXS363 for storedraft(SDU1)
insert into ccn_utility.security_matrix(user_id, password, role_code) values('mxt696', 'mxt696', 'SDU1');
insert into ccn_utility.security_matrix(user_id, password, role_code) values('mxs363', 'mxs363', 'SDU1');

COMMIT;
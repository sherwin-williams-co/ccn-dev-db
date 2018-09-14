/*******************************************************************************
Grant select permission to utility for store table.

Permission needs to be granted to utility on store table to populate the descartes delivery code tag value in store.xsd file.

Create synonym for store table in utility database.

  CREATED : 09/13/2018 pxa852 CCN Project...
*******************************************************************************/

GRANT SELECT ON STORE TO CCN_UTILITY;

CREATE OR REPLACE SYNONYM CCN_UTILITY.STORE FOR COSTCNTR.STORE;

commit;
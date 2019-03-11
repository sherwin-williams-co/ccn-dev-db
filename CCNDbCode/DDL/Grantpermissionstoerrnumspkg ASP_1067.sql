/*******************************************************************************

Execution Permission needs to be granted to utility on errnums pkg to raise an error in UI when user
tries to trgger a download for a cost center which has pos download indictor 'N'.

Create synonym to errnums pkg in utility database.

CREATED : 03/11/2019 pxa852 CCN Project Team...
*******************************************************************************/

CREATE OR REPLACE SYNONYM CCN_UTILITY.CCN_ERRNUMS FOR COSTCNTR.ERRNUMS;
GRANT EXECUTE ON ERRNUMS TO CCN_UTILITY;

commit;
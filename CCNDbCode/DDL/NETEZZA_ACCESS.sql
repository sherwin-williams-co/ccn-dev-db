grant select on CCN_PHONE_INFO_VW to NETEZZA_ACCESS;
grant select on STATUS_VIEW to NETEZZA_ACCESS;

CREATE  SYNONYM NETEZZA_ACCESS.CCN_PHONE_INFO_VW
FOR CCN_PHONE_INFO_VW;

CREATE  SYNONYM NETEZZA_ACCESS.STATUS_VIEW
FOR STATUS_VIEW;

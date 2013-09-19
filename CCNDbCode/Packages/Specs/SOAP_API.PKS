PACKAGE soap_api AS
-- --------------------------------------------------------------------------
-- Name         : http://www.oracle-base.com/dba/miscellaneous/soap_api
-- Author       : DR Timothy S Hall
-- Description  : SOAP related functions for consuming web services.
-- Ammedments   :
--   When         Who       What
--   ===========  ========  =================================================
--   04-OCT-2003  Tim Hall  Initial Creation
--   23-FEB-2006  Tim Hall  Parameterized the "soap" envelope tags.
-- --------------------------------------------------------------------------

TYPE t_request IS RECORD (
  method        VARCHAR2(256),
  namespace     VARCHAR2(256),
  body          VARCHAR2(32767),
  envelope_tag  VARCHAR2(30)
);

TYPE t_response IS RECORD
(
  doc           XMLTYPE,
  envelope_tag  VARCHAR2(30)
);

FUNCTION new_request(p_method        IN  VARCHAR2,
                     p_namespace     IN  VARCHAR2,
                     p_envelope_tag  IN  VARCHAR2 DEFAULT 'SOAP-ENV')
  RETURN t_request;


PROCEDURE add_parameter(p_request  IN OUT NOCOPY  t_request,
                        p_name     IN             VARCHAR2,
                        p_type     IN             VARCHAR2,
                        p_value    IN             VARCHAR2);

FUNCTION invoke(p_request  IN OUT NOCOPY  t_request,
                p_url      IN             VARCHAR2,
                p_action   IN             VARCHAR2)
  RETURN t_response;

FUNCTION get_return_value(p_response   IN OUT NOCOPY  t_response,
                          p_name       IN             VARCHAR2,
                          p_namespace  IN             VARCHAR2)
  RETURN VARCHAR2;

END soap_api;
/


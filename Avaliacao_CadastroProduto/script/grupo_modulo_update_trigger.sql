﻿-- Function: sistema.grupo_modulo_dtupdate_trigger()

-- DROP FUNCTION sistema.grupo_modulo_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.grupo_modulo_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.grupo_modulo_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: grupo_modulo_update_trigger on sistema.grupo_modulo

-- DROP TRIGGER grupo_modulo_update_trigger ON sistema.grupo_modulo;

CREATE TRIGGER grupo_modulo_update_trigger
  BEFORE UPDATE
  ON sistema.grupo_modulo
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.grupo_modulo_dtupdate_trigger();
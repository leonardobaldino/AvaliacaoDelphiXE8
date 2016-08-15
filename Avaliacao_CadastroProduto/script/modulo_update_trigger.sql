-- Function: sistema.modulo_dtupdate_trigger()

-- DROP FUNCTION sistema.modulo_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.modulo_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.modulo_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: modulo_update_trigger on sistema.modulo

-- DROP TRIGGER modulo_update_trigger ON sistema.modulo;

CREATE TRIGGER modulo_update_trigger
  BEFORE UPDATE
  ON sistema.modulo
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.modulo_dtupdate_trigger();

-- Function: sistema.tipocontato_dtupdate_trigger()

-- DROP FUNCTION sistema.tipocontato_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.tipocontato_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.tipocontato_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: tipocontato_update_trigger on sistema.tipocontato

-- DROP TRIGGER tipocontato_update_trigger ON sistema.tipocontato;

CREATE TRIGGER tipocontato_update_trigger
  BEFORE UPDATE
  ON sistema.tipocontato
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.tipocontato_dtupdate_trigger();

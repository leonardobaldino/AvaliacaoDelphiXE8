-- Function: sistema.grupo_dtupdate_trigger()

-- DROP FUNCTION sistema.grupo_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.grupo_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.grupo_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: grupo_update_trigger on sistema.grupo

-- DROP TRIGGER grupo_update_trigger ON sistema.grupo;

CREATE TRIGGER grupo_update_trigger
  BEFORE UPDATE
  ON sistema.grupo
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.grupo_dtupdate_trigger();

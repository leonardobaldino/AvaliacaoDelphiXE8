-- Function: sistema.contato_dtupdate_trigger()

-- DROP FUNCTION sistema.contato_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.contato_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.contato_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: contato_update_trigger on sistema.contato

-- DROP TRIGGER contato_update_trigger ON sistema.contato;

CREATE TRIGGER contato_update_trigger
  BEFORE UPDATE
  ON sistema.contato
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.contato_dtupdate_trigger();

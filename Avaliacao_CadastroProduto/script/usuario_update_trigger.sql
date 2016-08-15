-- Function: sistema.usuario_dtupdate_trigger()

-- DROP FUNCTION sistema.usuario_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.usuario_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.usuario_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: usuario_update_trigger on sistema.usuario

-- DROP TRIGGER usuario_update_trigger ON sistema.usuario;

CREATE TRIGGER usuario_update_trigger
  BEFORE UPDATE
  ON sistema.usuario
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.usuario_dtupdate_trigger();

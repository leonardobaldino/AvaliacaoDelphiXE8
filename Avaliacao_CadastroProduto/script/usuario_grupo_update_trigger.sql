-- Function: sistema.usuario_grupo_dtupdate_trigger()

-- DROP FUNCTION sistema.usuario_grupo_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.usuario_grupo_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.usuario_grupo_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: usuario_grupo_update_trigger on sistema.usuario_grupo

-- DROP TRIGGER usuario_grupo_update_trigger ON sistema.usuario_grupo;

CREATE TRIGGER usuario_grupo_update_trigger
  BEFORE UPDATE
  ON sistema.usuario_grupo
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.usuario_grupo_dtupdate_trigger();

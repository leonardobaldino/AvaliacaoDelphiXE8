-- Function: sistema.imagem_dtupdate_trigger()

-- DROP FUNCTION sistema.imagem_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.imagem_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.imagem_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: imagem_update_trigger on sistema.imagem

-- DROP TRIGGER imagem_update_trigger ON sistema.imagem;

CREATE TRIGGER imagem_update_trigger
  BEFORE UPDATE
  ON sistema.imagem
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.imagem_dtupdate_trigger();

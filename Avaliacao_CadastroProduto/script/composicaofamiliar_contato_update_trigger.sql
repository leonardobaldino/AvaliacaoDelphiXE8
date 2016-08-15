-- Function: sistema.composicaofamiliar_contato_dtupdate_trigger()

-- DROP FUNCTION sistema.composicaofamiliar_contato_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.composicaofamiliar_contato_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.composicaofamiliar_contato_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: composicaofamiliar_contato_update_trigger on sistema.composicaofamiliar_contato

-- DROP TRIGGER composicaofamiliar_contato_update_trigger ON sistema.composicaofamiliar_contato;

CREATE TRIGGER composicaofamiliar_contato_update_trigger
  BEFORE UPDATE
  ON sistema.composicaofamiliar_contato
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.composicaofamiliar_contato_dtupdate_trigger();

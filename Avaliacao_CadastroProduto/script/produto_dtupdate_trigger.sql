-- Function: sistema.produto_dtupdate_trigger()

-- DROP FUNCTION sistema.produto_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.produto_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.produto_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: produto_update_trigger on sistema.produto

-- DROP TRIGGER produto_update_trigger ON sistema.produto;

CREATE TRIGGER produto_update_trigger
  BEFORE UPDATE
  ON sistema.produto
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.produto_dtupdate_trigger();

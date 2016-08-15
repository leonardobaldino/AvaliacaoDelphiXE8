-- Function: sistema.fornecedor_dtupdate_trigger()

-- DROP FUNCTION sistema.fornecedor_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.fornecedor_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.fornecedor_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: fornecedor_update_trigger on sistema.fornecedor

-- DROP TRIGGER fornecedor_update_trigger ON sistema.fornecedor;

CREATE TRIGGER fornecedor_update_trigger
  BEFORE UPDATE
  ON sistema.fornecedor
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.fornecedor_dtupdate_trigger();

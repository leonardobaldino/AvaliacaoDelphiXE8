-- Function: sistema.colaborador_contato_dtupdate_trigger()

-- DROP FUNCTION sistema.fornecedor_contato_dtupdate_trigger();

CREATE OR REPLACE FUNCTION sistema.fornecedor_contato_dtupdate_trigger()
  RETURNS trigger AS
$BODY$
BEGIN
	new.dtupdate = now();
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema.fornecedor_contato_dtupdate_trigger()
  OWNER TO postgres;


-- Trigger: fornecedor_contato_update_trigger on sistema.fornecedor_contato

-- DROP TRIGGER fornecedor_contato_update_trigger ON sistema.fornecedor_contato;

CREATE TRIGGER fornecedor_contato_update_trigger
  BEFORE UPDATE
  ON sistema.fornecedor_contato
  FOR EACH ROW
  EXECUTE PROCEDURE sistema.fornecedor_contato_dtupdate_trigger();

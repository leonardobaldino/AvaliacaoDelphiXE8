-- Function: sistema.fornecedor_existe_fornecedor(bigint)

-- DROP FUNCTION sistema.fornecedor_existe_fornecedor(bigint);

CREATE OR REPLACE FUNCTION sistema.fornecedor_existe_fornecedor(bigint)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	SELECT COUNT(ID) INTO retorno FROM sistema.fornecedor_view WHERE nome_fantasia = $1;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.fornecedor_existe_fornecedor(bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.fornecedor_existe_fornecedor(bigint) TO postgres WITH GRANT OPTION;

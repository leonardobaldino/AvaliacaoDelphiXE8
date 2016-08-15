-- Function: sistema.produto_existe_produto(bigint)

-- DROP FUNCTION sistema.produto_existe_produto(bigint);

CREATE OR REPLACE FUNCTION sistema.produto_existe_produto(bigint)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	SELECT COUNT(ID) INTO retorno FROM sistema.produto_view WHERE descricao = $1;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.produto_existe_produto(bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.produto_existe_produto(bigint) TO postgres WITH GRANT OPTION;

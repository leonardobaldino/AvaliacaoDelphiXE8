-- Function: sistema.grupo_produto_existe_grupo_produto(text)

-- DROP FUNCTION sistema.grupo_produto_existe_grupo_produto(text);

CREATE OR REPLACE FUNCTION sistema.grupo_produto_existe_grupo_produto(text)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	SELECT COUNT(ID) INTO retorno FROM sistema.grupo_produto_view WHERE descricao = $1;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.grupo_produto_existe_grupo_produto(text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.grupo_produto_existe_grupo_produto(text) TO postgres WITH GRANT OPTION;

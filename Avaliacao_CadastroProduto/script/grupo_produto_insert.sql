-- Function: sistema.grupo_produto_insert(text)

-- DROP FUNCTION sistema.grupo_produto_insert(text);

CREATE OR REPLACE FUNCTION sistema.grupo_produto_insert(text)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	INSERT INTO sistema.grupo_produto
	(descricao,dtinsert,isdelete)
	 VALUES 
	($1,now(),false)
	RETURNING id INTO retorno;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.grupo_produto_insert(text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.grupo_produto_insert(text) TO postgres WITH GRANT OPTION;;

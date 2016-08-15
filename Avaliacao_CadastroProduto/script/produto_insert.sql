-- Function: sistema.produto_insert(text)

-- DROP FUNCTION sistema.produto_insert(text);

CREATE OR REPLACE FUNCTION sistema.produto_insert(text)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	INSERT INTO sistema.produto
	(descricao,iseditando,dtinsert,isdelete)
	 VALUES 
	($1,true,now(),false)
	RETURNING id INTO retorno;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.produto_insert(text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.produto_insert(text) TO postgres WITH GRANT OPTION;;

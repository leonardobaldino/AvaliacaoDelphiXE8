-- Function: sistema.tipocontato_insert(text)

-- DROP FUNCTION sistema.tipocontato_insert(text);

CREATE OR REPLACE FUNCTION sistema.tipocontato_insert(text)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	INSERT INTO sistema.tipocontato
	(descricao,usuario_id_insert,dtinsert,isdelete)
	 VALUES 
	($1,0,now(),false)
	RETURNING id INTO retorno;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.tipocontato_insert(text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.tipocontato_insert(text) TO postgres WITH GRANT OPTION;

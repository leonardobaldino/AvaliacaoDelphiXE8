-- Function: sistema.contato_insert(bigint, text, text, bigint)

-- DROP FUNCTION sistema.contato_insert(bigint, text, text, bigint);

CREATE OR REPLACE FUNCTION sistema.contato_insert(
    bigint, text, text, bigint)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	INSERT INTO sistema.contato
	(tipocontato_id,valor,adicional,usuario_id_insert,dtinsert,isdelete)
	 VALUES 
	($1,$2,$3,$4,now(),false)
	RETURNING id INTO retorno;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.contato_insert(bigint, text, text, bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.contato_insert(bigint, text, text, bigint) TO postgres WITH GRANT OPTION;

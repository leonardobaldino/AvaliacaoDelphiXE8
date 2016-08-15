-- Function: sistema.fornecedor_contato_insert(bigint, bigint, bigint)

-- DROP FUNCTION sistema.fornecedor_contato_insert(bigint, bigint, bigint);

CREATE OR REPLACE FUNCTION sistema.fornecedor_contato_insert(
    bigint,
    bigint, bigint)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	INSERT INTO sistema.fornecedor_contato
	(fornecedor_id,contato_id,usuario_id_insert,dtinsert,isdelete)
	 VALUES 
	($1,$2,$3,now(),false)
	RETURNING id INTO retorno;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.fornecedor_contato_insert(bigint, bigint, bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.fornecedor_contato_insert(bigint, bigint, bigint) TO postgres WITH GRANT OPTION;

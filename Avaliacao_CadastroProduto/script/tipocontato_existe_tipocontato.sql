-- Function: sistema.tipocontato_existe_tipocontato(text)

-- DROP FUNCTION sistema.tipocontato_existe_tipocontato(text);

CREATE OR REPLACE FUNCTION sistema.tipocontato_existe_tipocontato(text)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	SELECT COUNT(ID) INTO retorno FROM sistema.tipocontato_view WHERE LOWER(descricao) = LOWER($1);
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.tipocontato_existe_tipocontato(text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.tipocontato_existe_tipocontato(text) TO postgres WITH GRANT OPTION;

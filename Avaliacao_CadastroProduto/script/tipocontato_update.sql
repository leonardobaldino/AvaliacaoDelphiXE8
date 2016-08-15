-- Function: sistema.tipocontato_update(bigint, bigint)

-- DROP FUNCTION sistema.tipocontato_update(bigint, bigint);

CREATE OR REPLACE FUNCTION sistema.tipocontato_update(bigint, bigint)
  RETURNS bigint AS
$BODY$
BEGIN
	UPDATE sistema.tipocontato SET usuario_id_update=$2 WHERE id=$1;
	RETURN 1;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.tipocontato_update(bigint, bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.tipocontato_update(bigint, bigint) TO postgres WITH GRANT OPTION;

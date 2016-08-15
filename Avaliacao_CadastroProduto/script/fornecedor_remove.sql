-- Function: sistema.fornecedor_remove(bigint)

-- DROP FUNCTION sistema.fornecedor_remove(bigint);

CREATE OR REPLACE FUNCTION sistema.fornecedor_remove(bigint)
  RETURNS bigint AS
$BODY$
BEGIN
	UPDATE sistema.fornecedor SET isdelete=true, dtdelete=now() WHERE id=$1;
	RETURN 1;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.fornecedor_remove(bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.fornecedor_remove(bigint) TO postgres WITH GRANT OPTION;;

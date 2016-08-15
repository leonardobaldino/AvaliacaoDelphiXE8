-- Function: sistema.fornecedor_contato_remove(bigint, bigint)

-- DROP FUNCTION sistema.fornecedor_contato_remove(bigint, bigint);

CREATE OR REPLACE FUNCTION sistema.fornecedor_contato_remove(
    bigint,
    bigint)
  RETURNS bigint AS
$BODY$
BEGIN
	UPDATE sistema.fornecedor_contato SET isdelete=true, dtdelete=now() WHERE fornecedor_id=$1 and contato_id=$2;
	RETURN 1;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.fornecedor_contato_remove(bigint, bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.fornecedor_contato_remove(bigint, bigint) TO postgres WITH GRANT OPTION;

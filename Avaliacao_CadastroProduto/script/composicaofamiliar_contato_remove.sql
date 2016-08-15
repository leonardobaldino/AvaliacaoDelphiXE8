-- Function: sistema.composicaofamiliar_contato_remove(bigint, bigint)

-- DROP FUNCTION sistema.composicaofamiliar_contato_remove(bigint, bigint);

CREATE OR REPLACE FUNCTION sistema.composicaofamiliar_contato_remove(bigint, bigint)
  RETURNS bigint AS
$BODY$
BEGIN
	UPDATE sistema.colaborador_contato SET isdelete=true, dtdelete=now() WHERE colaborador_id=$1 and contato_id=$2;
	RETURN 1;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.composicaofamiliar_contato_remove(bigint, bigint)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.composicaofamiliar_contato_remove(bigint, bigint) TO postgres;
GRANT EXECUTE ON FUNCTION sistema.composicaofamiliar_contato_remove(bigint, bigint) TO infamatv5 WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION sistema.composicaofamiliar_contato_remove(bigint, bigint) TO public;

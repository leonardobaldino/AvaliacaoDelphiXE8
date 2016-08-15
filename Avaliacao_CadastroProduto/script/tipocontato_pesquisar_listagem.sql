-- Function: sistema.tipocontato_pesquisar_listagem(text)

-- DROP FUNCTION sistema.tipocontato_pesquisar_listagem(text);

CREATE OR REPLACE FUNCTION sistema.tipocontato_pesquisar_listagem(/*descricao*/text)
RETURNS TABLE(id bigint, descricao text) AS
$BODY$
BEGIN
	RETURN query
	SELECT
		tipocontato_view.id,
		tipocontato_view.descricao
	FROM sistema.tipocontato_view
	WHERE
		(upper(tipocontato_view.descricao) like upper('%'||$1||'%'))
	ORDER BY tipocontato_view.descricao;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.tipocontato_pesquisar_listagem(text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.tipocontato_pesquisar_listagem(text) TO postgres WITH GRANT OPTION;

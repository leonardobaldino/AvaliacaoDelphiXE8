-- Function: sistema.grupo_produto_pesquisar_listagem(/*descricao*/text)

-- DROP FUNCTION sistema.grupo_produto_pesquisar_listagem/*descricao*/text);

CREATE OR REPLACE FUNCTION sistema.grupo_produto_pesquisar_listagem(/*descricao*/text)
RETURNS TABLE(id bigint, descricao text) AS
$BODY$
BEGIN
	RETURN query
	SELECT
		grupo_produto_view.id,
		grupo_produto_view.descricao
	FROM sistema.grupo_produto_view
	WHERE
		(upper(grupo_produto_view.descricao) like upper($1))
	ORDER BY grupo_produto_view.descricao LIMIT 10;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.grupo_produto_pesquisar_listagem(/*descricao*/text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.grupo_produto_pesquisar_listagem(/*descricao*/text) TO postgres WITH GRANT OPTION;;

-- Function: sistema.produto_pesquisar_listagem(/*descricao*/text,/*grupo_produto*/text,/*fornecedor*/text,/*unidade*/text)

-- DROP FUNCTION sistema.produto_pesquisar_listagem(/*descricao*/text,/*grupo_produto*/text,/*fornecedor*/text,/*unidade*/text);

CREATE OR REPLACE FUNCTION sistema.produto_pesquisar_listagem(/*descricao*/text,/*grupo_produto*/text,/*fornecedor*/text,/*unidade*/text)
RETURNS TABLE(id bigint, descricao text, grupo_produto text, fornecedor text, unidade text) AS
$BODY$
BEGIN
	RETURN query
	SELECT
		produto_listagem_view.id,
		produto_listagem_view.descricao,
		produto_listagem_view.grupo_produto,
		produto_listagem_view.fornecedor,
		produto_listagem_view.unidade
	FROM sistema.produto_listagem_view
	WHERE
		(upper(produto_listagem_view.descricao) like upper($1)) or
		(upper(produto_listagem_view.grupo_produto) like upper($2)) or
		(upper(produto_listagem_view.fornecedor) like upper($3)) or
		(upper(produto_listagem_view.unidade) like upper($4))
	ORDER BY produto_listagem_view.descricao LIMIT 10;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.produto_pesquisar_listagem(/*descricao*/text,/*grupo_produto*/text,/*fornecedor*/text,/*unidade*/text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.produto_pesquisar_listagem(/*descricao*/text,/*grupo_produto*/text,/*fornecedor*/text,/*unidade*/text) TO postgres WITH GRANT OPTION;;

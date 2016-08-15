-- Function: sistema.fornecedor_pesquisar_listagem(/*nome_fantasia*/text,/*razao_social*/text,/*cnpj_cpf*/text)

-- DROP FUNCTION sistema.fornecedor_pesquisar_listagem(/*nome_fantasia*/text,/*razao_social*/text,/*cnpj_cpf*/text);

CREATE OR REPLACE FUNCTION sistema.fornecedor_pesquisar_listagem(/*nome_fantasia*/text,/*razao_social*/text,/*cnpj_cpf*/text)
RETURNS TABLE(id bigint, nome_fantasia text, razao_social text, tipo_pessoa text, cnpj_cpf text) AS
$BODY$
BEGIN
	RETURN query
	SELECT
		fornecedor_listagem_view.id,
		fornecedor_listagem_view.nome_fantasia,
		fornecedor_listagem_view.razao_social,
		case when fornecedor_listagem_view.tipo_pessoa = 0
		then 'Pessoa Fisica'
		else 'Pessoa Juridica' end as tipo_pessoa,
		fornecedor_listagem_view.cnpj_cpf
	FROM sistema.fornecedor_listagem_view
	WHERE
		(upper(fornecedor_listagem_view.nome_fantasia) like upper($1)) or
		(upper(fornecedor_listagem_view.razao_social) like upper($2)) or
		(upper(fornecedor_listagem_view.cnpj_cpf) like upper($3))
	ORDER BY fornecedor_listagem_view.nome_fantasia LIMIT 10;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.fornecedor_pesquisar_listagem(/*nome_fantasia*/text,/*razao_social*/text,/*cnpj_cpf*/text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.fornecedor_pesquisar_listagem(/*nome_fantasia*/text,/*razao_social*/text,/*cnpj_cpf*/text) TO postgres WITH GRANT OPTION;;

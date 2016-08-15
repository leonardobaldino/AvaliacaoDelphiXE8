-- Function: sistema.fornecedor_update(/*1-camponome*/ text, /*2-nome_fantasia*/text, /*3-razao_social*/text, /*4-tipo_pessoa*/integer, /*5-cnpj_cpf*/text, /*6-iseditando*/boolean, /*7-id*/ bigint, /*8-logotipo_id*/bigint)

-- DROP FUNCTION sistema.fornecedor_update(/*1-camponome*/ text, /*2-nome_fantasia*/text, /*3-razao_social*/text, /*4-tipo_pessoa*/integer, /*5-cnpj_cpf*/text, /*6-iseditando*/boolean, /*7-id*/ bigint, /*8-logotipo_id*/bigint);

CREATE OR REPLACE FUNCTION sistema.fornecedor_update(/*1-camponome*/ text, /*2-nome_fantasia*/text, /*3-razao_social*/text, /*4-tipo_pessoa*/integer, /*5-cnpj_cpf*/text, /*6-iseditando*/boolean, /*7-id*/ bigint, /*8-logotipo_id*/bigint)
  RETURNS bigint AS
$BODY$
BEGIN

    	if $1 = 'nome_fantasia' then
	begin
		UPDATE sistema.fornecedor SET nome_fantasia=$2 WHERE id=$7;
	end;
	end if;


    	if $1 = 'razao_social' then
	begin
		UPDATE sistema.fornecedor SET razao_social=$3 WHERE id=$7;
	end;
	end if;


    	if $1 = 'tipo_pessoa' then
	begin
		UPDATE sistema.fornecedor SET tipo_pessoa=$4 WHERE id=$7;
	end;
	end if;


    	if $1 = 'cnpj_cpf' then
	begin
		UPDATE sistema.fornecedor SET cnpj_cpf=$5 WHERE id=$7;
	end;
	end if;


	if $1 = 'logotipo_id' then
	begin
		UPDATE sistema.fornecedor SET logotipo_id=$8 WHERE id=$7;
	end;
	end if;


	if $1 = 'iseditando' then
	begin
		UPDATE sistema.fornecedor SET iseditando=$6 WHERE id=$7;
	end;
	end if;

	RETURN 1;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.fornecedor_update(/*1-camponome*/ text, /*2-nome_fantasia*/text, /*3-razao_social*/text, /*4-tipo_pessoa*/integer, /*5-cnpj_cpf*/text, /*6-iseditando*/boolean, /*7-id*/ bigint, /*8-logotipo_id*/bigint)
  OWNER TO postgres;

GRANT EXECUTE ON FUNCTION sistema.fornecedor_update(/*1-camponome*/ text, /*2-nome_fantasia*/text, /*3-razao_social*/text, /*4-tipo_pessoa*/integer, /*5-cnpj_cpf*/text, /*6-iseditando*/boolean, /*7-id*/ bigint, /*8-logotipo_id*/bigint) TO postgres WITH GRANT OPTION;

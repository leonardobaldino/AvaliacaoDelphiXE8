-- Function: sistema.produto_update(/*1-camponome*/ text, /*2-descricao*/text, /*3-grupo_id*/bigint, /*4-fornecedor_id*/bigint, /*5-valor_unitario*/numeric(20,2), /*6-qtde_estoque*/numeric(20,3), /*7-unidade*/ text, /*8-iseditando*/boolean, /*9-id*/bigint)

-- DROP FUNCTION sistema.produto_update(/*1-camponome*/ text, /*2-descricao*/text, /*3-grupo_id*/bigint, /*4-fornecedor_id*/bigint, /*5-valor_unitario*/numeric(20,2), /*6-qtde_estoque*/numeric(20,3), /*7-unidade*/ text, /*8-iseditando*/boolean, /*9-id*/bigint);

CREATE OR REPLACE FUNCTION sistema.produto_update(/*1-camponome*/ text, /*2-descricao*/text, /*3-grupo_id*/bigint, /*4-fornecedor_id*/bigint, /*5-valor_unitario*/numeric(20,2), /*6-qtde_estoque*/numeric(20,3), /*7-unidade*/ text, /*8-iseditando*/boolean, /*9-id*/bigint)
  RETURNS bigint AS
$BODY$
BEGIN

    	if $1 = 'descricao' then
	begin
		UPDATE sistema.produto SET descricao=$2 WHERE id=$9;
	end;
	end if;


    	if $1 = 'grupo_id' then
	begin
		UPDATE sistema.produto SET grupo_id=$3 WHERE id=$9;
	end;
	end if;


    	if $1 = 'fornecedor_id' then
	begin
		UPDATE sistema.produto SET fornecedor_id=$4 WHERE id=$9;
	end;
	end if;


    	if $1 = 'valor_unitario' then
	begin
		UPDATE sistema.produto SET valor_unitario=$5 WHERE id=$9;
	end;
	end if;


	if $1 = 'qtde_estoque' then
	begin
		UPDATE sistema.produto SET qtde_estoque=$6 WHERE id=$9;
	end;
	end if;


	if $1 = 'unidade' then
	begin
		UPDATE sistema.produto SET unidade=$7 WHERE id=$9;
	end;
	end if;


	if $1 = 'iseditando' then
	begin
		UPDATE sistema.produto SET iseditando=$8 WHERE id=$9;
	end;
	end if;

	RETURN 1;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.produto_update(/*1-camponome*/ text, /*2-descricao*/text, /*3-grupo_id*/bigint, /*4-fornecedor_id*/bigint, /*5-valor_unitario*/numeric(20,2), /*6-qtde_estoque*/numeric(20,3), /*7-unidade*/ text, /*8-iseditando*/boolean, /*9-id*/bigint)
  OWNER TO postgres;

GRANT EXECUTE ON FUNCTION sistema.produto_update(/*1-camponome*/ text, /*2-descricao*/text, /*3-grupo_id*/bigint, /*4-fornecedor_id*/bigint, /*5-valor_unitario*/numeric(20,2), /*6-qtde_estoque*/numeric(20,3), /*7-unidade*/ text, /*8-iseditando*/boolean, /*9-id*/bigint) TO postgres WITH GRANT OPTION;

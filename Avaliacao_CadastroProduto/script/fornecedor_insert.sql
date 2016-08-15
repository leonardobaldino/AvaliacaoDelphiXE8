-- Function: sistema.fornecedor_insert(text,text,integer,text)

-- DROP FUNCTION sistema.fornecedor_insert(text,text,integer,text);

CREATE OR REPLACE FUNCTION sistema.fornecedor_insert(text,text,integer,text)
  RETURNS bigint AS
$BODY$
	DECLARE retorno BIGINT;
BEGIN
	retorno = 0;
	INSERT INTO sistema.fornecedor
	(nome_fantasia,razao_social,tipo_pessoa,cnpj_cpf,iseditando,dtinsert,isdelete)
	 VALUES 
	($1,$2,$3,$4,true,now(),false)
	RETURNING id INTO retorno;
	RETURN retorno;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.fornecedor_insert(text,text,integer,text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION sistema.fornecedor_insert(text,text,integer,text) TO postgres WITH GRANT OPTION;;

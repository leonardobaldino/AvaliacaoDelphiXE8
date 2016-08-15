-- Function: sistema.grupo_produto_update(/*1-camponome*/ text, /*2*/text, /*3*/boolean, /*4-id*/ bigint)

-- DROP FUNCTION sistema.grupo_produto_update(/*1-camponome*/ text, /*2*/text, /*3*/boolean, /*4-id*/ bigint);

CREATE OR REPLACE FUNCTION sistema.grupo_produto_update(/*1-camponome*/ text, /*2*/text, /*3*/boolean, /*4-id*/ bigint)
  RETURNS bigint AS
$BODY$
BEGIN

	if $1 = 'descricao' then
	begin
		UPDATE sistema.grupo_produto SET descricao=$2 WHERE id=$4;
	end;
	end if;


	if $1 = 'iseditando' then
	begin
		UPDATE sistema.grupo_produto SET iseditando=$3 WHERE id=$4;
	end;
	end if;

	RETURN 1;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION sistema.grupo_produto_update(/*1-camponome*/ text, /*2*/text, /*3*/boolean, /*4-id*/ bigint)
  OWNER TO postgres;

GRANT EXECUTE ON FUNCTION sistema.grupo_produto_update(/*1-camponome*/ text, /*2*/text, /*3*/boolean, /*4-id*/ bigint) TO postgres WITH GRANT OPTION;

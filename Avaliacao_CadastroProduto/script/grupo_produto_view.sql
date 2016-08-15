-- View: sistema.grupo_produto_view

-- DROP VIEW sistema.grupo_produto_view;

CREATE OR REPLACE VIEW sistema.grupo_produto_view AS 
 SELECT grupo_produto.id,
    grupo_produto.descricao
   FROM sistema.grupo_produto
  WHERE grupo_produto.isdelete = false;

ALTER TABLE sistema.grupo_produto_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.grupo_produto_view TO postgres;

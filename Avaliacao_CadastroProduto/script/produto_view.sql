-- View: sistema.produto_view

-- DROP VIEW sistema.produto_view;

CREATE OR REPLACE VIEW sistema.produto_view AS 
 SELECT produto.id,
    produto.descricao,
    produto.grupo_id,
    produto.fornecedor_id,
    produto.valor_unitario,
    produto.qtde_estoque,
    produto.unidade,
    produto.iseditando
   FROM sistema.produto
  WHERE produto.isdelete = false;

ALTER TABLE sistema.produto_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.produto_view TO postgres;

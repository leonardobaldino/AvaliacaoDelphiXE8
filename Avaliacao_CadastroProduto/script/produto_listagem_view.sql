-- View: sistema.produto_listagem_view

-- DROP VIEW sistema.produto_listagem_view;

CREATE OR REPLACE VIEW sistema.produto_listagem_view AS 
 SELECT produto_view.id,
    produto_view.descricao,
    produto_view.grupo_id,
    grupo_produto_view.descricao as grupo_produto,
    produto_view.fornecedor_id,
    fornecedor_view.nome_fantasia as fornecedor,
    produto_view.valor_unitario,
    produto_view.unidade,
    produto_view.qtde_estoque    
   FROM sistema.produto_view
   Left Join sistema.fornecedor_view on fornecedor_view.id = produto_view.fornecedor_id
   Left Join sistema.grupo_produto_view on grupo_produto_view.id = produto_view.grupo_id
  ORDER BY produto_view.grupo_id;

ALTER TABLE sistema.produto_listagem_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.produto_listagem_view TO postgres;

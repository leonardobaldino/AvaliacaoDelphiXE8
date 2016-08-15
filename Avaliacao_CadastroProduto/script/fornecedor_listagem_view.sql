-- View: sistema.fornecedor_listagem_view

-- DROP VIEW sistema.fornecedor_listagem_view;

CREATE OR REPLACE VIEW sistema.fornecedor_listagem_view AS 
 SELECT fornecedor_view.id,
    fornecedor_view.nome_fantasia,
    fornecedor_view.razao_social,
    fornecedor_view.tipo_pessoa,
    fornecedor_view.cnpj_cpf,
    fornecedor_view.logotipo_id    
   FROM sistema.fornecedor_view
  ORDER BY fornecedor_view.nome_fantasia;

ALTER TABLE sistema.fornecedor_listagem_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.fornecedor_listagem_view TO postgres;

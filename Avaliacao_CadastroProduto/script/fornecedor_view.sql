-- View: sistema.fornecedor_view

-- DROP VIEW sistema.fornecedor_view;

CREATE OR REPLACE VIEW sistema.fornecedor_view AS 
 SELECT fornecedor.id,
    fornecedor.nome_fantasia,
    fornecedor.razao_social,
    fornecedor.tipo_pessoa,
    fornecedor.cnpj_cpf,
    fornecedor.logotipo_id,
    fornecedor.iseditando
   FROM sistema.fornecedor
  WHERE fornecedor.isdelete = false;

ALTER TABLE sistema.fornecedor_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.fornecedor_view TO postgres;

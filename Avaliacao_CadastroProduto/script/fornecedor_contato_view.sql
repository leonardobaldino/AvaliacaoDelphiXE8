-- View: sistema.fornecedor_contato_view

-- DROP VIEW sistema.fornecedor_contato_view;

CREATE OR REPLACE VIEW sistema.fornecedor_contato_view AS 
 SELECT contato_view.id,
    contato_view.tipocontato_id,
    contato_view.valor,
    contato_view.adicional,
    fornecedor_contato.fornecedor_id,
    tipocontato_view.descricao as tipocontato
   FROM sistema.contato_view
     JOIN sistema.fornecedor_contato ON fornecedor_contato.contato_id = contato_view.id
     LEFT JOIN sistema.tipocontato_view ON tipocontato_view.id = contato_view.tipocontato_id          
  WHERE fornecedor_contato.isdelete = false;

ALTER TABLE sistema.fornecedor_contato_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.fornecedor_contato_view TO postgres;

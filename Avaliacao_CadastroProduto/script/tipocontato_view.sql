-- View: sistema.tipocontato_view

-- DROP VIEW sistema.tipocontato_view;

CREATE OR REPLACE VIEW sistema.tipocontato_view AS 
 SELECT tipocontato.id,
    tipocontato.descricao,
    tipocontato.imagem
   FROM sistema.tipocontato
  WHERE tipocontato.isdelete = false;

ALTER TABLE sistema.tipocontato_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.tipocontato_view TO postgres;

-- View: sistema.modulo_view

-- DROP VIEW sistema.modulo_view;

CREATE OR REPLACE VIEW sistema.modulo_view AS 
 SELECT modulo.id,
    modulo.nome,
    modulo.descricao,
    modulo.tela
   FROM sistema.modulo
  WHERE modulo.isdelete = false;

ALTER TABLE sistema.modulo_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.modulo_view TO postgres;

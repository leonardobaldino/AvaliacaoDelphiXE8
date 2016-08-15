-- View: sistema.grupo_view

-- DROP VIEW sistema.grupo_view;

CREATE OR REPLACE VIEW sistema.grupo_view AS 
 SELECT grupo.id,
    grupo.nome,
    grupo.descricao
   FROM sistema.grupo
  WHERE grupo.isdelete = false;

ALTER TABLE sistema.grupo_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.grupo_view TO postgres;

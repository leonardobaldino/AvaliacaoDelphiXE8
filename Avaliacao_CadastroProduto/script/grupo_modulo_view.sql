-- View: sistema.grupo_modulo_view

-- DROP VIEW sistema.grupo_modulo_view;

CREATE OR REPLACE VIEW sistema.grupo_modulo_view AS 
 SELECT grupo_modulo.id,
    grupo_modulo.grupo_id,
    grupo_view.nome AS grupo_nome,
    grupo_modulo.modulo_id,
    modulo_view.nome AS modulo_nome,
    modulo_view.tela AS modulo_tela
   FROM sistema.grupo_modulo
     JOIN sistema.grupo_view ON grupo_view.id = grupo_modulo.grupo_id
     JOIN sistema.modulo_view ON modulo_view.id = grupo_modulo.modulo_id
  WHERE grupo_modulo.isdelete = false;

ALTER TABLE sistema.grupo_modulo_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.grupo_modulo_view TO postgres;

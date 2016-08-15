-- View: sistema.usuario_grupo_view

-- DROP VIEW sistema.usuario_grupo_view;

CREATE OR REPLACE VIEW sistema.usuario_grupo_view AS 
 SELECT usuario_grupo.id,
    usuario_grupo.usuario_id,
    usuario_grupo.grupo_id,
    grupo_view.nome AS grupo_nome
   FROM sistema.usuario_grupo
     JOIN sistema.grupo_view ON grupo_view.id = usuario_grupo.grupo_id
  WHERE usuario_grupo.isdelete = false;

ALTER TABLE sistema.usuario_grupo_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.usuario_grupo_view TO postgres;

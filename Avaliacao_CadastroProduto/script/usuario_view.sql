-- View: sistema.usuario_view

-- DROP VIEW sistema.usuario_view;

CREATE OR REPLACE VIEW sistema.usuario_view AS 
 SELECT usuario.id,
    usuario.colaborador_id,
    usuario.usuario_nome,
    usuario.usuario_senha,
    usuario.iseditando
   FROM sistema.usuario
  WHERE usuario.isdelete = false;

ALTER TABLE sistema.usuario_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.usuario_view TO postgres;

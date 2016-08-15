-- View: sistema.usuario_listagem_view

-- DROP VIEW sistema.usuario_listagem_view;

CREATE OR REPLACE VIEW sistema.usuario_listagem_view AS 
 SELECT usuario_view.id,
    usuario_view.colaborador_id,
    colaborador_view.nomeapresentado as colaborador,
    usuario_view.usuario_nome,
    usuario_view.usuario_senha
   FROM sistema.usuario_view
   INNER JOIN sistema.colaborador_view on colaborador_view.id = usuario_view.colaborador_id;

ALTER TABLE sistema.usuario_listagem_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.usuario_listagem_view TO postgres;

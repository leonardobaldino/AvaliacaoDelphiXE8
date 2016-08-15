-- View: sistema.imagem_view

-- DROP VIEW sistema.imagem_view;

CREATE OR REPLACE VIEW sistema.imagem_view AS 
 SELECT imagem.id,
    imagem.arquivo
   FROM sistema.imagem
  WHERE imagem.isdelete = false;

ALTER TABLE sistema.imagem_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.imagem_view TO postgres;

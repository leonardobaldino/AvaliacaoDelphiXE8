-- View: sistema.contato_view

-- DROP VIEW sistema.contato_view;

CREATE OR REPLACE VIEW sistema.contato_view AS 
 SELECT contato.id,
    contato.tipocontato_id,
    contato.valor,
    contato.adicional
   FROM sistema.contato
  WHERE contato.isdelete = false;

ALTER TABLE sistema.contato_view
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.contato_view TO postgres;

-- Table: sistema.tipocontato

-- DROP TABLE sistema.tipocontato;

CREATE TABLE sistema.tipocontato
(
  id bigserial NOT NULL,
  descricao text,
  imagem text,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT tipocontato_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.tipocontato
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.tipocontato TO postgres;

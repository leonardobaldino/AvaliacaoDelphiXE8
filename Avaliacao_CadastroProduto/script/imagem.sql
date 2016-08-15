-- Table: sistema.imagem

-- DROP TABLE sistema.imagem;

CREATE TABLE sistema.imagem
(
  id bigserial NOT NULL,
  arquivo text,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT imagem_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.imagem
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.imagem TO postgres;

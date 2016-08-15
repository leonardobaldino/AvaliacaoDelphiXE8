-- Table: sistema.modulo

-- DROP TABLE sistema.modulo;

CREATE TABLE sistema.modulo
(
  id bigserial NOT NULL,
  nome text,
  descricao text,
  tela text,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT modulo_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.modulo
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.modulo TO postgres;

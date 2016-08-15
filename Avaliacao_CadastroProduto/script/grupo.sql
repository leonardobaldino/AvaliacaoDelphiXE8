-- Table: sistema.grupo

-- DROP TABLE sistema.grupo;

CREATE TABLE sistema.grupo
(
  id bigserial NOT NULL,
  nome text,
  descricao text,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT grupo_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.grupo
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.grupo TO postgres;

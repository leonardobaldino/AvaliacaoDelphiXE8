-- Table: sistema.grupo_modulo

-- DROP TABLE sistema.grupo_modulo;

CREATE TABLE sistema.grupo_modulo
(
  id bigserial NOT NULL,
  grupo_id bigint NOT NULL,
  modulo_id  bigint NOT NULL,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT grupo_modulo_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.grupo_modulo
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.grupo_modulo TO postgres;


-- Table: sistema.usuario_grupo

-- DROP TABLE sistema.usuario_grupo;

CREATE TABLE sistema.usuario_grupo
(
  id bigserial NOT NULL,
  usuario_id bigint NOT NULL,
  grupo_id  bigint NOT NULL,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT usuario_grupo_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.usuario_grupo
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.usuario_grupo TO postgres;

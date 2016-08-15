-- Table: sistema.usuario

-- DROP TABLE sistema.usuario;

CREATE TABLE sistema.usuario
(
  id bigserial NOT NULL,
  colaborador_id bigint NOT NULL,
  usuario_nome text,
  usuario_senha text,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  iseditando boolean,
  CONSTRAINT usuario_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.usuario
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.usuario TO postgres;

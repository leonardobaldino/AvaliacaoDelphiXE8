-- Table: sistema.contato

-- DROP TABLE sistema.contato;

CREATE TABLE sistema.contato
(
  id bigserial NOT NULL,
  tipocontato_id bigint,
  valor text,
  adicional text,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT contato_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.contato
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.contato TO postgres;

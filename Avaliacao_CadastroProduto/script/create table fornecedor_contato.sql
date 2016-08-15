-- Table: sistema.fornecedor_contato

-- DROP TABLE sistema.fornecedor_contato;

CREATE TABLE sistema.fornecedor_contato
(
  id bigserial NOT NULL,
  fornecedor_id bigint,
  contato_id bigint,
  dtinsert timestamp,
  usuario_id_insert bigint not null,
  dtupdate timestamp,
  usuario_id_update bigint,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT fornecedor_contato_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.fornecedor_contato
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.fornecedor_contato TO postgres;

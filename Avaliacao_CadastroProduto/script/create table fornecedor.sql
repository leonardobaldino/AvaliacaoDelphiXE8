-- Table: sistema.fornecedor

-- DROP TABLE sistema.fornecedor;

CREATE TABLE sistema.fornecedor
(
  id bigserial NOT NULL,
  nome_fantasia text,
  razao_social text,
  tipo_pessoa int,
  cnpj_cpf text,
  logotipo_id bigint,
  iseditando boolean,
  dtinsert timestamp,
  dtupdate timestamp,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT fornecedor_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.fornecedor
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.fornecedor TO postgres;


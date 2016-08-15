-- Table: sistema.produto

-- DROP TABLE sistema.produto;

CREATE TABLE sistema.produto
(
  id bigserial NOT NULL,
  descricao text,
  grupo_id bigint,
  fornecedor_id bigint,
  valor_unitario numeric(20,2),
  qtde_estoque numeric(20,3),
  unidade text,
  dtinsert timestamp,
  dtupdate timestamp,
  dtdelete timestamp,
  isdelete boolean,
  iseditando boolean,
  CONSTRAINT produto_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.produto
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.produto TO postgres;


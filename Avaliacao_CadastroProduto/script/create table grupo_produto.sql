-- Table: sistema.grupo_produto

-- DROP TABLE sistema.grupo_produto;

CREATE TABLE sistema.grupo_produto
(
  id bigserial NOT NULL,
  descricao text,
  dtinsert timestamp,
  dtupdate timestamp,
  dtdelete timestamp,
  isdelete boolean,
  CONSTRAINT grupo_produto_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sistema.grupo_produto
  OWNER TO postgres;
GRANT ALL ON TABLE sistema.grupo_produto TO postgres;


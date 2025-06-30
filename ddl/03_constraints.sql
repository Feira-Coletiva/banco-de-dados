-- PRIMARY KEYS
ALTER TABLE categorias
ADD CONSTRAINT pk_categoria PRIMARY KEY (id);

ALTER TABLE clientes
ADD CONSTRAINT pk_cliente PRIMARY KEY (id);

ALTER TABLE vendedores
ADD CONSTRAINT pk_vendedor PRIMARY KEY (id);

ALTER TABLE ofertas
ADD CONSTRAINT pk_oferta PRIMARY KEY (id);

ALTER TABLE produtos
ADD CONSTRAINT pk_produto PRIMARY KEY (id);

-- FOREIGN KEYS
ALTER TABLE ofertas
ADD CONSTRAINT fk_oferta_vendedor FOREIGN KEY (id_vendedor)
REFERENCES vendedores(id);

ALTER TABLE produtos
ADD CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria)
REFERENCES categorias(id);

ALTER TABLE produtos
ADD CONSTRAINT fk_produto_oferta FOREIGN KEY (id_oferta)
REFERENCES ofertas(id)
ON DELETE CASCADE
ON UPDATE CASCADE;




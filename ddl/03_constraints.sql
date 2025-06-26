-- PRIMARY KEYS
ALTER TABLE categoria
ADD CONSTRAINT pk_categoria PRIMARY KEY (id);

ALTER TABLE clientes
ADD CONSTRAINT pk_cliente PRIMARY KEY (id);

ALTER TABLE vendedores
ADD CONSTRAINT pk_vendedor PRIMARY KEY (id_cliente);

ALTER TABLE ofertas
ADD CONSTRAINT pk_oferta PRIMARY KEY (id);

ALTER TABLE produtos
ADD CONSTRAINT pk_produto PRIMARY KEY (id);

-- FOREIGN KEYS
ALTER TABLE vendedores
ADD CONSTRAINT fk_vendedor_cliente FOREIGN KEY (id_cliente)
REFERENCES clientes(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE ofertas
ADD CONSTRAINT fk_oferta_vendedor FOREIGN KEY (id_vendedor)
REFERENCES vendedores(id_cliente);

ALTER TABLE produtos
ADD CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria)
REFERENCES oferta(id);

ALTER TABLE produtos
ADD CONSTRAINT fk_produto_oferta FOREIGN KEY (id_oferta)
REFERENCES oferta(id)
ON DELETE CASCADE
ON UPDATE CASCADE;




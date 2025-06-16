-- PRIMARY KEYS
ALTER TABLE produtos
ADD CONSTRAINT pk_produto PRIMARY KEY (id);

ALTER TABLE clientes
ADD CONSTRAINT pk_cliente PRIMARY KEY (id);

ALTER TABLE vendedores
ADD CONSTRAINT pk_vendedor PRIMARY KEY (id_cliente);

ALTER TABLE ofertas
ADD CONSTRAINT pk_oferta PRIMARY KEY (id);

ALTER TABLE publicacoes
ADD CONSTRAINT pk_publicacao PRIMARY KEY (id);

ALTER TABLE compras_coletivas
ADD CONSTRAINT pk_comp_coletiva PRIMARY KEY (id);

ALTER TABLE participantes
ADD CONSTRAINT pk_participantes PRIMARY KEY (id);

-- FOREIGN KEYS
ALTER TABLE vendedores
ADD CONSTRAINT fk_vendedor_cliente FOREIGN KEY (id_cliente)
REFERENCES clientes(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE ofertas
ADD CONSTRAINT fk_oferta_vendedor FOREIGN KEY (id_vendedor)
REFERENCES vendedores(id_cliente);

ALTER TABLE ofertas
ADD CONSTRAINT fk_oferta_produto FOREIGN KEY (id_produto)
REFERENCES produtos(id);

ALTER TABLE publicacoes
ADD CONSTRAINT fk_public_oferta FOREIGN KEY (id_oferta)
REFERENCES ofertas(id);

ALTER TABLE compras_coletivas
ADD CONSTRAINT fk_comp_public FOREIGN KEY (id_publicacao)
REFERENCES publicacoes(id);

ALTER TABLE participantes
ADD CONSTRAINT fk_part_comp FOREIGN KEY (id_comp_coletiva)
REFERENCES compras_coletivas(id);

ALTER TABLE participantes
ADD CONSTRAINT fk_part_cliente FOREIGN KEY (id_cliente)
REFERENCES clientes(id);

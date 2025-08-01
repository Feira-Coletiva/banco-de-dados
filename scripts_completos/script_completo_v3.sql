-- Create Schema ---------------------------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS sistema_feira_coletiva_v3; 
USE sistema_feira_coletiva_v3; 

-- Create Tables ---------------------------------------------------------------------------------------------

-- Tabela Categorias
CREATE TABLE IF NOT EXISTS categorias (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    CONSTRAINT pk_categoria 
    	PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Tabela Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senha VARCHAR(150) NOT NULL,
    CONSTRAINT pk_cliente 
		PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Tabela Vendedores
CREATE TABLE IF NOT EXISTS vendedores (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senha VARCHAR(150) NOT NULL,
    rg INT NOT NULL,
    cep VARCHAR(150) NOT NULL,
    chave_pix VARCHAR(50) NOT NULL,
    CONSTRAINT pk_vendedor 
    	PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Tabela Ofertas
CREATE TABLE IF NOT EXISTS ofertas (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    qtd_estoque_total INT NOT NULL,
    status_disponibilidade BOOLEAN NOT NULL, -- Pode ser ENUM('DISPONIVEL','INDISPONIVEL') NOT NULL DEFAULT 'DISPONIVEL',
    id_vendedor INT NOT NULL,
    CONSTRAINT pk_oferta 
    	PRIMARY KEY (id),
    CONSTRAINT fk_oferta_vendedor 
    	FOREIGN KEY (id_vendedor)
		REFERENCES vendedores(id)
) ENGINE=InnoDB;

-- Table Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    unidade_medida ENUM('KG', 'ML', 'UN') NOT NULL DEFAULT 'KG',
    medida DECIMAL(10,2) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    qtd_estoque INT NOT NULL,
    id_categoria INT NOT NULL,
    id_oferta INT NOT NULL,
    CONSTRAINT pk_produto
		PRIMARY KEY (id),
	CONSTRAINT fk_produto_categoria 
		FOREIGN KEY (id_categoria)
		REFERENCES categorias(id),
	CONSTRAINT fk_produto_oferta 
		FOREIGN KEY (id_oferta)
		REFERENCES ofertas(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table Locais De Retirada
CREATE TABLE IF NOT EXISTS locais_de_retirada (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cep VARCHAR(150) NOT NULL,
    CONSTRAINT pk_local_de_retirada
		PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Table Publicações
CREATE TABLE IF NOT EXISTS publicacoes (
    id INT NOT NULL AUTO_INCREMENT,
    dt_final_exposicao DATE NOT NULL,
    dt_final_pagamento DATE NOT NULL,
    id_local_de_retirada INT NOT NULL,
    id_oferta INT NOT NULL,
    CONSTRAINT pk_publicacao
		PRIMARY KEY (id),
	CONSTRAINT fk_publicacao_locais_de_retirada
		FOREIGN KEY (id_local_de_retirada)
		REFERENCES locais_de_retirada(id),
	CONSTRAINT fk_publicacao_oferta 
		FOREIGN KEY (id_oferta)
		REFERENCES ofertas(id)
) ENGINE=InnoDB;

-- Table Participantes
CREATE TABLE IF NOT EXISTS participantes(
    id INT NOT NULL auto_increment,
    valor_total DECIMAL(10,2) NOT NULL,
    qtd_total_produtos int NOT NULL,
    status_pago BOOLEAN NOT NULL,
    id_cliente INT NOT NULL,
    id_publicacao INT NOT NULL,
    CONSTRAINT pk_participante
        PRIMARY KEY(id),
    CONSTRAINT fk_participante_cliente
        FOREIGN KEY(id_cliente)
        REFERENCES clientes(id),
    CONSTRAINT fk_participante_publicacao
        FOREIGN KEY(id_publicacao)
        REFERENCES publicacoes(id)
        ON DELETE CASCADE
) engine=InnoDB;

-- Table Pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(300) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    qtd_produto INT NOT NULL,
    id_participante INT NOT NULL,   
    CONSTRAINT pk_pedido
		PRIMARY KEY (id),
	CONSTRAINT fk_pedido_participante 
		FOREIGN KEY (id_participante)
		REFERENCES participantes(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Create Schema ---------------------------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS sistema_feira_coletiva; 
USE sistema_feira_coletiva; 

-- Create Tables ---------------------------------------------------------------------------------------------

# Tabela Categorias
CREATE TABLE IF NOT EXISTS categorias (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    CONSTRAINT pk_categoria 
    	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senha VARCHAR(150) NOT NULL,
    CONSTRAINT pk_cliente 
		PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS vendedores (
    id_cliente INT NOT NULL,
    RG INT NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    reg_de_atuacao VARCHAR(150) NOT NULL,
    chave_pix VARCHAR(50) NOT NULL,
    CONSTRAINT pk_vendedor 
    	PRIMARY KEY (id_cliente),
    CONSTRAINT fk_vendedor_cliente 
    	FOREIGN KEY (id_cliente)
		REFERENCES clientes(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ofertas (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    disp_status BOOLEAN NOT NULL, -- Pode ser ENUM('DISPONIVEL','INDISPONIVEL') NOT NULL DEFAULT 'DISPONIVEL',
    id_vendedor INT NOT NULL,
    CONSTRAINT pk_oferta 
    	PRIMARY KEY (id),
    CONSTRAINT fk_oferta_vendedor 
    	FOREIGN KEY (id_vendedor)
		REFERENCES vendedores(id_cliente)
) ENGINE=InnoDB;

# Table Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    unidade_medida ENUM('kg', 'ml', 'un') NOT NULL DEFAULT 'kg',
    medida DOUBLE NOT NULL,
    preco DOUBLE NOT NULL,
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



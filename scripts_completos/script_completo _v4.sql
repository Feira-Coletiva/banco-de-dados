-- Create Schema ---------------------------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS sistema_feira_coletiva_v4; 
USE sistema_feira_coletiva_v4; 

-- Create Tables ---------------------------------------------------------------------------------------------

-- Tabela Categorias (Sem alterações de tipo de dado)
CREATE TABLE IF NOT EXISTS categorias (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    CONSTRAINT pk_categoria
    	PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Tabela Clientes (Sem alterações de tipo de dado)
CREATE TABLE IF NOT EXISTS clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senha VARCHAR(150) NOT NULL,
    CONSTRAINT pk_cliente
		PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Tabela Vendedores (Sem alterações de tipo de dado)
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

-- Tabela Ofertas (Sem alterações de tipo de dado diretamente na tabela Ofertas, mas Produto tem)
CREATE TABLE IF NOT EXISTS ofertas (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    qtd_estoque_total INT NOT NULL,
    status_disponibilidade BOOLEAN NOT NULL,
    id_vendedor INT NOT NULL,
    CONSTRAINT pk_oferta
    	PRIMARY KEY (id),
    CONSTRAINT fk_oferta_vendedor
    	FOREIGN KEY (id_vendedor)
		REFERENCES vendedores(id)
) ENGINE=InnoDB;

-- Table Produtos (ALTERADO: preco agora é DECIMAL)
CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    unidade_medida ENUM('KG', 'ML', 'UNIDADE') NOT NULL DEFAULT 'KG', -- Alterado 'UN' para 'UNIDADE' para consistência com o Enum Java
    medida DOUBLE NOT NULL, -- Medida (ex: 0.5kg) pode continuar como DOUBLE ou mudar para DECIMAL se precisar de alta precisão
    preco DECIMAL(10,2) NOT NULL, -- ✅ ALTERADO: preco de DOUBLE para DECIMAL(10,2)
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

-- Table Locais De Retirada (Sem alterações de tipo de dado)
CREATE TABLE IF NOT EXISTS locais_de_retirada (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cep VARCHAR(150) NOT NULL,
    CONSTRAINT pk_locais_de_retirada
		PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Table Publicações (Sem alterações de tipo de dado)
CREATE TABLE IF NOT EXISTS publicacoes (
    id INT NOT NULL AUTO_INCREMENT,
    dt_final_exposicao DATE NOT NULL,
    dt_final_pagamento DATE NOT NULL,
    etapa ENUM('EXPOSICAO', 'PAGAMENTO', 'FINALIZADO', 'INCOMPLETO') NOT NULL DEFAULT 'INCOMPLETO',
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

-- Table Participantes (ALTERADO: valor_total já era DECIMAL, adicionado data_participacao)
CREATE TABLE IF NOT EXISTS participantes(
    id INT NOT NULL auto_increment,
    valor_total DECIMAL(10,2) NOT NULL, -- ✅ Mantido como DECIMAL(10,2)
    qtd_total_produtos INT NOT NULL,
    status_pago BOOLEAN NOT NULL,
    data_participacao DATETIME NOT NULL, -- ✅ NOVO CAMPO: Data e hora da participação
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
) ENGINE=InnoDB;

-- Table Pedidos (ALTERADO: valor renomeado para valor_total_item, adicionado preco_unitario_no_pedido, ambos DECIMAL)
CREATE TABLE IF NOT EXISTS pedidos (
    id INT NOT NULL AUTO_INCREMENT,
    -- A descrição do pedido pode ser gerada a partir do produto, então não é essencial no banco se tiver o id_produto
    -- descricao VARCHAR(300) NOT NULL, -- ✅ REMOVIDO: Descrição pode ser gerada ou produto é suficiente
    id_produto INT NOT NULL, -- ✅ NOVO CAMPO: ID do produto da oferta
    qtd_produto INT NOT NULL,
    preco_unitario_no_pedido DECIMAL(10,2) NOT NULL, -- ✅ NOVO CAMPO: Preço unitário no momento do pedido
    valor_total_item DECIMAL(10,2) NOT NULL, -- ✅ RENOMEADO e mantido como DECIMAL(10,2)
    id_participante INT NOT NULL,
    CONSTRAINT pk_pedido
		PRIMARY KEY (id),
    CONSTRAINT fk_pedido_produto
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id), -- ✅ NOVA FK para a tabela produtos
	CONSTRAINT fk_pedido_participante
		FOREIGN KEY (id_participante)
		REFERENCES participantes(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE=InnoDB;



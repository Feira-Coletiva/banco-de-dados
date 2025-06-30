-- Table Categorias
CREATE TABLE IF NOT EXISTS categorias (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL
) ENGINE=InnoDB;

-- Table Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senha VARCHAR(150) NOT NULL
) ENGINE=InnoDB;

-- Table Vendedores
CREATE TABLE IF NOT EXISTS vendedores (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senha VARCHAR(150) NOT NULL,
    RG INT NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    reg_de_atuacao VARCHAR(150) NOT NULL,
    chave_pix VARCHAR(50) NOT NULL,
) ENGINE=InnoDB;

-- Table Ofertas
CREATE TABLE IF NOT EXISTS ofertas (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    disp_status BOOLEAN NOT NULL, -- Pode ser ENUM('DISPONIVEL','INDISPONIVEL') NOT NULL DEFAULT 'DISPONIVEL',
    id_vendedor INT NOT NULL
) ENGINE=InnoDB;

-- Table Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    unidade_medida ENUM('kg', 'ml', 'un') NOT NULL DEFAULT 'kg',
    medida DOUBLE NOT NULL,
    preco DOUBLE NOT NULL,
    qtd_estoque INT NOT NUL,
    id_categoria INT NOT NULL,
    id_oferta INT NOT NULL
) ENGINE=InnoDB;

# Table para criação de produtos.
# Não reconhece outras tabelas.
CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    categoria ENUM('LEGUMES', 'VERDURAS', 'PROTEINAS', 'OUTROS') NOT NULL DEFAULT 'OUTROS',
    qtd_kg_ml DOUBLE NOT NULL,
    preco_qtd DOUBLE NOT NULL,
    qtd_unidades INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senha VARCHAR(150) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS vendedores (
    id_cliente INT NOT NULL,
    RG INT NOT NULL,
    reg_de_atuacao VARCHAR(150) NOT NULL,
    chave_pix VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ofertas (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    disp_status BOOLEAN NOT NULL,
    id_vendedor INT NOT NULL,
    id_produto INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS publicacoes (
    id INT NOT NULL AUTO_INCREMENT,
    tem_exp DATE NOT NULL,
    tem_paga DATE NOT NULL,
    ent_ou_retirar BOOLEAN,
    enderecao VARCHAR(150) NOT NULL,
    id_oferta INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS compras_coletivas (
    id INT NOT NULL AUTO_INCREMENT,
    etapa_status ENUM('EXPOSICAO', 'PAGAMENTO', 'CANCELADO') NOT NULL DEFAULT 'EXPOSICAO',
    id_publicacao INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS participantes (
    id INT NOT NULL AUTO_INCREMENT,
    enderecao VARCHAR(150) NOT NULL,
    valor_total DOUBLE NOT NULL,
    paga_status BOOLEAN NOT NULL,
    id_comp_coletiva INT NOT NULL,
    id_cliente INT NOT NULL
) ENGINE=InnoDB;
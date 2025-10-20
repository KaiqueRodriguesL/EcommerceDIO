-- Kaique Rodrigues Leme

CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Cliente (
  idCliente INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  tipo ENUM('PF','PJ') NOT NULL
);

CREATE TABLE Produto (
  idProduto INT PRIMARY KEY AUTO_INCREMENT,
  categoria VARCHAR(45),
  nome VARCHAR(100),
  preco DECIMAL(10,2)
);

CREATE TABLE Fornecedor (
  idFornecedor INT PRIMARY KEY AUTO_INCREMENT,
  razao_social VARCHAR(100),
  cnpj VARCHAR(18)
);

CREATE TABLE Estoque (
  idEstoque INT PRIMARY KEY AUTO_INCREMENT,
  local VARCHAR(45)
);

CREATE TABLE Terceiro_Vendedor (
  idTerceiro INT PRIMARY KEY AUTO_INCREMENT,
  razao_social VARCHAR(100),
  local VARCHAR(45)
);


CREATE TABLE Disponibiliza_Produto (
  Fornecedor_idFornecedor INT,
  Produto_idProduto INT,
  PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
  FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Produto_has_Estoque (
  Produto_idProduto INT,
  Estoque_idEstoque INT,
  quantidade INT,
  PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
  FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE Produtos_por_Vendedor (
  Terceiro_Vendedor_idTerceiro INT,
  Produto_idProduto INT,
  quantidade INT,
  PRIMARY KEY (Terceiro_Vendedor_idTerceiro, Produto_idProduto),
  FOREIGN KEY (Terceiro_Vendedor_idTerceiro) REFERENCES Terceiro_Vendedor(idTerceiro),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);


CREATE TABLE Cliente_PF (
  idCliente INT PRIMARY KEY,
  cpf VARCHAR(14) UNIQUE,
  data_nascimento DATE,
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Cliente_PJ (
  idCliente INT PRIMARY KEY,
  cnpj VARCHAR(18) UNIQUE,
  razao_social VARCHAR(100),
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Pedido (
  idPedido INT PRIMARY KEY AUTO_INCREMENT,
  Cliente_idCliente INT,
  data_pedido DATE,
  status ENUM('PENDENTE','PROCESSANDO','ENVIADO','ENTREGUE','CANCELADO') DEFAULT 'PENDENTE',
  codigo_rastreio VARCHAR(50),
  FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Pagamento (
  idPagamento INT PRIMARY KEY AUTO_INCREMENT,
  Pedido_idPedido INT,
  forma_pagamento ENUM('CARTAO','BOLETO','PIX','DINHEIRO'),
  valor DECIMAL(10,2),
  data_pagamento DATE,
  FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

-- Itens do Pedido (N:N)
CREATE TABLE Itens_Pedido (
  Pedido_idPedido INT,
  Produto_idProduto INT,
  quantidade INT,
  preco_unitario DECIMAL(10,2),
  PRIMARY KEY (Pedido_idPedido, Produto_idProduto),
  FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
  FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);


-- Dados para Teste

-- Vendedores
INSERT INTO Terceiro_Vendedor (razao_social, local) VALUES
('Vendedor A','São Paulo'),
('Vendedor B','Rio de Janeiro');

-- Fornecedores
INSERT INTO Fornecedor (razao_social, cnpj) VALUES
('Fornecedor X','12.345.678/0001-90'),
('Fornecedor Y','98.765.432/0001-10');

-- Estoques
INSERT INTO Estoque (local) VALUES
('Estoque Centro'),
('Estoque Sul');

-- Produtos
INSERT INTO Produto (categoria, nome, preco) VALUES
('Eletrônicos','Smartphone XYZ',1500.00),
('Eletrônicos','Notebook ABC',3500.00),
('Moda','Camisa Polo',120.00);

-- Disponibiliza Produto
INSERT INTO Disponibiliza_Produto VALUES
(1,1),
(1,2),
(2,3);

-- Produto_has_Estoque
INSERT INTO Produto_has_Estoque VALUES
(1,1,50),
(2,1,20),
(3,2,100);

-- Produtos por Vendedor
INSERT INTO Produtos_por_Vendedor VALUES
(1,1,10),
(2,3,5);

-- Clientes
INSERT INTO Cliente (nome,email,tipo) VALUES
('João Silva','joao@email.com','PF'),
('Empresa XYZ','contato@xyz.com','PJ');

INSERT INTO Cliente_PF VALUES
(1,'123.456.789-00','1985-05-20');

INSERT INTO Cliente_PJ VALUES
(2,'12.345.678/0001-90','Empresa XYZ');

-- Pedidos
INSERT INTO Pedido (Cliente_idCliente,data_pedido,status,codigo_rastreio) VALUES
(1,'2025-10-01','ENVIADO','BR123456789'),
(2,'2025-10-05','PROCESSANDO','BR987654321');

-- Pagamentos
INSERT INTO Pagamento (Pedido_idPedido,forma_pagamento,valor,data_pagamento) VALUES
(1,'CARTAO',1500.00,'2025-10-01'),
(2,'PIX',3500.00,'2025-10-05');

-- Itens Pedido
INSERT INTO Itens_Pedido VALUES
(1,1,1,1500.00),
(2,2,1,3500.00);

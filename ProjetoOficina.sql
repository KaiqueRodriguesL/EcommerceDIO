-- Kaique Rodrigues Leme

CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;


CREATE TABLE Cliente (
  idCliente INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  tipo ENUM('PF','PJ') NOT NULL
);

CREATE TABLE Cliente_PF (
  idCliente INT PRIMARY KEY,
  cpf VARCHAR(14) UNIQUE,
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Cliente_PJ (
  idCliente INT PRIMARY KEY,
  cnpj VARCHAR(18) UNIQUE,
  razao_social VARCHAR(100),
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);


CREATE TABLE Veiculo (
  idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
  modelo VARCHAR(100),
  placa VARCHAR(10) UNIQUE,
  Cliente_idCliente INT,
  FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);


CREATE TABLE Funcionario (
  idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  cargo VARCHAR(50)
);


CREATE TABLE Servico (
  idServico INT PRIMARY KEY AUTO_INCREMENT,
  descricao VARCHAR(100),
  valor_base DECIMAL(10,2)
);


CREATE TABLE Ordem_Servico (
  idOrdem INT PRIMARY KEY AUTO_INCREMENT,
  Veiculo_idVeiculo INT,
  data_abertura DATE,
  data_fechamento DATE,
  status ENUM('ABERTA','EM ANDAMENTO','FINALIZADA','CANCELADA') DEFAULT 'ABERTA',
  FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);


CREATE TABLE Ordem_Servico_Servico (
  Ordem_idOrdem INT,
  Servico_idServico INT,
  quantidade INT,
  valor_final DECIMAL(10,2),
  PRIMARY KEY (Ordem_idOrdem, Servico_idServico),
  FOREIGN KEY (Ordem_idOrdem) REFERENCES Ordem_Servico(idOrdem),
  FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
);


CREATE TABLE Pagamento (
  idPagamento INT PRIMARY KEY AUTO_INCREMENT,
  Ordem_idOrdem INT,
  forma_pagamento ENUM('CARTAO','DINHEIRO','PIX','BOLETO'),
  valor DECIMAL(10,2),
  data_pagamento DATE,
  FOREIGN KEY (Ordem_idOrdem) REFERENCES Ordem_Servico(idOrdem)
);


CREATE TABLE Estoque_Peca (
  idPeca INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  quantidade INT,
  preco_unitario DECIMAL(10,2)
);


CREATE TABLE Ordem_Servico_Peca (
  Ordem_idOrdem INT,
  Peca_idPeca INT,
  quantidade INT,
  PRIMARY KEY (Ordem_idOrdem, Peca_idPeca),
  FOREIGN KEY (Ordem_idOrdem) REFERENCES Ordem_Servico(idOrdem),
  FOREIGN KEY (Peca_idPeca) REFERENCES Estoque_Peca(idPeca)
);

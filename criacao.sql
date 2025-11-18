-- Criação de esquema e tabelas principais
CREATE DATABASE IF NOT EXISTS trabalho_db;
USE trabalho_db;


-- Tabela grupos_usuarios
CREATE TABLE grupos_usuarios (
id_grupo VARCHAR(36) PRIMARY KEY,
nome VARCHAR(100) NOT NULL UNIQUE,
descricao TEXT
);


-- Tabela usuarios
CREATE TABLE usuarios (
id_usuario VARCHAR(36) PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
senha_hash VARCHAR(255) NOT NULL,
id_grupo VARCHAR(36),
criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
ativo BOOLEAN DEFAULT TRUE,
FOREIGN KEY (id_grupo) REFERENCES grupos_usuarios(id_grupo)
);


-- Exemplo de outra entidade principal: tarefas (CRUD)
CREATE TABLE tarefas (
id_tarefa VARCHAR(36) PRIMARY KEY,
titulo VARCHAR(200) NOT NULL,
descricao TEXT,
prioridade INT DEFAULT 3,
id_usuario_responsavel VARCHAR(36),
criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
concluido BOOLEAN DEFAULT FALSE,
FOREIGN KEY (id_usuario_responsavel) REFERENCES usuarios(id_usuario)
);
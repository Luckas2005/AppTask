USE trabalho_db;


-- Função para gerar ID baseado em UUID sem hífens (exemplo de regra própria)
DROP FUNCTION IF EXISTS gera_id_uuid;
DELIMITER //
CREATE FUNCTION gera_id_uuid() RETURNS VARCHAR(36)
DETERMINISTIC
RETURN REPLACE(LOWER(UUID()),'-','');
//
DELIMITER ;


-- Triggers (mínimo de 2)
-- Trigger: ao inserir usuario, garantir id gerado e manter email lowercase
DROP TRIGGER IF EXISTS trg_before_insert_usuario;
DELIMITER //
CREATE TRIGGER trg_before_insert_usuario
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
IF NEW.id_usuario IS NULL OR NEW.id_usuario = '' THEN
SET NEW.id_usuario = gera_id_uuid();
END IF;
SET NEW.email = LOWER(NEW.email);
END;//
DELIMITER ;


-- Trigger: ao inserir tarefa, gerar id se necessário e limitar prioridade entre 1 e 5
DROP TRIGGER IF EXISTS trg_before_insert_tarefa;
DELIMITER //
CREATE TRIGGER trg_before_insert_tarefa
BEFORE INSERT ON tarefas
FOR EACH ROW
BEGIN
IF NEW.id_tarefa IS NULL OR NEW.id_tarefa = '' THEN
SET NEW.id_tarefa = gera_id_uuid();
END IF;
IF NEW.prioridade < 1 THEN SET NEW.prioridade = 1; END IF;
IF NEW.prioridade > 5 THEN SET NEW.prioridade = 5; END IF;
END;//
DELIMITER ;


-- Índices: justificar uso
-- Índice em email para buscas por login/recuperação
CREATE INDEX idx_usuarios_email ON usuarios(email);
-- Índice em id_usuario_responsavel para consultas JOIN em tarefas
CREATE INDEX idx_tarefas_responsavel ON tarefas(id_usuario_responsavel);

-- Criação do Usuário de Acesso (Não-Root)
-- Este usuário deve corresponder ao configurado no application.properties
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'senha_segura';

-- Concede as permissões necessárias ao usuário no schema
GRANT ALL PRIVILEGES ON trabalho_db.* TO 'app_user'@'localhost';

FLUSH PRIVILEGES;
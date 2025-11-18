USE trabalho_db;



CREATE OR REPLACE VIEW vw_usuarios_ativos AS
SELECT id_usuario, nome, email, id_grupo, criado_em
FROM usuarios
WHERE ativo = TRUE;


CREATE OR REPLACE VIEW vw_tarefas_abertas AS
SELECT t.id_tarefa, t.titulo, t.prioridade, u.nome AS responsavel
FROM tarefas t
LEFT JOIN usuarios u ON t.id_usuario_responsavel = u.id_usuario
WHERE t.concluido = FALSE;


-- Procedure: marcar tarefa como concluída
DROP PROCEDURE IF EXISTS sp_marcar_concluido;
DELIMITER //
CREATE PROCEDURE sp_marcar_concluido(IN p_id VARCHAR(36))
BEGIN
UPDATE tarefas SET concluido = TRUE WHERE id_tarefa = p_id;
END;//
DELIMITER ;


-- Function: calcular total de tarefas abertas por usuário
DROP FUNCTION IF EXISTS fn_tarefas_abertas_por_usuario;
DELIMITER //
CREATE FUNCTION fn_tarefas_abertas_por_usuario(p_id_usuario VARCHAR(36))
RETURNS INT DETERMINISTIC
BEGIN
DECLARE total INT;
SELECT COUNT(*) INTO total FROM tarefas WHERE id_usuario_responsavel = p_id_usuario AND concluido = FALSE;
RETURN total;
END;//
DELIMITER ;
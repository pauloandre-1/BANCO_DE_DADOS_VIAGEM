/* =========================================================
   04 - CONSULTAS
   JOINs, subconsultas, funções agregadoras, índice
   (rodar depois de 03_normalizacao.sql)
   ========================================================= */

USE VIAGENS;

/* --- JUNÇÕES (JOIN) --- */

SELECT * FROM USUARIOS AS USER
INNER JOIN RESERVA AS RS ON USER.ID = RS.ID_USUARIO
INNER JOIN DESTINO AS DS ON RS.ID_DESTINO = DS.ID; 
/* INNER JOIN traz apenas os registros que têm correspondência nas duas tabelas */

SELECT * FROM USUARIOS AS USER
LEFT JOIN RESERVA AS RS ON USER.ID = RS.ID_USUARIO; 
/* LEFT JOIN retorna todos os dados da tabela da esquerda e os correspondentes 
   na tabela da direita; quando não há correspondente, o valor vem NULL */

SELECT * FROM RESERVA AS R 
RIGHT JOIN DESTINO AS D ON R.ID_DESTINO = D.ID; 
/* RIGHT JOIN retorna todos os dados da tabela da direita e os correspondentes 
   na tabela da esquerda; quando não há correspondente, o valor vem NULL */


/* --- SUBCONSULTAS --- */

/* Destinos que nunca foram reservados */
SELECT * FROM DESTINO 
WHERE ID NOT IN (SELECT ID_DESTINO FROM RESERVA);

/* Usuários que nunca fizeram reserva */
SELECT * FROM USUARIOS 
WHERE ID NOT IN (SELECT ID_USUARIO FROM RESERVA);

/* Subconsulta correlacionada: total de reservas por usuário */
SELECT NOME, (SELECT COUNT(*) FROM RESERVA WHERE ID_USUARIO = USUARIOS.ID) AS TOTAL_RESERVAS 
FROM USUARIOS;


/* --- FUNÇÕES AGREGADORAS E AGRUPAMENTO --- */

/* Contar todos os usuários com pelo menos uma reserva */
SELECT COUNT(*) AS USUARIOS_COM_RESERVAS FROM USUARIOS U
INNER JOIN RESERVA R ON U.ID = R.ID_USUARIO;

/* Selecionar a idade da pessoa mais velha no banco */
SELECT MAX(TIMESTAMPDIFF(YEAR,DATA_NASCIMENTO,CURRENT_DATE)) AS MAIOR_IDADE FROM USUARIOS;


/* --- ÍNDICE, PARA OTIMIZAR A CONSULTA ATRAVES DO NOME--- */

CREATE INDEX IDX_NOME ON USUARIOS(NOME);

/* =========================================================
   02 - SEEDS
   Inserção dos dados iniciais nas tabelas
   (rodar depois de 01_schema.sql)
   ========================================================= */

USE VIAGENS;

INSERT INTO USUARIO (ID,NOME,EMAIL,DATA_NASCIMENTO,ENDERECO) VALUES 
(NULL, 'João Silva', 'joao@example.com', '1990-05-15', 'Rua A, 123, Cidade X, Estado Y'),
(NULL, 'Maria Santos', 'maria@example.com', '1985-08-22', 'Rua B, 456, Cidade Y, Estado Z'),
(NULL, 'Pedro Souza', 'pedro@example.com', '1998-02-10', 'Avenida C, 789, Cidade X, Estado Y');

/*Destinos*/

INSERT INTO DESTINO (id, nome, descricao) VALUES
(NULL, 'Praia das Tartarugas', 'Uma bela praia com areias brancas e mar cristalino'),
(NULL, 'Cachoeira do Vale Verde', 'Uma cachoeira exuberante cercada por natureza'),
(NULL, 'Cidade Histórica de Pedra Alta', 'Uma cidade rica em história e arquitetura'),
(NULL,"Praia do Rosa","Linda Praia");

/* Reservas */
INSERT INTO RESERVA (id, id_usuario, id_destino, data, STATUS) VALUES
(NULL, 1, 2, '2023-07-10','CONFIRMADA'),
(NULL, 3, 1, '2023-08-05','PENDENTE'),
(NULL, 2, 3, '2023-09-20','CANCELADA');

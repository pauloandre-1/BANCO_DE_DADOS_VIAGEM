/* =========================================================
   03 - ALTERAÇÕES ESTRUTURAIS E NORMALIZAÇÃO (1FN)
   Demonstra ALTER TABLE, DROP TABLE, chaves estrangeiras
   com CASCADE e a quebra do campo multivalorado ENDERECO
   em colunas atômicas.
   (rodar depois de 02_seeds.sql)
   ========================================================= */


/* --- Ajustando chaves estrangeiras para CASCADE --- */

/* Consulta usada para descobrir o nome das FKs geradas automaticamente */
SELECT constraint_name, column_name, referenced_table_name, referenced_column_name
FROM information_schema.key_column_usage
WHERE table_schema = 'viagen'
  AND table_name = 'reserva'
  AND referenced_table_name IS NOT NULL;

ALTER TABLE RESERVA DROP FOREIGN KEY reserva_ibfk_1;

ALTER TABLE RESERVA
ADD CONSTRAINT fk_reserva_usuario
FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE RESERVA DROP FOREIGN KEY reserva_ibfk_2;

ALTER TABLE RESERVA 
ADD CONSTRAINT fk_reserva_destino
FOREIGN KEY (ID_DESTINO) REFERENCES DESTINO(ID)
ON DELETE CASCADE
ON UPDATE CASCADE;



/* --- Primeira Forma Normal (1FN): atomicidade dos dados --- */
/* O campo ENDERECO guardava rua, número, cidade e estado juntos.
   Isso viola a 1FN (valores devem ser atômicos/indivisíveis),
   então ele foi quebrado em colunas separadas. */

ALTER TABLE USUARIO
ADD RUA VARCHAR(100),
ADD NUMERO_CASA VARCHAR(10),
ADD CIDADE VARCHAR(50),
ADD ESTADO VARCHAR(20);

UPDATE USUARIOS 
SET RUA = SUBSTRING_INDEX(ENDERECO, "," , 1),
	NUMERO_CASA = SUBSTRING_INDEX(SUBSTRING_INDEX(ENDERECO, "," , 2), "," , -1),
	CIDADE = SUBSTRING_INDEX(SUBSTRING_INDEX(ENDERECO, "," , 3), "," , -1),
	ESTADO = SUBSTRING_INDEX(ENDERECO, "," , -1);



/* --- Dados adicionais que dependem das novas colunas --- */
INSERT INTO USUARIO (ID,NOME,EMAIL,DATA_NASCIMENTO,RUA,NUMERO_CASA,CIDADE,ESTADO) 
VALUES(NULL,"SEM RESERVA","DIO@TEST.COM","1995-05-05","RUA","12","CIDADE","ESTADO");

INSERT INTO DESTINO (ID,NOME,DESCRICAO) VALUES 
(NULL,"DESTINO SEM RESERVA","DESCRIÇÃO");

INSERT INTO usuarios (nome, email, data_nascimento, rua) VALUES
('João Silva', 'joao.silva@example.com', '1990-01-01', 'Rua A'),
('Maria Santos', 'maria.santos@example.com', '1992-03-15', 'Rua B'),
('Pedro Almeida', 'pedro.almeida@example.com', '1985-07-10', 'Rua C'),
('Ana Oliveira', 'ana.oliveira@example.com', '1998-12-25', 'Rua D'),
('Carlos Pereira', 'carlos.pereira@example.com', '1991-06-05', 'Rua E'),
('Laura Mendes', 'laura.mendes@example.com', '1994-09-12', 'Rua F'),
('Fernando Santos', 'fernando.santos@example.com', '1988-02-20', 'Rua G'),
('Mariana Costa', 'mariana.costa@example.com', '1997-11-30', 'Rua H'),
('Ricardo Rodrigues', 'ricardo.rodrigues@example.com', '1993-04-18', 'Rua I'),
('Camila Alves', 'camila.alves@example.com', '1989-08-08', 'Rua J'),
('Bruno Carvalho', 'bruno.carvalho@example.com', '1995-03-25', 'Rua K'),
('Amanda Silva', 'amanda.silva@example.com', '1996-12-02', 'Rua L'),
('Paulo Mendonça', 'paulo.mendonca@example.com', '1999-07-20', 'Rua M'),
('Larissa Oliveira', 'larissa.oliveira@example.com', '1987-10-15', 'Rua N'),
('Fernanda Sousa', 'fernanda.sousa@example.com', '1992-05-08', 'Rua O'),
('Gustavo Santos', 'gustavo.santos@example.com', '1993-09-18', 'Rua P'),
('Helena Costa', 'helena.costa@example.com', '1998-02-22', 'Rua Q'),
('Diego Almeida', 'diego.almeida@example.com', '1991-11-27', 'Rua R'),
('Juliana Lima', 'juliana.lima@example.com', '1997-04-05', 'Rua S'),
('Rafaela Silva', 'rafaela.silva@example.com', '1996-01-10', 'Rua T'),
('Lucas Pereira', 'lucas.pereira@example.com', '1986-08-30', 'Rua U'),
('Fábio Rodrigues', 'fabio.rodrigues@example.com', '1989-03-12', 'Rua V'),
('Isabela Santos', 'isabela.santos@example.com', '1994-12-07', 'Rua W'),
('André Alves', 'andre.alves@example.com', '1995-09-28', 'Rua X'),
('Clara Carvalho', 'clara.carvalho@example.com', '1990-02-15', 'Rua Y'),
('Roberto Mendes', 'roberto.mendes@example.com', '1992-07-21', 'Rua Z'),
('Mariana Oliveira', 'mariana.oliveira@example.com', '1997-05-03', 'Av. A'),
('Gustavo Costa', 'gustavo.costa@example.com', '1998-11-16', 'Av. B'),
('Lara Sousa', 'lara.sousa@example.com', '1993-06-09', 'Av. C'),
('Pedro Lima', 'pedro.lima@example.com', '1996-09-27', 'Av. D');


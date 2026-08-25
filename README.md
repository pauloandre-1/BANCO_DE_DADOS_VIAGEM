# Banco de Dados - Sistema de Viagens (VIAGENS)

Projeto de estudo em SQL/MySQL desenvolvido durante o curso de Análise e Desenvolvimento de Sistemas (ADS - UNIP), com foco em modelagem relacional, normalização de dados e consultas avançadas.

## 📋 Sobre o projeto

O banco `VIAGENS` simula um sistema de reservas de viagens, permitindo que usuários façam reservas para destinos turísticos. O projeto foi usado como exercício prático para consolidar conceitos de banco de dados relacional, desde a criação das tabelas até consultas complexas com JOINs e subconsultas.

## 🗂️ Estrutura do banco

| Tabela | Descrição |
|---|---|
| `USUARIOS` | Armazena os dados dos usuários (nome, email, endereço, data de nascimento) |
| `DESTINO` | Lista de destinos turísticos disponíveis para reserva |
| `RESERVA` | Relaciona usuários e destinos, com data e status da reserva (`PENDENTE`, `CONFIRMADA`, `CANCELADA`) |

### Relacionamentos
- `RESERVA.ID_USUARIO` → `USUARIOS.ID` (1:N — um usuário pode ter várias reservas)
- `RESERVA.ID_DESTINO` → `DESTINO.ID` (1:N — um destino pode ter várias reservas)
- Chaves estrangeiras configuradas com `ON DELETE CASCADE` e `ON UPDATE CASCADE`

## 🧠 Conceitos praticados

- **DDL**: criação de tabelas, tipos de dados, `AUTO_INCREMENT`, `COMMENT`
- **Integridade referencial**: `FOREIGN KEY`, `ON DELETE`/`ON UPDATE CASCADE`
- **Normalização (1FN)**: quebra do campo multivalorado `ENDERECO` em colunas atômicas (`RUA`, `NUMERO_CASA`, `CIDADE`, `ESTADO`) usando `SUBSTRING_INDEX`
- **JOINs**: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- **Subconsultas**: `NOT IN`, subquery correlacionada no `SELECT`
- **Funções agregadoras**: `COUNT`, `MAX`, `GROUP BY`
- **Performance**: criação de índice (`CREATE INDEX`)
- **DML**: `INSERT`, `UPDATE`, `DELETE`, `ALTER TABLE`

## 📁 Organização dos scripts

O script foi dividido em etapas, seguindo a ordem em que os conceitos foram aplicados:

| Arquivo | Conteúdo |
|---|---|
| `sql/01_schema.sql` | Criação do banco e das tabelas (`USUARIOS`, `DESTINO`, `RESERVA`) |
| `sql/02_seeds.sql` | Inserção dos dados iniciais |
| `sql/03_normalizacao.sql` | Ajuste de chaves estrangeiras (CASCADE) e normalização 1FN (quebra do campo `ENDERECO`) |
| `sql/04_consultas.sql` | JOINs, subconsultas, funções agregadoras, `EXPLAIN` e criação de índice |

## ⚙️ Como usar

1. Clone o repositório
2. Rode os scripts **na ordem numérica**:
   ```bash
   mysql -u seu_usuario -p < sql/01_schema.sql
   mysql -u seu_usuario -p < sql/02_seeds.sql
   mysql -u seu_usuario -p < sql/03_normalizacao.sql
   mysql -u seu_usuario -p < sql/04_consultas.sql
   ```
3. Ou rode cada arquivo, na mesma ordem, em uma ferramenta como DBeaver/MySQL Workbench

## 📌 Exemplos de consultas

**Usuários sem nenhuma reserva:**
```sql
SELECT * FROM USUARIOS 
WHERE ID NOT IN (SELECT ID_USUARIO FROM RESERVA);
```

**Total de reservas por usuário:**
```sql
SELECT NOME, (SELECT COUNT(*) FROM RESERVA WHERE ID_USUARIO = USUARIOS.ID) AS TOTAL_RESERVAS 
FROM USUARIOS;
```

## 🐍 Script Python complementar

Além dos scripts SQL, o repositório inclui `python/banco_viagens_destinos.py`, um script auxiliar que povoa a tabela `DESTINO` via `mysql-connector-python`, usando `executemany` para inserir vários destinos turísticos de uma vez.

**O que o script faz:**
- Define uma lista de destinos (nome + descrição)
- Conecta ao banco `VIAGENS` via `mysql.connector.connect()`
- Insere todos os registros com `cursor.executemany()`
- Faz `commit()` em caso de sucesso ou `rollback()` em caso de erro

**Como usar:**
1. Rode antes os scripts `sql/01_schema.sql` e `sql/02_seeds.sql` (a tabela `DESTINO` precisa existir)
2. Configure suas próprias credenciais de conexão localmente — **não** deixe usuário, senha ou IP fixos no código-fonte. Prefira variáveis de ambiente, por exemplo:
   ```python
   import os

   conect = mysql.connector.connect(
       host=os.getenv("DB_HOST"),
       user=os.getenv("DB_USER"),
       password=os.getenv("DB_PASSWORD"),
       database=os.getenv("DB_NAME"),
   )
   ```
   e crie um arquivo `.env` (adicionado ao `.gitignore`) com esses valores, carregando-o com `python-dotenv` se preferir.
3. Instale a dependência: `pip install mysql-connector-python`
4. Execute: `python python/banco_viagens_destinos.py`

## 🚧 Possíveis melhorias

- Adicionar tabela de pagamentos
- Criar view para relatório de reservas confirmadas
- Adicionar validação de datas (reserva não pode ser retroativa)

## 🛠️ Tecnologias

- MySQL 8.0+ / MySQL 5.7
- Python 3 + `mysql-connector-python` (script de seed complementar)


Projeto de uso educacional, livre para consulta e reaproveitamento.


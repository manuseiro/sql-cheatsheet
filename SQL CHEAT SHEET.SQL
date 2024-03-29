/*# SQL Basics Cheat Sheet

O Resumo de Conceitos Básicos de SQL fornece a sintaxe de todas as cláusulas básicas, demonstra como escrever diferentes condições e inclui exemplos.

-- O que é SQL?:
Structured Query Language, ou SQL, é a linguagem declarativa de consulta padrão para manipulação de dados mantidos em sistemas de gerenciamento de banco de dados relacional (RDBMS) ou para processamento de fluxo em um sistema de gerenciamento de fluxo de dados relacional (RDSMS). Foi desenvolvido pela primeira vez na década de 1970 pela IBM.

Embora todas as linguagens SQL compartilhem uma estrutura básica, alguns comandos e estilos específicos podem diferir ligeiramente. Dialectos populares incluem MySQL, SQLite, SQL Server, Oracle SQL, entre outros. O PostgreSQL é um bom ponto de partida, pois está próximo da sintaxe SQL padrão e pode ser facilmente adaptado para outros dialetos.

-- COMPONENTES
SQL consiste em vários componentes, cada um servindo a seu propósito exclusivo na comunicação do banco de dados:

Queries(Consultas): 
Este é o componente que permite recuperar dados de um banco de dados. A instrução SELECT é mais comumente usada para esse propósito.

Data Definition Language (DDL): 
Linguagem de definição de dados (DDL) permite criar, alterar ou excluir bancos de dados e seus objetos relacionados, como tabelas, visualizações, etc. Os comandos incluem CREATE, ALTER, DROP e TRUNCATE.

Data Manipulation Language (DML): 
Linguagem de manipulação de dados (DML) permite gerenciar dados dentro de objetos de banco de dados. Esses comandos incluem SELECT, INSERT, UPDATE e DELETE.

Data Control Language (DCL): 
Linguagem de controle de dados (DCL), inclui comandos como GRANT e REVOKE, que tratam principalmente de direitos, permissões e outras tarefas de gerenciamento de nível de controle para o sistema de banco de dados.
*/
-- COUNTRY e CITY

Tabela COUNTRY (País)
| id | name | population | area |
| :---: | :---: | :---: | :---: |
| 1 | Italia | 66600000 | 640000 |
| 2 | Brazil | 21400000 | 851000000 |
| 3 | Estados Unidads | 331900000 | 331893745 |
| 4 | Argentina | 36260130 | 2780400 |
| ... | ... | ... | ... |

Tabela CITY (Cidade)
| id | name | country_id | population | rating |
| :---: | :---: | :---: | :---: | :---: |
| 1 | Florença | 1 | 22400000 | 3 |
| 2 | Fortaleza | 2 | 26800000 | 5 |
| 3 | São Paulo | 2 | 12300000 | 1 |
| 4 | Maranhão | 2 | 685000000 | 33 |
| ... | ... | ... | ... | ... |


-- QUERIES (Consultas):

Consultar todas(`*`) as colunas da tabela `COUNTRY`:

SELECT *
FROM country
Resultado:
| id | name | population | area |
| :---: | :---: | :---: | :---: |
| 1 | Italia | 66600000 | 640000 |
| 2 | Brazil | 21400000 | 851000000 |
| 3 | Estados Unidads | 331900000 | 331893745 |
| 4 | Argentina | 36260130 | 2780400 |

Consultar as colunas `ID` e NAME da tabela -- CITY:

SELECT id, name
FROM city
Resultado:
| id | name |
| :---: | :---: |
| 1 | Florença |
| 2 | Fortaleza |
| 3 | São Paulo |
| 4 | Maranhão |
| ... | ... |

Consultar os -- NAME das -- CITY classificados pela coluna -- RATING na ordem Crescente (ASC):

SELECT name, rating
FROM city
ORDER BY rating [ASC]
Resultado:
| name | rating |
| :---: | :---: |
| São Paulo | 1 |
| Florença | 3 |
| Fortaleza| 5 |
| Maranhão | 33 |

Consultar os -- NAME das -- CITY classificados pela coluna -- RATING na ordem Decrescente (DESC):

SELECT name, rating
FROM city
ORDER BY rating DESC
Resultado:
| name | rating |
| :---: | :---: |
| Maranhão | 33 |
| Fortaleza | 5 |
| Florença| 3 |
| São Paulo | 1 |

-- APELIDOS (ALIASES)

--# Exemplo em Colunas
Um alias ou apelido é um nome alternativo que pode ser atribuído a uma tabela ou a uma coluna em uma consulta. Isso pode ser útil para simplificar a consulta, melhorar a legibilidade do código ou evitar conflitos de nome.

Exemplo de consulta utilizando alias na coluna NAME da tabela CITY, com o apelido (AS) CITY_NAME:

```sql
SELECT name AS city_name
FROM city
Neste exemplo, em vez de retornar a coluna "name" com o nome original, a consulta retorna a mesma coluna com o apelido "city_name". Esse apelido pode ser usado para se referir à coluna em outras partes da consulta, como em cláusulas WHERE ou em outras junções.

Resultado:
| id | city_name |
| :---: | :---: | 
| 4 | Maranhão | 
| 3 | São Paulo | 
| 2 | Fortaleza | 
| 1 | Florença | 
| ... | ... | 

--# Exemplo em Tabela
Outra forma de utilizar aliases é atribuir apelidos às tabelas em uma consulta.

Exemplo de consulta utilizando alias nas tabelas CITY e COUNTRY, com os apelidos CI e CO, respectivamente:

SELECT co.name, ci.name
FROM city AS ci
JOIN country AS co
  ON ci.country_id = co.id

Neste exemplo, as tabelas CITY e COUNTRY foram apelidadas de CI e CO, respectivamente. Isso permite referenciar as tabelas de forma mais concisa na consulta. A junção é realizada comparando os valores das colunas COUNTRY_ID da tabela CI (apelido para CITY) e ID da tabela CO (apelido para COUNTRY).

Resultado:
| id | name | population | area |
| :---: | :---: | :---: | :---: |
| 1 | Italia | 66600000 | 640000 |
| 2 | Brazil | 21400000 | 851000000 |

| id | name | country_id | population | rating |
| :---: | :---: | :---: | :---: | :---: |
| 1 | Florença | 1 | 22400000 | 3 |
| 2 | Fortaleza | 2 | 26800000 | 5 |
| 3 | São Paulo | 2 | 12300000 | 1 |
| 4 | Maranhão | 2 | 685000000 | 33 |

_OBS: JOIN (ou explicitamente INNER JOIN) retorna linhas que possuem valores correspondentes em ambas as tabelas._

-- SUBCONSULTAS (SUBQUERIES)
Uma subconsulta é uma consulta aninhada dentro de outra consulta ou dentro de outra subconsulta. Existem diferentes tipos de subconsultas.

--# SINGLE VALUE
A subconsulta mais simples retorna exatamente uma coluna e exatamente uma linha. Pode ser usado com operadores de comparação =, <, <=, > ou >=.

Esta consulta encontra cidades com a mesma classificação de Paris:

SELECT name 
FROM city
WHERE rating = (
	SELECT rating
	FROM city
	WHERE name = 'Paris'
)
--# MULTIPLE VALUES
Uma subconsulta também pode retornar várias colunas ou várias linhas. Essas subconsultas podem ser usadas com os operadores IN, EXISTS, ALL ou ANY.

Esta consulta encontra cidades em países com população acima de 20 milhões:

SELECT name
FROM city
WHERE country_id IN (
	SELECT country_id
	FROM country
	WHERE population > 20000000
)

--# CORRELATED
Uma subconsulta correlacionada refere-se às tabelas introduzidas na consulta externa. Uma subconsulta correlacionada depende da consulta externa. Ele não pode ser executado independentemente da consulta externa.

Esta consulta encontra cidades com uma população maior que a população média do país:

SELECT *
FROM city main_city
WHERE population > (
	SELECT AVG(population)
	FROM city average_city
	WHERE average_city.country_id = main_city.country_id
)
Esta consulta encontra países que possuem pelo menos uma cidade:

SELECT name
FROM country
WHERE EXISTS (
	SELECT *
	FROM city
	WHERE country_id = country.id
)
--# OPERADORES DE COMPARAÇÃO (COMPARISON OPERATORS)

a) Consultar -- NAME da -- CITY com -- RATING acima de 3
```sql
SELECT name
FROM city
WHERE rating > 3
Resultado:
| name |
| :---: |
| Fortaleza |
| Maranhão |

b) Consultar -- NAME de CITY diferente de `FLORENÇA` e `FORTALEZA`
```sql
SELECT name
FROM city
WHERE name != 'Florença'
  AND name != 'Fortaleza'
Resultado:
| name |
| :---: |
| São Paulo |
| Maranhão |

--# OPERADORES DE TEXTO (TEXT OPERATORS)

a) Consultar -- NAME de CITY que começam com 'f' ou terminam com 'a':

SELECT name
FROM city
WHERE name LIKE 'f%'
  OR name LIKE '%a'
Resultado:
| id | name |
| :---: | :---: |
| 1 | Florença |
| 2 | Fortaleza |

b) Consultar -- NAME de CITY que começe com qualquer letra seguida por 'ortaleza':

SELECT name
FROM city
WHERE name LIKE '_ortaleza'
Resultado:
| id | name |
| :---: | :---: |
| 2 | Fortaleza |

--# OUTROS OPERADORES (OTHER OPERATORS)

a) Consultar -- NAME de CITY com `POPULATION` entre(between) 500K e 5M:

SELECT name
FROM city
WHERE population BETWEEN 500000 AND 5000000
b) Consultar -- NAME de CITY que não possuem um valor de RATING:

SELECT name
FROM city
WHERE rating IS NOT NULL
c) Consultar -- NAME de CITY que estão em `COUNTRY` com `IDs` 1, 4, 7 ou 8:

SELECT name
FROM city
WHERE country_id IN (1, 4, 7, 8)

-- GERENCIANDO TABELAS (MANAGING TABLES)

Aqui estão algumas dicas para usar no SQL com uma tabela chamada DISTRICT, uma visualização representada por V e uma coluna representada por C:

a) Criar uma nova tabela chamada DISTRICT com três colunas (id, name, price):

```sql
CREATE TABLE district (id INT PRIMARY KEY, name VARCHAR NOT NULL,price INT DEFAULT 0)
```
Resultado após criar a tabela DISTRICT (Bairro):

| id | name | price |
| :---: | :---: | :---: |

OBS: Os valores para id, name e price devem ser inseridos nas respectivas colunas da tabela.

b) Para adicionar uma nova coluna chamada `WEALTH` à tabela -- DISTRICT, você pode usar a seguinte consulta:

```sql
ALTER TABLE district ADD COLUMN wealth
```
Resultado:
| id | name | price | wealth |
| :---: | :---: | :---: | :---: |

c) Para inserir os dados na tabela -- DISTRICT, você pode usar a seguinte consulta:
A nova linha foi adicionada à tabela district com o id igual a 1, o name igual a "Fortaleza", o price igual a 2000000 e o wealth igual a 4000000000.

```sql
INSERT INTO district (name, price, wealth) VALUES ('Fortaleza', 2000000, 4000000000)
Resultado:
| id | name | price | wealth |
| :---: | :---: | :---: | :---: |
| 1 | Fortaleza | 2000000 | 4000000000 |

d) Excluir coluna `WEALTH` da tabela -- DISTRICT

```sql
ALTER TABLE district DROP COLUMN wealth
```
Resultado:
| id | name | price |
| :---: | :---: | :---: |
| 1 | Fortaleza | 2000000 |

Adicionar uma restrição(`CONSTRAINT`)
```sql
ALTER TABLE district ADD constraint
```
OBS: As restrições(CONSTRAINT) podem ser especificadas quando a tabela é criada com a instrução CREATE TABLE ou depois que a tabela é criada com a instrução ALTER TABLE.

Excluir uma restrição(CONSTRAINT)

```sql
ALTER TABLE district DROP constraint
```

Renomear tabela "district1" para "T2"
```sql
ALTER TABLE district1 REMANE TO t2
```

Renomear Coluna "C1" para "C2" da tabela "district1"
```sql
ALTER TABLE district1 RENANE cl TO c2
```

Remover todos os dados da tabela -- DISTRICT
```sql
TRUNCATE TABLE district
```

Excluir a tabela -- DISTRICT do banco de dados

```sql
DROP TABLE district
```

-- GERENCIANDO GATILHOS(MANAGING TRIGGERS)

Criar ou modificar um gatilho(TRIGGER), neste exemplo o gatilho terá o nome de trigger_name 
```sql
CREATE OR MODIFY TRIGGER trigger_name
WHEN EVENT
ON table_nane TRIGGER TYPE
EXECUTE stored_procedure
WHEN
- BEFORE -invocar(invoke) antes(BEFORE) que o evento ocorra
- AFTER -invocar(invoke) despois(AFTER) do evento ocorrer
EVENT
- INSERT - invoke for INSERT
- UPDATE - invoke for UPDATE
- DELETE - invoke for DELETE
TRIGGER_TYPE
- FOR EACH ROW
- FOR EACH STATEMENT

Crie um gatilho(TRIGGER) invocado antes que uma nova linha seja inserida na person table
```sql
CREATE TRIGGER
BEFORE INSERT
ON person FOR EACH ROW
EXECUTE stored_procedure 
Excluir um gatilho(TRIGGER) específico
```sql
DROP TRIGGER trigger_name
```

-- GERENCIANDO VIEWS(MANAGING VIEWS)
Crie uma nova VIEW que consiste em cl e c2
```sql
CREATE VIEW v(c1,c2) AS
SELECT cl, c2
FROM district
```
Crie uma nova VIEW com a opção de verificação
```sql
CREATE VIEW v(c1,c2) AS
SELECT Cl, C2
FROM district
```
Criar uma VIEW recursiva
```sql
WITH [CASCADED | LOCAL] CHECK OPTION
CREATE RECURSIVE VIEW v AS
select-statement —- anchor part
UNION [ALL]
select-statement —- recursive part
```
Criar uma VIEW temporária
```sql
CREATE TEMPORARY VIEW v AS
SELECT cl, C2
FROM district
```
Excluir uma VIEW
```sql
DROP VIEW view_name
```
-- MODIFICANDO DADOS (MODIFYING DATA)

Inserir(INSERT) uma linha(ROW) na tabela(TABLE) -- DISTRICT
```sql
INSERT INTO district(column_list)
VALUES( value_list)
Inserir várias linhas(ROWS) na tabela(TABLE) -- DISTRICT:

INSERT INTO district(column_list)
VALUES 	(vatue_list),
		(vatue_list), ....
Inserir linhas(ROWS) da tabela(TABLE) `district2` no -- district1:

INSERT INTO district1(column_list)
SELECT column_list 
	FROM district2
Update new value in the column cl for all rows
```sql
UPDATE district
SET cl = new_value
Update values in the column cl, c2 that match the condition
```sql
UPDATE district
SET	cI = new_value,
	c2 = new_value
WHERE condition
Delete all data in a table
```sql
DELETE FROM district
Delete subset of rows in a table
```sql
DELETE FROM district
WHERE condition
-- CONSULTANDO EM MÚLTIPLAS TABELAS (QUERYING FROM MULTIPLE TABLES)

Tabela COUNTRY (País)
| id | name |
| :---: | :---: |
| 1 | Italia |
| 2 | Brazil |
| 3 | Estados Unidads |
| 4 | Argentina |
| ... | ... |

Tabela CITY (Cidade)
| id | name | country_id |
| :---: | :---: | :---: |
| 1 | Florença | 1 |
| 2 | Fortaleza | 2 |
| 3 | São Paulo | 2 |
| 4 | Maranhão | 2 |
| ... | ... | ... |

--# INNER JOIN
JOIN (ou explicitamente INNER JOIN) retorna apenas as linhas das tabelas que têm correspondência na outra tabela. Em outras palavras, somente os registros que possuem valores correspondentes em ambas as tabelas são incluídos no resultado.
```sql
SELECT city.name, country.name
FROM city
[INNER] JOIN country
ON city.country_id = country.id
Resultado:
| city.name | country.name |
| :---: | :---: |
| Florença | Italia |
| Fortaleza | Brazil |
| São Paulo | Brazil |
| Maranhão | Brazil |
| ... | ... |

--# LEFT JOIN
LEFT JOIN retorna todas as linhas da tabela esquerda com linhas correspondentes da tabela à direita. Se não houver linha correspondente, NULLs são retornados como valores do segunda mesa.
```sql
SELECT city.name, country.name
FROM city
LEFT JOIN country
ON city.country_id = country.id
--# RIGHT JOIN
RIGHT JOIN retorna todas as linhas da tabela da direita com linhas correspondentes da tabela à esquerda. Se não houver linha correspondente, NULLs são retornados como valores da esquerda tabela.
```sql
SELECT city.name, country.name
FROM city
RIGHT JOIN country
ON city.country_id = country.id
--# FULL JOIN
FULL JOIN (ou explicitamente FULL OUTER JOIN) retorna todas as linhas de ambas as tabelas, incluindo registros que não têm correspondência na outra tabela. Quando um registro não possui correspondência na outra tabela, o valor para essa tabela é nulo. Em outras palavras, o resultado inclui todos os registros de ambas as tabelas, independentemente de haver correspondência ou não.
```sql
SELECT city.name, country.name
FROM city
FULL [OUTER] JOIN country
ON city.country_id = country.id

--# CROSS JOIN
CROSS JOIN retorna o produto cartesiano de duas tabelas. Em outras palavras, ele combina cada linha da primeira tabela com todas as linhas da segunda tabela, sem levar em consideração qualquer condição de junção. Existem duas sintaxes disponíveis.
```sql
SELECT city.name, country.name
FROM city
CROSS JOIN country

```sql
SELECT city.name, country.name
FROM city, country
--# NATURAL JOIN
NATURAL JOIN combina duas tabelas usando todas as colunas com o mesmo nome automaticamente, sem precisar especificar as condições de junção explicitamente. Em outras palavras, o NATURAL JOIN compara as colunas de ambas as tabelas com o mesmo nome e retorna as linhas que têm valores iguais nessas colunas.

```sql
SELECT city.name, country.name
FROM city
NATURAL JOIN country

-- FUNÇÕES AGREGADAS (AGGREGATE FUNCTIONS)
Funções agregadas SQL são funções integradas usadas para realizar alguns cálculos nos dados e retornar um único valor. É por isso que eles formam a base para “consultas agregadas”. Essas funções operam em um conjunto de linhas e retornam um único resultado resumido.

- count(column_name) − Conta o número de linhas de uma coluna.
```sql
SELECT COUNT(column_name) 
FROM table_name 
WHERE condition
- sum(column_name) − Retorna a soma de uma coluna numérica.
```sql
SELECT SUM(column_name) 
FROM table_name 
WHERE condition
- avg(column_name) − Retorna o valor médio de uma coluna numérica.
```sql
SELECT AVG(column_name) 
FROM table_name 
WHERE condition
- min(column_name) − Retorna o menor valor da coluna selecionada.
```sql
SELECT MIN(column_name) 
FROM table_name 
WHERE condition
- max(column_name) − Retorna o maior valor da coluna selecionada.
```sql
SELECT MAX(column_name) 
FROM table_name 
WHERE condition

Veja alguns exemplo de uso:

Descubra o número de cidades:

SELECT COUNT(rating)
FROM city
Descubra o número de cidades com classificações não nulas:

SELECT COUNT(DISTINCT country_id)
FROM city
Descubra o número de valores de país distintos:

SELECT MIN(population), MAX(population)
FROM country
Descubra as menores e as maiores populações do país:

SELECT country_id, SUM(population)
FROM city
GROUP BY country_id
Descubra a população total das cidades nos respectivos países:

SELECT country_id, AVG(rating)
FROM city
GROUP BY country_id
HAVING AVG(rating) > 3.0
-- AGRUPAMENTO (GROUPING)

--# GROUP BY
GROUP BY agrupa linhas que possuem os mesmos valores em colunas especificadas.
Ele calcula resumos (agregados) para cada combinação exclusiva de valores.

---- CITY (Cidade)
| id | name | country_id | 
| :---: | :---: | :---: | 
| 1 | Florença | 1 | 
| 2 | Fortaleza | 2 | 
| 3 | São Paulo | 2 | 
| 4 | Maranhão | 2 |
| 5 | Lyon | 3 | 
| 6 | Berlin | 1 | 
| 7 | Warsaw | 3 | 
| ... | ... | ... |

Agrupo todos os valores da coluna -- country_id agrupados em uma coluna chamada -- count.
```sql
SELECT country_id, COUNT(*) AS count 
FROM city 
GROUP BY country_id
Resultado:
| country_id | count | 
| :---: | :---: |
| 1 | 2 | 
| 2 | 3 | 
| 3 | 2 | 
| ... | ... |

-- USANDO RESTRIÇÕES SQL (USING SQL CONSTRAINTS)

Definir C1 e CZ como chave-primária(primary-key)
```sql
CREATE TABLE t(
	cl INT, C2 INT, C3 VARCHAR,
	PRIMARY KEY (cl,c2)
)
Defina a coluna c2 como uma chave-estrangeira(foreign-key)
```sql
CREATE TABLE district1(
Cl INT PRIMARY KEY,
C2 INT,
FOREIGN KEY (c2) REFERENCES t2(c2)
)
Torne os valores em cl e c2 exclusivos(UNIQUE)
```sql
CREATE TABLE t(
cl INT, cl INT,
UNIQUE(c2, c3)
)
Certifique-se de que cl > 0 e valores em cl>=c2
```sql
CREATE TABLE t(
cl INT, c2 INT,
CHECK(c1> 0 AND cl >= c2)
)
Definir valores na coluna c2 não é nulo (NOT NULL)
```sql
CREATE TABLE t(
cl INT PRIMARY KEY,
c2 VARCHAR NOT NULL
)
-- USANDO OPERADORES SQL (USING SQL OPERATORS)

Combine Rows FROM districtwo Queries
```sql
SELECT cl, C2 FROM districtl
UNION [ALL]
SELECT Cl, C2 FROM district2
Return The Intersection Of TWO Queries
```sql
SELECT cl, c2 FROM districdistrict1
INTERSECT
SELECT Cl, C2 FROM district2
Subtract A Result Set From Another Result Set
```sql
SELECT cl, c2 FROM districtl
MINUS
SELECT cl, C2 FROM district2
Query Rows Using Pattern Matching _
```sql
SELECT cl, c2 FROM districtl
WHERE Cl [NOT] LIKE pattern
Query Rows In A List
```sql
SELECT Cl, c2 FROM district
WHERE cl [NOT] IN value_list
Query Rows Between Two Values
```sql
SELECT cl, c2 FROM district
WHERE cl BETWEEN low AND high
Check If Values In A Table IS NULL Or Not
```sql
SELECT cl, C2 FROM district
WHERE cl IS [NOT] NULL

-- Referência

 - [W3Schools - SQL Tutorial](https://www.w3schools.com/sql)
 - [SQL Basics Cheat Sheet - LearnSQL.com](https://learnsql.com/blog/sql-basics-cheat-sheet/)
 - [SQL Basics Cheat Sheet - DataCamp](https://www.datacamp.com/cheat-sheet/sql-basics-cheat-sheet)

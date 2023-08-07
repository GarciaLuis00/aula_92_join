#criando bd
create database ibge;

#ativando o bd 
use ibge;

#criando a tabela municipios
create table municipios (
cod_municipio INT,
cod_uf int,
nome_municipio VARCHAR(40),
populacao int,
primary key(cod_municipio),
FOREIGN KEY (cod_uf) REFERENCES
unidades_federativas(cod_uf)
);

#criando tabela unidade federativa 
create table unidades_federativas (
cod_uf int,
uf char(2),
nome_uf varchar(30),
primary key (cod_uf)
);

#Listar todos os municípios e suas unidades federativas
SELECT m.nome_municipio, u.nome_uf FROM municipios m

INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf;

#Listar os municípios com sua população e a sigla da unidade
SELECT m.nome_municipio, m.populacao, u.uf AS sigla_uf
FROM municipios m
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf;

#Listar os municípios e suas unidades federativas, ordenando pelo nome do município
SELECT m.nome_municipio, u.nome_uf
FROM municipios m 
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
ORDER BY m.nome_municipio;

#Listar os municípios que possuem uma população superior a 100.000 habitantes, juntamente com a sigla da unidade federativa
SELECT m.nome_municipio, u.uf
FROM municipios m
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
WHERE m.populacao > 100000;


#Listar os municípios que têm o mesmo nome que sua respectiva unidade federativa
SELECT m.cod_municipio, m.cod_uf, m.nome_municipio, m.populacao, u.nome_uf
FROM municipios m
JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
WHERE m.nome_municipio = u.nome_uf;

#Calcular a média de população dos municípios para cada unidade federativa
SELECT uf.nome_uf AS unidades_federativa,
AVG(m.populacao) AS media_populacao
FROM unidades_federativas uf
INNER JOIN municipios m ON uf.cod_uf = m.cod_uf
GROUP BY uf.nome_uf;

#Listar os municípios que têm uma população maior que a média da população de todos os municípios
SELECT m.cod_municipio, m.nome_municipio, m.populacao
FROM municipios m
WHERE m.populacao > (SELECT AVG(populacao) FROM municipios);

#Contar quantos municípios existem em cada unidade federativa.
SELECT uf, nome_uf, COUNT(*) AS total_municipios
FROM unidades_federativas
INNER JOIN municipios ON unidades_federativas.cod_uf = municipios.cod_uf
GROUP BY uf, nome_uf;


















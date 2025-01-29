# Esse é um comentário de 1 linha

-- Esse é outro comentário de 1 linha

/* Início do comentário
bla
bla
bla */

-- ctrl shift enter executa todos os códigos
-- ctrl enter executa só a linha

Create database Cadastro;
show databases;

create table clientes (
nome varchar (40),
idade tinyint (3),
sexo char (1),
peso float,
altura float,
nacionalidade varchar (25)
);

-- excluir
drop database cadastro; 

create database cadastro;
use cadastro;
create table clientes (
nome varchar (45) not null,
nascimento date,
sexo enum ('M' , 'F'),
peso decimal (5,2),
altura decimal (3,2),
nacionalidade varchar(25) default 'Brasil'
);

-- para verificar a estrutura da tabela
desc clientes;

-- adicionando informações em uma tabela criada
alter table clientes
add column id int not null auto_increment primary key;

desc clientes;

-- para excluir o campo id
alter table clientes
drop column id;

-- para deixar o id como o primeiro da coluna 
alter table clientes
add column id int not null auto_increment primary key first;
desc clientes;

-- adicionar uma coluna depois de um campo
-- alter table nome_da_tabela add column nome_da_coluna atributos_da_coluna after nome_da_coluna;

-- exemplo: adicionar a coluna estado_civil depois de nascimento
alter table clientes add column estado_civil varchar (40) after nascimento;
desc clientes;

alter table clientes drop column estado_civil;
desc clientes;

-- adicionando registros a tabela de clientes
-- obs: não precisa informar o id pois está com o auto incremente. a nacionalidade ficará em branco para aprendermos a usar campos em tabela
insert into clientes
(nome, nascimento, sexo, peso, altura, nacionalidade)
values
('Marcelo', '1968-11-15', 'M', '88.60', '1.85', '');
SELECT * from clientes;

-- atualizando informações
update clientes
set nacionalidade = 'Brasil' where id='1';
desc clientes;

insert into clientes (nome, nascimento, sexo, peso, altura, nacionalidade)
values
('Simone', '1970-10-28', 'F', '75', '1.67', 'default');
select*from clientes;

-- alterar tamanho de campo e constraints
alter table clientes
modify column nome varchar (60);
-- modify permite mudar o tipo primitivo e as constraints

desc clientes;

-- renomear o nome de uma coluna
alter table clientes
change column sexo genero enum ('M','F');
desc clientes;

-- renomear uma tabela
alter table clientes rename to clientes1;
show tables; -- mostra todas as tabelas do banco de dados em uso

-- retorne o nome da tabela
alter table clientes1 rename to clientes;

insert into clientes (nome, nascimento, genero, peso, altura, nacionalidade)
values
('Fernanda', '1978-10-28', 'F', '70.5', '1.58', 'default'),
('Julio', '2010-08-26', 'M', '55.6', '1.69', 'default'),
('Davi', '2014-06-30', 'M', '34.8', '1.48', 'default'),
('Silvana', '1963-03-11', 'F', '64.5', '1.52', 'default');
select*from clientes;

-- deletando infos
delete from clientes where id = 2;
select* from clientes;
describe clientes;

-- alterando a estrutura da tabela clientes
desc clientes;
alter table clientes
add column profissao varchar(20) after nome;
select*from clientes;

alter table clientes
rename column profissao to cargo;
update clientes
set cargo = 'TI' where id='1';
desc clientes;

update clientes
set cargo = 'Gerente' where id='3';
update clientes
set cargo = 'Administrativo' where id='4';
update clientes
set cargo = 'Assistente Contábil' where id='5';
update clientes
set cargo = 'Aux. Adm.' where id='6';
desc clientes;

create table if not exists clientes (test int);
-- não será executado porque a tabela clientes já existe

-- criando a tabela cursos
create table if not exists cursos (
nome varchar(30) not null unique,
descricao text,
carga int unsigned,
qtdeaulas int unsigned,
ano year default '2024');
-- unique: não permite colocar dois cursos com o mesmo nome
-- unsigned: sem sinal (+ ou -). isso economiza um byte para cada registro

alter table cursos
add column id int not null auto_increment primary key first;

desc cursos;

insert into cursos (nome, descricao, carga, qtdeaulas, ano)
values
('Pacote Officce', 'Nível básico', '96', '24', '2000'),
('Exel básico', 'Nível intermediário', '40', '10', '2012'),
('Excel avançado', 'Nível avançado', '60', '15', '2014'),
('Operador de microcomputador', 'Nível intermediário', '160', '40', '2028'),
('SQL', 'Nível avançado', '120', '30', '2004');
select*from cursos;

update cursos
set nome = 'Pacote Office' where id='1';
desc cursos;

update cursos
set nome = 'Excel básico' where id='2';
desc cursos;

update cursos
set ano = '2025' where id='4';
desc cursos;
select*from cursos;

delete from cursos where id = 3;

-- modificar várias informações na mesma linha
update cursos 
set nome = 'Excel básico', ano = '2020', carga = '40'
where id = 2
limit 1; -- para executar o comando em apenas 1 local

update cursos
set ano = 2040, carga = 500
where ano = 2020;

update clientes
set cargo = 'Aux. Administrativo'
where cargo = 'Aux. Adm.';
select*from clientes;



/* a criação de copias de tabelas no sql pode ser útil para
herdar configurações de campos, criar uma cópia de uma tabela 
com algumas colunas ou criar uma tabela a partir de uma coluna */

-- fazendo uma cópia usando CREATE TABLE
create table new_table as select*from original_table;

create table clientes2 as select*from clientes;
select*from clientes2;

-- truncar uma tabela é apagar todos os registros, porém a estrutura da tabela é mantida
truncate table clientes2; -- apaga somente as linhas da tabela
-- ou 
truncate clientes2;

select*from clientes2;
drop table clientes2; -- apaga linhas e colunas
drop table cursos;

use cadastro;
show tables;
desc cursos;

create table cursos2 as select*from cursos;
select*from cursos2;

drop table cursos;

select*from cursos;

-- comando select
-- para ordenar pelo nome da coluna
select*from cursos
order by nome;

-- ordem decrescente
select * from cursos 
order by nome desc; -- desc nesse caso significa descendants

-- para filtrar colunas
select*from cursos;
-- tira o * e coloca o nome das colunas desejadas
select nome, carga, ano from cursos
order by nome;

select ano, nome, carga from cursos
order by ano, nome;

-- filtrar por linhas
select*from cursos
where ano = 2016
order by nome;

-- selecionando por nome e carga
select nome, carga from cursos
where ano = 2016
order by nome;

-- seleionar cursos onde o ano é menor ou igual a 2015
select ano, nome, descricao from cursos
where ano <= 2015
order by nome;
select*from cursos;

-- para selecionar cursos, onde o ano é diferente de 2016, por ordem de ano
select ano, nome, descricao from cursos
where ano !=  2016 -- != ou <> significa DIFERENTE
order by ano, nome;

-- para saber os cursos que estão entre 2014 e 2016
select ano, nome from cursos
where ano between 2014 and 2016
order by nome;

-- para saber os cursos ano IN 2014, 2016 e 2018
select idcurso, ano, nome from cursos
where ano in (2014, 2016, 2018);

-- para saber a carga maior que 35 e totalaulas menor que 30
select*from cursos
where carga > 35 and totaulas < 30
order by nome;

-- para saber a carga maior que 35 ou totalaulas menor que 30 dos campos: nome, carga e totalaulas
select nome, carga, totaulas from cursos
where carga >35 or totaulas < 30
order by nome;

-- exercício .................................................................................................

-- Criar uma base de dados no MySQL para cadastrar clientes de uma empresa, com o nome ti
create database ti;
use ti;

/* Crie uma tabela para armazenar os clientes, eles devem ser gerenciados pelos campos de 
CPF, Nome, Data de Nascimento, Endereço, CEP, Bairro, Cidade e UF.  */
create table clients (
cpf varchar (11),
nome varchar (45),
nascimento varchar (20),
endereco varchar (50), 
cep varchar (10), 
bairro varchar (30), 
cidade varchar (20), 
uf varchar (20)
);

/* Após criar a tabela acima especificada adicionar um campo para armazenar a data da 
última compra, insira as datas do dia 16 a 19 de junho de 2024.  */
alter table clients
add column ultimacompra int not null auto_increment primary key;
desc clients;

alter table clients
drop column ultimacompra;
alter table clients
add column id int not null auto_increment primary key;
alter table clients
drop column id;
alter table clients
add column ultimacompra int not null;

update clients
set ultimacompra = '16 a 19 de junho/24';

alter table clients
modify column nascimento varchar (25);

alter table clients
modify column ultimacompra varchar (30) default '16 a 19 de junho/24';

-- Inserir na tabela clientes quatro clientes, conforme seguem:  
insert into clients (cpf, nome, nascimento, endereco, cep, bairro, cidade, uf, ultimacompra)
values
(02296332780, 'Marcos da Silva', 25/11/1970, 'Rua Pedro Marques', 88045968, 'Santana', 'São 
Paulo', 'SP', 'default'),
(08285031490, 'Ana Ana Julia', 21/10/1985, 'Rua Paradigma Novais', 99078923, 'Leblon', 'Rio de 
Janeiro', 'RJ', 'default'),
(05550314905, 'Jorge Soares', 05/03/1989, 'Rua das Banguelas', 77048917, 'Copacabana', 'Rio 
de Janeiro', 'RJ', 'default'),
(01150314905, 'Juvenal Soares', 15/04/1989, 'Rua das Tabuinhas', 69048917, 'Minerva', 'Minas 
Gerais', 'MG', 'default');
select*from clients;

select uf, nome from clients
where uf =  'RJ' 
order by uf, nome;

alter table clients
add column produto varchar (40);

update clients
set produto = 'TV' where nome='Marcos da Silva';
update clients
set produto = 'GELADEIRA' where nome='Ana Ana Julia';
update clients
set produto = 'NOTEBOOK' where nome='Jorge Soares';
update clients
set produto = 'CELULAR' where nome='Juvenal Soares';

update clients
set nascimento = '25/11/1970' where nome = 'Marcos da Silva';
update clients
set nascimento = ' 21/10/1985' where nome = 'Ana Ana Julia';
update clients
set nascimento = '05/03/1989' where nome = 'Jorge Soares';
update clients
set nascimento = '15/04/1989' where nome = 'Juvenal Soares';

update clients
set ultimacompra = '16 a 19 de junho de 2024';
select*from clients;

-- Deletar os clientes que residam na cidade de São Paulo.
delete from clients where uf = 'SP';

-- fim.....................................................................

-- usando like e not like:
-- like: encontrar registros que correspondam a um determinado padrão de caracteres
-- sitaxe: where coluna like padrão
-- caracteres curinga: % representa zero ou mais caracteres

-- exemplos
-- where nome like 'J%': encontra todos os nomes que começam com J
-- where nome like 'Silva%': encontra todos os nomes que terminam em Silva

-- not like: encontrar registros que NÃO correspondem a um determinado padrão de caracteres
-- where coluna not like 'padrão'
-- exemplos
-- where nome not like 'J%': Encontra todos os nomes que NÃO começam com J
-- where nome not like 'Silva%': encontra todos os nomes NÃO que terminam em Silva

select * from cursos
where nome like 'P%';

-- selecionar cursos que terminam com A 
select * from cursos
where nome like '%a';

-- selecionar cursos onde apareça a letra A, independentemente do lugar
select * from cursos
where nome like '%a%';

-- selecionar tod os cursos que começam com PH e terminam com P 
select * from cursos
where nome like 'PH%P';

-- selecionar todos os cursos que começam com PH e tenham alguma informação depois do P 
select * from cursos
where nome like 'PH%P_';

-- FUNÇÕES DE AGREGAÇÃO 
-- count(*): conta o numero de linhas em um conjunto de resultados
-- sum(coluna): calcula a soma de todos os valores nao nulos em uma coluna numerica
-- avg(coluna): calcula a media de todos os valores não nulos em uma caoluna numerica

-- USADO PARA
-- calcular totais: como o total de vendas em um periodo
-- encontrar valores maximos e minimos: qual é o produto mais caro e o mais barato?
-- calcular medias
-- contar ocorrencias

-- exemplos
-- contar o numero total de clientes select count (*) from clientes
-- calcular a soma de todos os valores de uma coluna 'valor' select sum (valor) from vendas
-- encontrar a media de idade dos clientes select avg(idade) from clientes
-- encontrar o cliente mais velho select max(idade) from clientes
-- encontrar o cliente mais novo select min (idade) from clientes

-- funções de agregação
-- group by: agrupa os resultads com base em um ou mais atributos, permitindo calcular agregações para cada grupo 
-- having filtra grupos apos a aplicação das funções de agregação 

-- exemplo
-- select categoria sum(valor) as total_vendas
-- from vendas
-- group by categoria
-- having total_vendas > 1000

-- funções de agregação 
-- contar os cursos da tabela cursos
select count(*) from cursos;

-- visualizar os cursos com carga horaria maior que 40h
select * from cursos where carga > 40;

-- a maior carga horaria entra os cursos
select max(carga) from cursos;

-- maior numero de aulas que tenho entre os cursos do ano 2016
select max(totaulas) from cursos where ano = 2016;

-- qual é o menor numero de aulas que tenho entre os cursos
select min(totaulas) from cursos;

-- somatoria do total de aulas
select sum(totaulas) from cursos;

-- media do total de aulas
select avg(totaulas) from cursos;

select * from alunos;
-- EXERCICIO......................................
-- 1-) Faça uma lista com o nome de todas as alunas em ordem alfabética de nomes
select * from alunos where sexo = 'F' order by nome;

-- 2-) Faça uma lista com os dados de todos aqueles que nasceram entre 1/Jan/2000 e 31/Dez/2015. 
select * from alunos where nascimento between '2000-01-01' and '2015-12-31';

-- 3-) Faça uma lista com o nome de todos os homens que trabalham como Programadores, em ordem alfabética de nomes. 
select * from alunos where sexo='M' and profissao='Programador' order by nome;

-- 4-) Faça uma lista com os dados de todas as mulheres que nasceram no Brasil e que tem seu nome iniciado com a letra J. 
select * from alunos where sexo='F' and nacionalidade='Brasil'
and nome like 'J%';

-- 5-) Faça uma lista com o nome e nacionalidade de todos os homens que têm Silva no nome, nasceram no Brasil e pesam menos de 80 Kg
select * from alunos where sexo='M' and nacionalidade='Brasil' and peso < '80' and nome like'%Silva%';

-- 6-)  Qual é a maior altura entre os alunos homens que moram em Portugal? 
select max(altura) from alunos where nacionalidade='Portugal';

-- 7-)  Qual é a média de peso dos alunos cadastrados?
select avg(peso) from alunos;

-- 8) Quem são os homens da lista de alunos, que nasceram fora do Brasil entre 01/01/1990 e 31/12/2000, 
-- classifique em ordem decrescente de nome. 
select * from alunos where sexo='M' AND nacionalidade not like 'Brasil' 
and nascimento between '1990-01-01' and '2000-12-31' order by nome desc;

-- 9- Qual é o menor peso entre as mulheres que nasceram fora do Brasil, entre 01/01/1990 e 31/12/2000?
select min(peso) from alunos where sexo='F' and nacionalidade 
not like 'Brasil' and nascimento between '1990-01-01' and '2000-12-31';

-- 10-) Quantas mulheres tem mais de 1.90m de altura? 
select count(altura) from alunos where sexo='F' and altura > '1.90';

-- fim...........................................

-- agrupando registros
select carga from cursos
group by carga;

-- agrupando e agregando registros
select carga, count(nome) from cursos
group by carga;

-- total de aulas de cada curos sem saber quantos cursos tem estes totais de aulas
select distinct totaulas from cursos
order by totaulas;

-- para ver quantos cursos tem em cada totaulas
select totaulas, count(*) from cursos
group by totaulas
order by totaulas;
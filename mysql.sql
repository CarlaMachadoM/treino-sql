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

-- selecione as aulas = 30 agrupadas por carga
select carga, totaulas from cursos
where totaulas = 30
group by carga;

-- contando quantos cursos tem = 30 aulas
select carga, count(nome) from cursos
where totaulas = 30
group by carga;
select * from cursos;

-- contando cursos que fora lançados por ano
select ano, count(nome) from cursos
group by ano;

-- ordenando por quantidade
select ano, count(nome) from cursos
group by ano
order by count(*);

-- se quiser o inverso, bast digitar desc
select ano, count(nome) from cursos
group by ano
order by count(*) desc;

-- para agrupar contando o ano >= 5
select ano, count(nome) from cursos
group by ano
having count(ano) >= 5
order by count(*) desc;

-- totaulas > 30, agrupando por ano, apenas para anos maiores que 2013
select ano, count(nome) from cursos where totaulas > 30 
group by ano
having ano > 2013 
order by count(*);

-- selecionar carga e o total de horas dos cursos, onde o ano seja maior que 2015, agrupado por carga, para cargas acima da media
select carga, count(*) from cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos);

-- EXERCICIO............................................................
create database Livraria;
show databases;
use livraria;

create table livros (
nome varchar (40),
autor varchar (40),
sexo varchar (1),
pags int (8),
editora varchar (20),
preco float(4),
estado varchar (25),
publicacao int (4)
);

insert into livros (nome, autor, sexo, pags, editora, preco, estado, publicacao)
values
('Cavaleiro Real', 'Ana Claudia', 'F', '465', 'Atlas', '49.9', 'RJ', '2009'),
('SQL Para Leigos', 'João Nunes', 'M', '450', 'Addison', '98', 'SP', '2018'),
('Receitas Caseiras', 'Célia Tavares', 'F', '210', 'Atlas', '45', 'RJ', '2008'),
('Pessoas Efetivas', 'Eduardo Santos', 'M', '390', 'Beta', '78.99', 'RJ', '2018'),
('Hábitos Saudáveis', 'Eduardo Santos', 'M', '630', 'Beta', '150.98', 'RJ', '2019'),
('A Casa Marrom', 'Hermes Macedo', 'M', '250', 'Bubba', '60', 'MG', '2016'),
('Estácio Querido', 'Geraldo Francisco', 'M', '310', 'Insignia', '100', 'ES', '2015'),
('Para Sempre Amigas', 'Leda Silva', 'F', '510', 'Insignia', '78.98', 'ES', '2011'),
('Copas Inesquecíveis', 'Marco Alcântara', 'M', '200', 'Larson', '130.98', 'RS', '2018'),
('O Poder da Mente', 'Clara Mafra', 'F', '120', 'Continental', '56.58', 'SP', '2017');
select*from livros;

select nome, editora from livros;

select autor, estado  from livros where sexo= 'M';

select nome, pags from livros where sexo = 'F';

select preco from livros where estado = 'SP';

select * from livros where sexo = 'M'
having estado = 'SP' or estado = 'RJ';

-- fim.................................................................... 
use cadastro;
-- Agrupando registros
-- Exibir nome, carga e ano da tabela cursos
SELECT nome, SUM(carga) AS total_carga, ano
FROM cursos
GROUP BY nome, ano
ORDER BY ano;


-- Agrupar por: nome, carga e ano
select * from cursos
group by nome, carga, ano;

-- Ordenar por ano
select carga, count(carga) as qtd_dias from cursos
group by carga
order by carga;

-- mais.................................... 

USE Cadastro;
CREATE TABLE Vendas (
ID Smallint auto_increment Primary Key,
Nome_Vendedor Varchar(80),
Quantidade Int,
Produto Varchar(60),
Cidade Varchar(50),
UF Varchar (2)
);

INSERT INTO Vendas (ID, Nome_Vendedor, Quantidade, Produto, Cidade, UF)
VALUES
(default,'Luana',1800,'Celular','São Paulo', 'SP'),
(default,'Carla',2300,'Webcam','Recife', 'PE'),
(default,'Joao',1900,'Mouse','São Paulo', 'SP'),
(default,'Jorge',1700,'Webcam','Rio de Janeiro','RJ'),
(default,'Pedro',2120,'Celular','Recife', 'PE'),
(default,'andre',3980,'Mouse','São Paulo','SP'),
(default,'Fabiana',2120,'Webcam','Recife', 'PE'),
(default,'Rosana',1480,'Mouse','Rio de Janeiro','RJ'),
(default,'Roberto',4150,'Celular','Minas Gerais','MG'),
(default,'Rose',2100,'Celular','São Paulo','SP'),
(default,'Marcos',3200,'Mouse','Minas Gerais','MG'),
(default,'Davi',1500,'Webcam','Recife', 'PE'),
(default,'Marcelo',3010,'Mouse','Rio de Janeiro','RJ'),
(default,'Roberto',5620,'Celular','São Paulo','SP');
select * from vendas;

-- coulsulta usando agregação para obter o total de vendas de celular sem o group by
select sum(quantidade) as total_celular
from vendas
where produto = 'celular';

-- usando o group by
select cidade, sum(quantidade) as total
from vendas
group by cidade;

-- counsulta totalizando as vendas de todos os produtos por cidade, faça um filtro para encontrar RECIFE e SÃO PAULO (usando group by e having)
select cidade, sum(quantidade) as total
from vendas
group by cidade
having cidade = 'Recife';

select cidade, sum(quantidade) as total
from vendas
group by cidade
having cidade = 'São Paulo';

-- exercicio..................................... 
-- 1) Crie uma lista com as profissões dos alunos e seus respectivos quantitativos. Ou seja, quantos são programadores e assim sucessivamente 
use cadastro;
select profissao, count(profissao) as total
from alunos
group by profissao;

-- 2) Crie uma lista com as profissões dos alunos e seus respectivos quantitativos em ordem crescente. Ou seja, quantos são programadores e assim sucessivamente 
select profissao, count(profissao) as total
from alunos
group by profissao
order by total;

-- 3) Quantos alunos homens e quantas mulheres nasceram após 01/jan/2005, agrupar por sexo? 
select nascimento, count(nascimento) as total
from alunos
where nascimento > '2005-01-01' and sexo = 'M'
group by nascimento;

select nascimento, count(nascimento) as total
from alunos
where nascimento > '2005-01-01' and sexo = 'F'
group by nascimento;

-- 4) Criar uma lista com os alunos e alunas que nasceram fora do Brasil, mostrando o país de origem e o total de pessoas nascidas lá. Só nos interessam os países que tiverem mais de 3 alunos com essa 
-- nacionalidade. “Ou seja, saber quantas pessoas moram em cada um dos países que não seja o Brasil e só nos interessa os que tem mais de três alunos"
select nacionalidade , count(nacionalidade) as total
from alunos
where nacionalidade != 'Brasil'
group by nacionalidade
having total > 3;
select * from alunos;

-- 5) Criar uma lista agrupada pela altura dos alunos, exibindo quantas pessoas pesam mais de 100 kg e estão acima da média de altura de todos os cadastrados.
-- Passos a serem seguidos:
-- Calcular a média de altura de todos os alunos cadastrados.
-- Filtrar todas as pessoas que pesam mais de 100 kg.
-- Agrupar essas pessoas por altura e mostrar apenas aquelas que estão acima da média de altura calculada no passo 1.
select avg(altura) as media_altura from alunos;
select altura, count(*) from alunos
where peso > '100'
group by altura
having altura > (select avg(altura) from alunos)
order by altura;

-- fim .................................................. 

alter table alunos
add column cursopreferido int;
desc alunos;

-- cursopreferido é uma chave estrangeira, para fazer a ligação entre as tabelas alunos e cursos
alter table alunos
add foreign key (cursopreferido)
references cursos (idcurso);

 select*from cursos;

-- cadastrando os cursos preferidos dos alunos
update alunos
set cursopreferido = '6' where id='1'; -- 6 é o id do curso sql e 1 é o id do aluno Daniel Morais
select*from alunos;

update `cadastro`.`alunos` set `cursopreferido` = '22' where (`id` = '2');
update `cadastro`.`alunos` set `cursopreferido` = '12' where (`id` = '3');
update `cadastro`.`alunos` set `cursopreferido` = '7' where (`id` = '4');
update `cadastro`.`alunos` set `cursopreferido` = '1' where (`id` = '5');
update `cadastro`.`alunos` set `cursopreferido` = '8' where (`id` = '6');
update `cadastro`.`alunos` set `cursopreferido` = '4' where (`id` = '7');
update `cadastro`.`alunos` set `cursopreferido` = '5' where (`id` = '8');
update `cadastro`.`alunos` set `cursopreferido` = '3' where (`id` = '9');
update `cadastro`.`alunos` set `cursopreferido` = '30' where (`id` = '10');
update `cadastro`.`alunos` set `cursopreferido` = '22' where (`id` = '11');

-- fim...........................................................................

create database oficina;

use oficina;

create table cliente ( 
idcliente int primary key auto_increment,
nome varchar(30) not null,
sexo enum ('M', 'F') not null,
id_carro int unique
);

create table telefones ( 
idtelefone int primary key auto_increment,
tipo varchar(20),
numero varchar(11),
id_cliente int unique
);

create table marca ( 
idmarca int primary key auto_increment,
marca varchar(30) not null
);

create table carros ( 
idcarro int primary key auto_increment,
modelo varchar(30) not null,
placa varchar(7) not null,
id_marca int unique
);

create table cores ( 
idcor int primary key auto_increment,
cor varchar(30) not null
);

create table carro_cor ( 
id_carro int unique,
id_cor int unique
);

-- constraints é uma regra aplicada a uma ou maus colunas de uma tabela para impor restriçao aos dados que podem ser inseridos ou modificados
-- ou seja: não vou inserir qualquer informação nos campos da minha tabela
alter table telefones
add constraint fk_telefones_cliente
foreign key (id_cliente)
references cliente (idcliente);

alter table cliente
add constraint fk_cliente_carro
foreign key (id_carro)
references carros (idcarro);

alter table carros
add constraint fk_carro_marca
foreign key (id_marca)
references marca (idmarca);

-- inner join e outer join
-- inner join intersecção de tabelas
-- left join tabela da esquerda
-- right join tabela da direita
-- full outer join junta tudo

-- junção das tabelas
use cadastro;
select * from alunos;
select * from cursos;

-- quando faço isso ele faz uma relação com todos os cursos para cada aluno
select alunos.nome, alunos.cursopreferido, cursos.nome, cursos.ano
from alunos join cursos;

-- aqui podemos filtrar as coisas e, para criar um filtro, usa-se o on, que dá sentido ao join
select alunos.nome, alunos.cursopreferido, cursos.nome, cursos.ano
from alunos join cursos
on cursos.idcurso = alunos.cursopreferido
order by alunos.nome;

-- apelidos de colunas usando o as
-- from alunos as a join cursos as c;

select a.nome, a.cursopreferido, c.nome, c.ano
from alunos as a join cursos as c
on c.idcurso = a.cursopreferido
order by a.nome;

-- temos vários cursos, mas só apareceram esses alunos. Isso de deve ao fato dos outros alunos não terem cursos preferidos
-- inner join é um join somente com as relaçoes entre as duas tabelas
-- para considerar campos que não fazem parte, usamos o outer join. Se quiser usar a tabela da esquerda, o comando é left outer join, ou left join
-- para a direita usa right outer join ou right join

create table aluno_assiste_curso(
id int not null auto_increment,
data date,
idalunos int,
idcurso int,
primary key (id),
foreign key (idalunos) references alunos (id),
foreign key (idcurso) references cursos (idcurso)
);

insert into aluno_assiste_curso (data, idalunos, idcurso)
values
('2014-03-01', '1', '2'),
('2015-12-22', '3', '6'),
('2014-01-01', '22', '12'),
('2016-05-12', '1', '19');
select * from aluno_assiste_curso;

-- utilizando as tabelas alunos e aluno_assiste_curso, use join para relacionar o id da tabela alunos com o idalunos da tabela aluno_assiste_curso
-- mostre todos os dados da tabela
select a.*, ac.*
from alunos as a join aluno_assiste_curso as ac
where a.id = ac.idalunos
order by nome;

select alunos.nome, aluno_assiste_curso.idcurso from alunos
join aluno_assiste_curso
on alunos.id = aluno_assiste_curso.idalunos
order by alunos.nome;

-- agora não quero mais o código do curso, mas sim o nome do curso, só que o nome do curso está em uma terceira tabela

select alunos.nome, cursos.nome from alunos
join aluno_assiste_curso
on alunos.id = aluno_assiste_curso.idalunos
join cursos
on cursos.idcurso = aluno_assiste_curso.idcurso
order by alunos.nome;

-- para exibir todos os nomes da tabela alunos, mesmo que não seja relacionado a algum curso
select alunos.nome, cursos.nome from alunos
left join aluno_assiste_curso
on alunos.id = aluno_assiste_curso.idcurso
left join cursos
on cursos.idcurso = aluno_assiste_curso.idcurso;

select alunos.nome, cursos.nome from alunos
right join aluno_assiste_curso
on alunos.id = aluno_assiste_curso.idcurso
right join cursos
on cursos.idcurso = aluno_assiste_curso.idcurso;

-- exercicio joins

-- 1) Crie um banco de dados com o nome joins
create database joins;
use joins;

--  Crie uma tabela com o nome: AUTOR
/* Os campos da tabela autor são: 
 ID_AUTOR – os números deverão aparecer automaticamente, PK 
 NOME_AUTOR */

create table autor ( 
id_autor int primary key auto_increment,
nome_autor varchar(30) not null
);

/* 3) Crie uma tabela com o nome: LIVRO 
Os campos da tabela livro são: 
 ID_LIVRO – os números deverão aparecer automaticamente, PK (Chave 
Primaria) 
 NOME_LIVRO 
 FK_A (Chave estrangeira) da tabela autor, */

create table livro ( 
id_livro int primary key auto_increment,
nome_livro varchar(30) not null,
fk_a int,
foreign key (fk_a) references autor (id_autor)
);

/* 4) Insira os seguintes nomes na tabela Autor: 
 Luana Farias, 
 Ronaldo, 
 Marcos,  
 Alessandra, 
 Fabiano; */

insert into autor (nome_autor)
values
('Luana Farias'),
('Ronaldo'),
('Marcos'),
('Alessandra'),
('Fabiano');
select * from autor;

/*  Insira os seguintes dados na tabela Livro: 
 CSS, 5, 
 HTML, 1, 
 C++, 3, 
 Pyton, NULL, 
 PHP, 2; */

insert into livro (nome_livro, fk_a)
values
('CSS', '5'),
('HTML', '1'),
('C++', '3'),
('Python', null),
('PHP', '2');
select * from livro;

/* 8) Faça um INNER JOIN para mostrar as informações que estão em comum 
nas duas tabelas referente ao NOME_AUTOR e o NOME_LIVRO */
select nome_autor, nome_livro
from autor inner join livro
on autor.id_autor = livro.fk_a;

/*9) Faça um INNER JOIN para mostrar todos os nomes de autores e o 
NOME_LIVRO  */
select nome_autor, nome_livro
from autor
left join livro on autor.id_autor = livro.fk_a;

/* 10) Faça um INNER JOIN para mostrar todos os nomes dos Livros e o 
NOME_AUTOR */
select nome_autor, nome_livro
from autor
right join livro on autor.id_autor = livro.fk_a;

/* 11) Faça um INNER JOIN para mostrar todos os nomes dos Livros e dos 
autores  */
select nome_autor, nome_livro 
from autor
left join livro on autor.id_autor = livro.fk_a
union
select nome_autor, nome_livro from autor
right join livro
on autor.id_autor = livro.fk_a;

/*
3) Criar um modelo Físico para o Banco de dados comercio: 
*/

create database comercio;
use comercio;

create table cliente(
idcliente int primary key auto_increment,
nome varchar (30) not null,
sexo enum ('M', 'F') not null,
email varchar (50) unique,
cpf varchar (15) unique
);
desc cliente;

insert into cliente (nome, sexo, email, cpf)
values 	('João', 'M', 'joao@bol.com','76984352456'),
		('Carla', 'F', 'carla@bol.com','76984356699'),
		('Ana', 'F', 'ana@bol.com','76984357755'),
		('Clara', 'F', 'clara@bol.com','76984353344'),
		('Jorge', 'M', 'jorge@bol.com','76984352211'),
		('Celia', 'F', 'celia@bol.com','76984359988');
select * from cliente;
update cliente
set nome = 'Joao' where idcliente = 1;

create table endereco(
idendereco int primary key auto_increment,
rua varchar (30) not null,
bairro varchar (30) not null,
cidade varchar (30) not null,
estado varchar (2) not null,
id_cliente int unique,
foreign key (id_cliente) references cliente (idcliente) 
);
desc endereco;

insert into endereco (rua, bairro, cidade, estado, id_cliente)
values 	('Rua Antonio SA', 'Centro', 'B.Horizonte','MG', 4),
		('Rua Capitao Hermes', 'Centro', 'Rio de Janeiro', 'RJ', 1),
		('Rua Pres Vargas', 'Jardins', 'Sao Paulo', 'SP', 3),
		('Rua Alfandega', 'Estacio', 'Rio de Janeiro', 'RJ', 2),
		('Rua do Ouvidor', 'Flamengo', 'Rio de Janeiro', 'RJ', 6),
		('Rua Uruguaiana', 'Centro', 'Vitoria', 'ES', 5);
select * from endereco;

create table telefone(
idtelefone int primary key auto_increment,
tipo enum ('Res', 'Com', 'Cel') not null,
numero varchar (10) not null,
id_cliente int,
foreign key (id_cliente) references cliente (idcliente)
);
desc telefone;

insert into telefone (tipo, numero, id_cliente)
values 	('cel', '78458743', '5'),
		('res', '56576876', '5'),
		('cel', '87666898', '1'),
		('com', '54768899', '2'),
		('res', '78989765', '1'),
		('cel', '99766676', '3'),
        ('cel', '78458743', '3'),
        ('com', '66687899', '1'),
        ('res', '89986668', '5'),
        ('cel', '88687909', '2');
select * from telefone;


/*
4) Faça uma consulta na tabela cliente, mostrando os campos: nome, sexo, bairro e cidade, faça um join com a tabela endereco
Onde o idcliente da tabela cliente é igual a id_cliente da tabela endereco Filtrar por sexo Feminino e agrupar por nome 
Obs. o objetivo da cláusula ON é especificar as condições de adesão, ou seja, definir como as tabelas devem ser unidas. Especificamente, você define como os registros devem ser emparelhados. 
Em contraste, a finalidade da cláusula where é especificar as condições de filtragem, ou seja, definir quais linhas devem ser mantidas no conjunto de resultados. 
O ORDER BY é usado para classificar as linhas em uma tabela com base em uma ou mais colunas.
*/

select c.nome, c.sexo, e.bairro, e.cidade 
from cliente as c join endereco as e
on c.idcliente = e.id_cliente
where sexo = 'F'
order by nome;


/* 
5) Trabalhando com três tabelas. 
Faça uma consulta na tabela cliente, mostrando os campos: nome, sexo, bairro, cidade, tipo e numero faça um join com a tabela endereço Onde o idcliente é igual a telefone.id_cliente 
faça um join com a tabela telefone Onde o idcliente é igual a idtelefone Ordenar pelo nome 
*/

select c.nome, c.sexo, e.bairro, e.cidade, t.tipo, t.numero 
from cliente as c 
join endereco as e on e.id_cliente = c.idcliente
join telefone as t on t.id_cliente = c.idcliente 
order by c.nome;

/*
6) Faça uma consulta na tabela cliente, mostrando os campos: nome, sexo, cidade e numero, somente para as pessoas do sexo Masculino, ordenar pelo nome 
*/

select c.nome, c.sexo, e.cidade, t.numero 
from cliente as c 
join endereco as e on e.id_cliente = c.idcliente
join telefone as t on t.id_cliente = c.idcliente
where sexo = 'M' order by nome;

/*
7) Encontre o id, email, bairro, cidade e numero de telefone das pessoas que moram no centro da Cidade do Rio de Janeiro, ordenar pelo numero de telefone 
*/

select c.idcliente, c.email, e.bairro, e.cidade, t.
numero from cliente as c 
join endereco as e on e.id_cliente = c.idcliente 
join telefone as t on t.id_cliente = c.idcliente 
where e.bairro = 'Centro' and cidade = 'Rio de Janeiro' 
order by t.numero;

-- view no sql é uma consulta armazenada no banco de dados, que é derivada de uma ou mais tabelas existentes.alter
-- as views também são conhecidas como tabelas virtuais, ´pois não fazem parte do esquema físico da base
-- para criar uma view usamos: create view (nome) as
-- ex: "v notas"

desc cliente;
desc telefone;
desc endereco;

create view v_relatorio as
select c.nome, c.sexo, c.email, t.tipo, t.numero, e.bairro, e.cidade, e.estado from cliente c 
join telefone t 
on c.idcliente = t.id_cliente
join endereco e
on c.idcliente = e.id_cliente;
select * from v_relatorio;

-- para saber quais bancos de dados temos, usamos o comando show databases

-- crie uma consulta para mostrar nome, número e estado da view v_relatorio
select nome, numero, estado from v_relatorio;

-- deletando o nome Jorge da lista
delete from v_relatorio
where nome = Jorge;

-- não é possível excluir da visualização de adesão 'comercio.v_relatorio'

-- insira os dados abaixo na view: v_relatorio
-- Cida, F, cida@bol.com, cel 77994457, Centro, Vitoria, ES
insert into v_relatorio values
('Cida', 'F', 'cida@bol.com', 'Cel', '77994457', 'Centro', 'Vitória', 'ES');

-- NÃO É POSSÍVEL INSERIR NO JOIN VIEW COMERCIO V_RELATORIO SEM LISTA DE CAMPOS

-- fazendo atualizações: mude o nome Jorge para José
update v_relatorio
set nome = 'José'
where nome = 'Jorge';

-- é possível fazer updates 

-- faça uma consulta na view v_relario para mostrar todos os campos somente das mulheres, ordenar por nome 
select * from v_relatorio
where sexo = 'F'
order by 'nome';

-- adicione à tabela cliente uma coluna com o nome data_ult_compra tipo Date, as datas que serão adicionadas são:
-- do dia 01/08/2024 até 07/08/2024, para os idcliente em sequencia
alter table cliente
add column data_ult_compra date;
update cliente set data_ult_compra = '2024-08-01' where idcliente = '1';
update cliente set data_ult_compra = '2024-08-02' where idcliente = '2';
update cliente set data_ult_compra = '2024-08-03' where idcliente = '3';
update cliente set data_ult_compra = '2024-08-04' where idcliente = '4';
update cliente set data_ult_compra = '2024-08-05' where idcliente = '5';
update cliente set data_ult_compra = '2024-08-06' where idcliente = '6';
update cliente set data_ult_compra = '2024-08-07' where idcliente = '7';

-- adicione à tabela cliente uma coluna com o nome valor_compra tipo decimal
-- os valores que serão  adicionados são: de 1000 em 1000 até 7000, para o idcliente em sequência
alter table cliente
add column valor_compra decimal;
update cliente set valor_compra = '1000' where idcliente = '1';
update cliente set valor_compra = '2000' where idcliente = '2';
update cliente set valor_compra = '3000' where idcliente = '3';
update cliente set valor_compra = '4000' where idcliente = '4';
update cliente set valor_compra = '5000' where idcliente = '5';
update cliente set valor_compra = '6000' where idcliente = '6';
update cliente set valor_compra = '7000' where idcliente = '7';
select * from cliente;

-- faça uma alteração na view v_relatorio para acrescentar os novos campos criados, data_ult_compra (início) e valor_compra(final)
alter view v_relatorio as
select c.data_ult_compra,  c.nome, c.sexo, c.email, t.tipo, t.numero, e.bairro, e.cidade, e.estado, c.valor_compra from cliente c
join telefone t
on c.idcliente = t.id_cliente
join endereco e
on c.idcliente = e.id_cliente;
select * from v_relatorio;

-- utilizando as tabelas do banco de dados comercio crie uma view com o nome v_compraAcima3000 que armazene todas as colunas da tabela cliente:
-- a view deverá conter apenas compras com valores acime de 3000 reais
create view v_compraAcima3000 as
select * from cliente where valor_compra > 3000;

-- exercicio joins..........................................................................
/* 1 - Crie uma View para mostrar o valor total das compras efetuadas pelos 
clientes.  */
use cadastro;
create view valor_total as
select sum(valor_compra) from cliente;
select * from valor_total;

/* 2- Crie uma View para mostrar o menor valor de compras efetuadas pelos 
clientes.   */
create view menor_valor as
select min(valor_compra) from cliente;
select * from menor_valor;

/* 3- Crie uma View para mostrar a média do valor de compras efetuadas pelos 
clientes. */
create view media_valor as
select avg(valor_compra) from cliente;
select * from media_valor;

/* 4- Crie uma View para mostrar o maior valor de compras efetuadas pelos 
clientes.   */
create view max_valor as
select max(valor_compra) from cliente;
select * from max_valor;

/* 5- Crie uma View para mostrar o maior valor de compras efetuadas pelos 
clientes e o nome do cliente.  */
alter view max_valor_nome as
select nome, valor_compra from cliente
where valor_compra = (select max(valor_compra) from cliente);
select * from max_valor_nome;

-- Procedures podem ser denominadas como consultas avançadas, consiste em um bloco de codigo que possui um noome e pode ser armazenado no banco de dados.
-- Pode incluir uma série de comandos sql para executar alguma tarefa
-- São usadas para fazer tarefas repetitivas que não são possiveis em queries ou que dariam muito trabalho

-- Tipos de procedure:
-- Procedures com parâmetros
create procedure p_teste
(
@var1 as int,
@var2 as varchar(20)
);

-- Procedure sem parâmetros
create procedure teste()
begin
select 'teste' as T;
end;

-- Delimiter: alterar o delimiter é necessário para que o banco não pare no meio da leitura (;) de um procedure
-- Criando uma procedure
use cadastro;
DELIMITER $
CREATE PROCEDURE NOME_SENAI()
BEGIN
	SELECT 'ESCOLA SENAI' AS Nome_Escola;
END $
DELIMITER ;

-- Para chamar a procedure
call nome_senai();

-- Para apagar um procedure
-- drop procedure nome;

-- criar procedure com parâmetro para somar numeros:
delimiter $$
create procedure soma (n1 int, n2 int)
begin
select n1 + n2 as soma;
end $$
delimiter ;

call soma(200, 500);

-- As procedures são utilizadas normalmente para juntar vários queries em um único bloco de código
-- As procedures não terão um único retorno diferente das functions
-- exemplo 1: Crie uma procedure que atualiza o preço de um curso
-- Crie um banco de dados com o nome 'exemplo'
-- crie uma tabela p_curso
-- os dados sao:
/* id_curso int primary key
nome_ curso varchar (100)
preco_curso decimal (10,2) */
create database exemplo;
use exemplo;
create table p_curso(
id_curso int primary key auto_increment,
nome_curso varchar(100),
preco_curso decimal (10,2)
);

insert into p_curso (id_curso, nome_curso, preco_curso)
values 
('1', 'Excel', '500.00'),
('2', 'VBA', '280.00'),
('3', 'Power BI', '150.00');
select * from p_curso;

-- Criar uma procedure para atualizar os preços dos cursos
delimiter $
create procedure p_atualiza_preco (
novo_preco decimal (10,2),
id int)
begin
update p_curso
set preco_curso = novo_preco
where id_curso = id;
select 'Preço atualizado com sucesso!';
end $
delimiter ;

-- Atualizando o preço
call p_atualiza_preco (600, 1);
call p_atualiza_preco (330, 2);

-- criar uma procedure para cadastrar novos cursos, cadastre conforme as orientações abaixo
-- banco de dados, 1000
-- python, 1200

delimiter $
create procedure p_cadastrar_cursos (
id int,
nome varchar (100),
preco decimal(10,2)
)
begin
insert into p_curso
values
(null, nome, preco);
end $
delimiter ;

call p_cadastrar_cursos
(null, 'Banco de Dados', '1000');
call p_cadastrar_cursos
(null, 'Python', '1200');

-- Criar uma procedure para fazer acréscimo geral em todos os preços da tabela p_curso, aplique um acréscimo de 10%
delimiter $
create procedure p_acrescimo_geral
(acrescimo decimal (10,2))
begin
update p_curso
set preco_curso = preco_curso * (1 + acrescimo/100);
select 'Acréscimo atualizado com sucesso' as situacao;
end $
delimiter ;

drop procedure
p_acrescimo_geral;

select * from p_curso;
call p_acrescimo_geral (10);

update p_curso
set preco_curso = 660 where id_curso = 1;
update p_curso
set preco_curso = 363 where id_curso = 2;
update p_curso
set preco_curso = 165 where id_curso = 3;
update p_curso
set preco_curso = 1100 where id_curso = 4;
update p_curso
set preco_curso = 1320 where id_curso = 5;

-- Criar uma procedure para excluir cursos por id da tabela p_curso
delimiter $
create procedure p_excluir_cursos(
id int)
begin
	delete from p_curso
	where id_curso = id;
end $
delimiter ;

call p_excluir_cursos (6);
call p_excluir_cursos (5);

-- Excluindo procedure por nome do curso
delimiter $
create procedure p_excluir_curso_por_nome(
nome varchar(100))
begin
	delete from p_curso
    where nome_curso = nome;
end $
delimiter ;

call p_excluir_curso_por_nome ('VBA');
select * from p_curso;

-- EXERCÍCIOS.............................................................. 
-- CRIAR O BANCO DE DADOS ABAIXO: 
CREATE DATABASE PROJETO;  
USE PROJETO;  
CREATE TABLE NEW_CURSOS(  
IDCURSO INT PRIMARY KEY AUTO_INCREMENT,  
NOME VARCHAR(100) NOT NULL,  
HORAS INT NOT NULL,  
PRECO DECIMAL(10,2) NOT NULL  
);  
INSERT INTO NEW_CURSOS VALUES 
(NULL, 'JAVA', 30, 500.00), 
(NULL, 'BANCO DE DADOS', 30, 700.00);  
SELECT * FROM NEW_CURSOS;  

/* Exercício 1: 
Criar uma procedure para cadastrar os cursos abaixo, na tabela  
NEW_CURSOS: */
delimiter $
create procedure novos_cursos (
nome varchar (100),
horas int (5),
preco decimal(10,2)
)
begin
	insert into new_cursos
values
(nome, horas, preco);
end $
delimiter ;

drop procedure novos_cursos;

delimiter $
create procedure novos_cursos (
idcurso INT,
nome varchar (100),
horas int (5),
preco decimal(10,2)
)
begin
	insert into new_cursos
values
(idcurso, nome, horas, preco);
end $
delimiter ;

drop procedure novos_cursos;

delimiter $
create procedure novos_cursos (
idcurso INT,
nome varchar (100),
horas int (5),
preco decimal(10,2)
)
begin
	insert into new_cursos
values
(idcurso, nome, horas, preco);
end $
delimiter ;

call novos_cursos
(null, 'MySQL', '30', '100.00');
call novos_cursos
(null, 'Microsoft SQL Server', '35', '150.00');
call novos_cursos
(null, 'PostgreSQL', '40', '200.00');
call novos_cursos
(null, 'Oracle Database', '50', '250.00');

/* Exercício 2: 
CRIANDO UMA PROCEDURE PARA ATUALIZAR OS PREÇOS DA TABELA 
NEW_CURSOS, COMO SEGUE: */
delimiter $
create procedure preco_atualiza(
novo_preco decimal (10,2),
id int)
begin
update new_cursos
set preco = novo_preco
where idcurso = id;
select 'Preço atualizado com sucesso!';
end $
delimiter ;

drop procedure preco_atualiza;

delimiter $
create procedure preco_atualiza
(id_ajuste int,
preco_ajuste decimal(10,2)
)
begin
update new_cursos
set preco = preco * (1 + preco_ajuste/100)
where id_ajuste = idcurso;
select 'Acréscimo atualizado com sucesso' as situacao;
end $
delimiter ;

call preco_atualiza (1, 15.00);
call preco_atualiza (2, 18.00);
call preco_atualiza (3, 20.00);
call preco_atualiza (4, 22.00);
call preco_atualiza (5, 25.00);
call preco_atualiza (6, 28.00);
select * from new_cursos;

/* EXERCÍCIO 3 
CRIAR UMA PROCEDURE PARA ATUALIZAR OS PREÇOS DOS CURSOS 
DA TABELA NEW_CURSOS COMO SEGUE:  */

delimiter $
create procedure novos_precos
(id_ajuste int,
preco_ajuste decimal(10,2)
)
begin
update new_cursos
set preco = preco_ajuste
where id_ajuste = idcurso;
select 'Acréscimo atualizado com sucesso' as situacao;
end $
delimiter ;

drop procedure novos_precos;

delimiter $
create procedure novos_precos
(id_ajuste int,
preco_ajuste decimal(10,2)
)
begin
update new_cursos
set preco = preco_ajuste
where id_ajuste = idcurso;
select 'Acréscimo atualizado com sucesso' as situacao;
end $
delimiter ;

call novos_precos (1, 600.00);
call novos_precos (2, 800.00);
call novos_precos (3, 200.00);
call novos_precos (4, 250.00);
call novos_precos (5, 300.00);
call novos_precos (6, 350.00);
select * from new_cursos;

/* Exercício 4: 
Criar uma procedure para fazer um DESCONTO em todos os preços dos 
cursos da tabela NEW_CURSOS, aplique um DESCONTO de 35%. */
delimiter $
create procedure preco_atualiza
(id_ajuste int,
preco_ajuste decimal(10,2)
)
begin
update new_cursos
set preco = preco * (1 + preco_ajuste/100)
where id_ajuste = idcurso;
select 'Acréscimo atualizado com sucesso' as situacao;
end $
delimiter ;
use projeto;

call preco_atualiza (15, 1);
call preco_atualiza (18,2);
call preco_atualiza (20,3);
call preco_atualiza (22,4);
call preco_atualiza (25,5);
call preco_atualiza (28,6);
select * from new_cursos;

/* EXERCÍCIO 5 
CRIAR UMA PROCEDURE PARA EXCLUIR O CURSO POR ID  */
delimiter $
create procedure excluir_curso_id(
id int)
begin
	delete from new_cursos
	where id_curso = id;
end $
delimiter ;
call excluir_curso_id (5);
select * from new_cursos;

drop procedure excluir_curso_id;

delimiter $
create procedure excluir_curso_id(
id int)
begin
	delete from new_cursos
	where idcurso = id;
end $
delimiter ;
call excluir_curso_id (5);
select * from new_cursos;


/* EXERCÍCIO 6 
Criar uma procedure para EXCLUIR O CURSO POR NOME DO CURSO */
delimiter $
create procedure excluir_curso_nome(
nome varchar (100))
begin
	delete from new_cursos
	where nome_curso = nome;
end $
delimiter ;

drop procedure excluir_curso_nome;

delimiter $
create procedure excluir_curso_nome(
nome_curso varchar (100))
begin
	delete from new_cursos
	where nome_curso = nome;
end $
delimiter ;
call excluir_curso_nome('Oracle Database');
select * from new_cursos;

-- ......................................................................

-- Variáveis mySQL
-- Uma variável é um local onde armazenamos um determinado valor, que pode ser usado ao longo do código 
-- exemplo
set@var = 10;
set@nome = 'SQL';

-- uMA LOJA VENDEU 10 UNIDADES DE UM DETERMINADO PRODUTO A 10,90 REAIS cada. Utiliza variaveis para calcular a receita total gerada nessa venda
set @varQuantidade = 10;
set @varPreco = 10.9;
select (@varQuantidade * @varPreco) as 'Receita Total';
select round(@varQuantidade * @varPreco, 2) as 'Receita Total'; -- para arredondar

-- Funções condicionais são comandos que avaliam uma condição e retornam uma resposta diferente dependendo do valor da condição
-- exemplo
select 
if (10>5, 'Verdadeiro', 'Falso') as situação;
select 
if (10>12, 'Verdadeiro', 'Falso') as situação;

-- Uma empresa oferece um bônus de 10% para todos os funcionários que tiverem uma avaliação do RH de acordo com a seguinte regra
-- NotaDesempenho >=7 - Recebe um bônus de 10%
-- NotaDesempenho < 7 - Não recebe bônus
set @varNotaDesempenho = 8.5;
select
if (@varNotaDesempenho >= 7, 0.1, 'Sem Bônus') as bonus; -- 0.1 é o bonus de 10%

set @varNotaDesempenho = 5;
select
if (@varNotaDesempenho >= 7, 0.1, 'Sem Bônus') as bonus;

-- Uma empresa oferece um bônus de 10% e 5% para todos os funcionários que tiveram uma avalição de RH com a seguinte regra
-- NotaDesempenho >= 7 - Bônus de 10%
-- NotaDesempenho >= 5 - Bônus de 5%
-- NotaDesempenho < 5 - Sem Bônus

set @varNotaDesempenho = 9;
select 
if (@varNotaDesempenho >= 7, 'Recebe bônus de 10%',
if (@varNotaDesempenho >= 5, 'Recebe bônus de 5%', 'Não recebe bônus')) as 'Resultado';

set @varNotaDesempenho = 6;
select 
if (@varNotaDesempenho >= 7, 'Recebe bônus de 10%',
if (@varNotaDesempenho >= 5, 'Recebe bônus de 5%', 'Não recebe bônus')) as 'Resultado';

set @varNotaDesempenho = 2;
select 
if (@varNotaDesempenho >= 7, 'Recebe bônus de 10%',
if (@varNotaDesempenho >= 5, 'Recebe bônus de 5%', 'Não recebe bônus')) as 'Resultado';

use diversas_tabelas;
select * from lojas;

-- As lojas da nossa empresa que tiverem mais de 20 funcionários receberão uma reforma de ampliação. Utilize a função IF para criar uma coluna na tabela lojas
-- que informe quais lojas receberão reforma e quais não receberão reforma
select * from lojas;
select
*, -- acrescenta na tabela as infos abaixo também 3
if (num_funcionarios >= 20, 'Recebe reforma', 'Não recebe reforma')
as 'status' from lojas;

-- Funções IFNULL, ISNULL, NULLIF
-- IFNULL: Retorna o valor alternativo caso a expressão seja null
-- ifnull (expressão, valor alternativo)
-- Utilize a função ifnull para retornar um valor alternativo para o valor abaixo
select 
ifnull(null, 'Valor Alternativo') as tipo;

select
ifnull(100, 'Valor alternativo') as tipo;

-- A tabela lojas pode ter lojas que não possuem telefone de contato. Todas as lojas que tiverem um telefone null
-- serão  direcionadas para a central de atendimento, com o numero: 0800-999-9999. Utilize a funçao ifnull para fazer este ajuste
select * from lojas;
select 
*,
ifnull(Telefone, '0800-999-9999') AS 'Telefone corrigido'
from lojas;

-- ISNULL: Testa se determinado valor é null. Caso seja nulo, retorna 1, casa contrário, retorna 0

-- Alguns clientes não cadastraram seu telefone de contato. Faça uma consulta com uma coluna extra que identifique esses clientes de alguma forma
select * from clientes;
select 
*,
isnull(Telefone) as 'Check'
from clientes;

select 
*,
if(isnull(Telefone), 'Verificar', 'OK') as 'Status'
from clientes;

-- NULLIF: Compara duas expressões e retrna NULL se forem iguais. Caso contário, retorna a primeira expressão 
set @var1 = 100;
set @var2 = 100;
select 
nullif(@var1, @var2) as tipo;

set @var1 = 200;
set @var2 = 100;
select 
nullif(@var1, @var2) as tipo;

-- Exercicios
-- Determine a situação do aluno: Nota >= 6 "Aprovado", caso contrário: "Reprovado"
-- Defina a nota 9 como variável
set @var1 = 9;
select
if (@var1 >= 6, 'Aprovado', 'Reprovado');

/* 2- Crie um código para verificar a nota do aluno e determinar a situação: 
Aprovado: nota maior ou igual a 6 
Recuperação: nota entre 4 e 5 
Reprovado: nota abaixo de 4 */
set @var1 = 7;
select 
if (@var1 >= 6, 'Aprovado', 
if	(@var1 >= 4 and
    @var1 <= 5, 'Recuperação', 'Reprovado')) as Final;
    
/* 3- Crie um código para classificar o produto de acordo com o preço: 
Preço >= 40000: Luxo 
Preço >= 10000: Econômico 
Preço < 10000: Básico */
set @varProduto = 5000;
select
if (@varProduto >= 40000, 'Luxo',
if (@varProduto >= 10000, 'Econômico', 'Básico')) as Produto;
    
-- Case: outra estrutura condicional do SQL

/* CASE
when condicao1 then resultado1
when condicao2 then resultado2
when condicaoN then resultadoN
else resultado
end; */

-- Exemplo: Utilize a estrutura CASE para criar uma consulta na tabela clientes que substitue o valor M por Masculino e o F por feminino
use cadastro;
select
*,
case
	when Sexo = 'M' then 'Masculino'
    else 'Feminino'
end as 'Sexo 2'
from clientes;

-- Exemplo 2: Na tabela pedidos crie uma estrutura case para avaliar as seguintes situações de receita_venda:
-- Caso receita_venda >= 3000 "Faturamento Alto"
-- Caso receita_venda >= 1000 "Faturamento Médio"
-- Caso receita_venda < 1000 "Faturamento Baixo"
use diversas_tabelas;
select
*,
case
	when receita_venda >= 3000 then 'Faturamento Alto'
    when receita_venda >= 1000 then 'Faturamento Médio'
    else 'Faturamento Baixo'
end as 'Receita Vendas'
from pedidos;

-- Case/Then aplicações com and e or
-- Sintaxe and
select
*,
case 
	when condicao1 and condicao2 then resultado1
    else resultado2
end;

-- Sintaxe or
select
*,
case
when condicao1 or condicao2 then resultado1
else resultado2
end;

-- Aplicação end
-- Exemplo 1 usando a tabela clientes
-- A empresa está com uma promoção de dia das mães/pais. Como vai funcionar?
-- Caso a cliente seja do sexo Feminino e tenha filhos, receberá ofertas de dia das mães
-- Caso o cliente seja do sexo masculino e tenha filhos, receberá ofertas de dia dos pais
-- Caso contrário, não haverá ofertas
-- As ofertas serão enviadas por email, por isso o setor precisa de uma tabela para identificar
select
*,
case
	when sexo = 'F' and qtd_filhos >= 1 then 'Oferta dia das mães'
	when sexo = 'M' and qtd_filhos >= 1 then 'Oferta dia dos pais'
	else 'Sem Ofertas'
end as Situação
from clientes;
select * from clientes;

-- Aplicação or com tabela produtos
/* A empresa está com parceria  com empresas das marcas DELL e SAMSUNG. Isso significa que os produtos dessas marcas receberão
um desconto de 15% em seu custo de aquisição. Faça uma consulta que retorne uma coluna extra, indicando se as marcas receberão ou não um
desconto de 15% no custo e aquisição de cada produto */
select * from produtos;
select
*, 
case
	when marca_produto = 'Dell' or marca_produto = 'Samsung' then 'Desconto de 15%'
    else 'Sem desconto'
end as Desconto
from produtos;

select
    *,
    case
        when marca_produto = 'Dell' OR marca_produto = 'Samsung'
        then custo_unit - (custo_unit * 15 / 100)
        else custo_unit
    end as 'Valor com Desconto'
from produtos;

-- Faça uma consulta que retorne uma coluna extra, indicando o valor do preço com desconto no custo de aquisição de cada produto (usando in)
select
*,
case 
	when marca_produto in ('Dell', 'Samsung') 
    then (1-0.15) * custo_unit
    else custo_unit
end as 'Preço com desconto'
from produtos;


-- Atividades
/* A data de vencimento de um produto é no dia 10/06/23. Utilizando variáveis, faça um 
teste lógico para verificar se um produto passou da validade ou não. Compare com a 
data do dia 10/05/2023. */
set @varVencimento = '2023-06-10';
set @varDataVencimento = '2023-06-10';
select
case
when @varVencimento > @varDataVencimento then 'Está vencido'
else 'Está dentro do prazo de validade'
end as situação;

/* Exercício 2: 
Aplique um bônus de acordo com a situação abaixo: 
Use a Tabela Clientes do Banco de Dados: Diversas_Tabelas  
Faça para as colunas abaixo: 
ID_Cliente, 
Nome, 
Estado_Civil, 
Renda_Anual, 
Renda acima de 80000 recebe um bonus de 7% se for casado, se não recebe 5% 
Renda >= 60000 recebe um bonus de 10% 
Renda >= 40000 recebe um bonus de 15% 
Renda abaixo de < 40000 recebe um bonus de 20% 
O resultado deverá mostrar apenas o bônus, conforme exemplo: Bônus 0.1  */
select * from clientes;
select
*,
case
when renda_anual > 80000 and estado_civil = 'C'
	then '7% de desconto'
when renda_anual > 80000 and estado_civil = 'S'
	then '5% de desconto'
when renda_anual >= 60000
	then '10% de desconto'
when renda_anual >= 40000
	then '20% de desconto'
end as Bônus
from clientes;

/* Exercício 3: 
Utilizando a tabela clientes, faça uma consulta que retorne uma coluna extra, 
indicando o valor do bônus no custo de aquisição de cada produto. Exemplo: 
Bônus de 10%  */
select
*,
case
	when renda_anual > 80000 and estado_civil = 'C'
		then renda_anual * (7 / 100)
    when renda_anual > 80000 and estado_civil = 'S'
		then renda_anual * (5 / 100)
	when renda_anual >= 60000
		then renda_anual * (10 / 100)
	when renda_anual >= 40000
		 then renda_anual * (20 / 100)
	end as Bônus
from clientes;

/* Exercício 4: 
Utilizando a tabela clientes faça uma consulta que retorne uma coluna extra, indicando 
o valor do preço com bônus no custo de aquisição de cada produto, Exemplo: 66000.0  */
select
*,
case
	when renda_anual > 80000 and estado_civil = 'C'
		then renda_anual + (renda_anual * 7 / 100)
    when renda_anual > 80000 and estado_civil = 'S'
		then renda_anual + (renda_anual * 5 / 100)
	when renda_anual >= 60000
		then renda_anual + (renda_anual * 10 / 100)
	when renda_anual >= 40000
		 then renda_anual + (renda_anual * 20 / 100)
	end as Bônus
from clientes;

-- Funções
-- Uma função é uma rotina, um conjunto de instruções que pode salvar no banco de dados e executar quando quiser, sem a necessidade de criar o 
-- código do zero toda vez que você precisar dele 
-- Sintaxe
create function name_funcao (param1 tipo1, param2 tipo2)
resturns tipo deterministic
begin
	Instruções 1;
    Instruções 2;
    Instruções 3;
    return expressão
end $
delimiter ;
select nome_funcao (valor1, valor2);

-- Essa função adiciona a opção DETERMINISTIC para indicar que ela sempre retorna o mesmo resultado para os mesmo parâmetros de entrada.
-- Isso evita o erro de registro binário que pode ocorrer ao criar funções em SQL
-- Os elementos begin e end tem o objetivo de iniciar e finalizar, respectivamente, um bloco de comandos, de maneira que este possa
-- ser posteriormente executado. Podemos aninhar blocos de comando utilizando esses elementos. 
-- A função return é usada para retornar de uma rotina. Para funções ou métodos SQL ele retorna o resultado daa função  ou métodos para um procedimento SQL

-- Exemplo 1: Cria uma função que retorna o texto: "Como vai, _________, tudo bem?
use cadastro;
delimiter $
create function _fn_BoasVindas (nome varchar (100))
returns varchar (100) deterministic 
begin
return concat('Bem vindo, ', nome, ', tudo bem?');
end $
delimiter ;
select _fn_BoasVindas('Carla') as 'Bom dia!';

-- Exemplo 2 crie uma função chamada fn_faturamento que receba como parâmetros de entrada o preço (decimal) e a quantidade (int) e retorne o faturamento 
-- da venda, representado pela multiplicação entre o preço e quantidade.
delimiter $
create function fn_Faturamento (preco decimal (10,2), quantidade int)
returns decimal (10,2) deterministic
begin
	return preco * quantidade;
end $
delimiter ;
select fn_faturamento (133,7) as 'Faturamento';

-- Exemplo 3 
-- Crie uma função que substitua de um texto os caracteres com acentos para caracteres sem acento. 
delimiter $
create function fn_removeacentos (texto varchar(100))
returns varchar(100) deterministic
begin
set texto = replace(texto, 'á','a'),
	texto = replace(texto, 'ç','c'),
	texto = replace(texto, 'à','a'),
	texto = replace(texto, 'â','a'),
    texto = replace(texto, 'é','e'),
	texto = replace(texto, 'ê','e'),
	texto = replace(texto, 'í','i'),
    texto = replace(texto, 'ã','a'),
    texto = replace(texto, 'ó','o'),
    texto = replace(texto, 'ô','o'),
    texto = replace(texto, 'õ','o'),
    texto = replace(texto, 'ú','u');
return texto;
end $
delimiter ;
select fn_RemoveAcentos ('à aliança da discípula alemã') as Remove_Acento;
select fn_RemoveAcentos ('Olá, você está bem, Müller?') as Remove_Acento;
select fn_RemoveAcentos ('João entrou no ônibus com carrinho de rolemã') as Remove_Acento;

-- Exemplo 4: criando uma function para obter a data de hoje
delimiter $
create function data_hoje()
returns date
deterministic 
begin 
	return curdate();
end $
delimiter ;
select data_hoje();

-- Exemplo 5: Criando uma function para obter a data de hoje + 20 dias
delimiter $
create function data_mais_20_dias()
returns date 
deterministic
begin
	return date_add(curdate(), interval 20 day);
end $
delimiter ;
select data_mais_20_dias();

delimiter $
create function data_mais_2_anos_5_meses_18_dias()
returns date
deterministic
begin
	return date_add(curdate(), interval 2 year) + interval 5 month + interval 8 day;
end $
delimiter ;
select data_mais_2_anos_5_meses_18_dias(); -- resultado com 8 dias, não 18

use exemplo;

-- Exemplo 7: Utilizando a tabela funcionarios, vamos descobrir o tempo de serviço ds funcionários da empresa
delimiter $
create function tempo_servico (data_inicio date)
returns int
deterministic
begin
	declare data_atual DATE;
    select current_date () into data_atual;
    return year (data_atual) - year (data_inicio);
end $
delimiter ;
select id_funcionario, nome, sobrenome, tempo_servico (data_contratacao) as 'tempo de serviço' from funcionarios;

-- Exercícios ........................................................
/* Exercício 1. 
Crie uma função que retorna o seguinte texto: “Olá ____, ao curso de Banco de dados! 
”. 
Concatenar com a frase: Seja bem-vindo(a) 
O resultado ficará conforme imagem abaixo: substituindo nome pelo seu nome  */
delimiter $
create function _fn_BoasVindas (nome varchar (100))
returns varchar (100) deterministic 
begin
return concat('Olá, ', nome, ', ao curso de Banco de Dados! ');
end $
delimiter ;
select _fn_BoasVindas('Carla') as 'Seja bem vindo!';
drop function _fn_BoasVindas;

delimiter $
create function _fn_BoasVindas (nome varchar (100))
returns varchar (100) deterministic 
begin
return concat('Olá, ', nome, ', bem vindo ao curso de Banco de Dados! ');
end $
delimiter ;
select _fn_BoasVindas('Carla') as 'Seja bem vindo!';

/* Exercício 2: 
Crie uma função chamada fn_Total_Vendas, que receba como parâmetros de entrada 
o preço (DECIMAL) e a quantidade (INT), e retorne o total da venda, representado 
pela multiplicação entre o preço e quantidade. 
 */
delimiter $
create function fn_total_vendas (preco decimal (10,2), quantidade int)
returns decimal (10,2) deterministic
begin
	return preco * quantidade;
end $
delimiter ;
select fn_total_vendas (133,7) as 'Faturamento';

/* Utilizando o banco de dados diversas_tabelas, remova os acentos da coluna endereço 
da tabela lojas. 
Exibir apenas os campos loja e endereco */
use diversas_tabelas;
select * from lojas;
delimiter $
create function remove_acentos (texto varchar(100))
returns varchar(100) deterministic
begin
set texto = replace(texto, 'á','a'),
	texto = replace(texto, 'ç','c'),
	texto = replace(texto, 'à','a'),
	texto = replace(texto, 'â','a'),
    texto = replace(texto, 'é','e'),
	texto = replace(texto, 'ê','e'),
	texto = replace(texto, 'í','i'),
    texto = replace(texto, 'ã','a'),
    texto = replace(texto, 'ó','o'),
    texto = replace(texto, 'ô','o'),
    texto = replace(texto, 'õ','o'),
    texto = replace(texto, 'ú','u');
return texto;
end $
delimiter ;
select remove_acentos from lojas as Remover_Acento;

drop function remove_acentos;

use diversas_tabelas;


select * from lojas;
delimiter $
create function remove_acentos (texto varchar(100))
returns varchar(100) deterministic
begin
    set texto = replace(texto, 'á','a');
    set texto = replace(texto, 'à','a');
    set texto = replace(texto, 'ã','a');
    set texto = replace(texto, 'â','a');
    set texto = replace(texto, 'é','e');
    set texto = replace(texto, 'ê','e');
    set texto = replace(texto, 'í','i');
    set texto = replace(texto, 'ó','o');
    set texto = replace(texto, 'ô','o');
    set texto = replace(texto, 'õ','o');
    set texto = replace(texto, 'ú','u');
    set texto = replace(texto, 'ç','c');
    return texto;
end $
delimiter ;
select loja, remove_acentos(endereco) as endereco_sem_acentos from lojas;


/* Exercício: 4 
Crie uma função para obter a data de hoje + 5 anos  */
delimiter $
create function data_mais_5_anos()
returns date 
deterministic
begin
	return date_add(curdate(), interval 5 year);
end $
delimiter ;
select data_mais_5_anos();

/* Exercício: 5 
Crie uma função para obter a data de hoje menos 2 anos, 11 meses e 29 dias. */
delimiter $
create function data_menos_2_anos_11_meses_29_dias()
returns date
deterministic
begin
	return date_add(curdate(), interval 2 year) - interval 11 month - interval 29 day;
end $
delimiter ;
select  data_menos_2_anos_11_meses_29_dias();

drop function data_menos_2_anos_11_meses_29_dias;

delimiter $
create function data_menos_2_anos_11_meses_29_dias()
returns date
deterministic
begin
	return date_sub(curdate(), interval 2 year) - interval 11 month - interval 29 day;
end $
delimiter ;
select  data_menos_2_anos_11_meses_29_dias();


-- Comandos TCL (Transact Control Language)
/* O SQL possui um grupo de comandos especial chamado commit e rollback. Estes comandos TCL permitem que se controle as transações
de DML (Linguage de Manipulação de Dados) - insert, update, delete - dentro de um banco de dados 
start transaction -- inicia uma transação no banco de dados
commit -- salva alterações no banco de dados
rollback -- desfazer as alterações e cancelar a transação
set autocommit = 0 -- para encerrar o comando */

/* 1 - Crie um banco de dados TCL
2 - Crie uma tabela com o nome dados, na tabela dados. Deve conter os campos:
ID - int, not null, auto_increment e primary key
nome - varchar (100)
endereço - varchar (100)
cpf - varchar (12)
sexo - enum (M e F) 

3 - Insira, a sua escolha, três nomes, endereços, cpf e sexo 
insert into dados 
values
() */

create database dados;
use dados;

create table dados (
id int not null auto_increment primary key,
nome varchar (100),
endereco varchar (100),
cpf varchar (12),
sexo enum ('M' , 'F')
);
SELECT * FROM DADOS;

insert into dados (id, nome, endereco, cpf, sexo)
values
(NULL, 'Carla Machado', 'Rua dos Alfeneiros, 4', 12345678910, 'F'),
(NULL, 'Jack Torrance', 'Overlook Hotel, 666', 98765432100, 'M'),
(NULL, 'Jim Rennie', 'Rua Principal, 1', 66666666666, 'M');

drop table dados;

create table dados (
id int not null auto_increment primary key,
nome varchar (100),
endereco varchar (100),
cpf varchar (12),
sexo enum ('M' , 'F')
);

insert into dados (id, nome, endereco, cpf, sexo)
values
(NULL, 'Carla Machado', 'Rua dos Alfeneiros, 4', 12345678910, 'F'),
(NULL, 'Jack Torrance', 'Overlook Hotel, 666', 98765432100, 'M'),
(NULL, 'Jim Rennie', 'Rua Principal, 1', 66666666666, 'M');

-- mudar conteudo dos dados
update dados 
set nome = 'Vânia'
where id = 1;
SELECT * FROM DADOS;

create table cliente(
  id int generated always as identity primary key,
  nome varchar(150) not null,
  cpf char(11) not null unique,
  data_cadastro timestamp default current_timestamp
);

create table carro(
  id int generated always as identity primary key,
  modelo varchar(150) not null,
  data_cadastro timestamp default current_timestamp
);

create table venda(
  id int generated always as identity primary key,
  data_venda timestamp default current_timestamp,
  id_cliente int not null,
  id_carro int not null,
  
  constraint fk_venda_cliente
    foreign key (id_cliente)
    references cliente (id),
    
  constraint fk_venda_carro
    foreign key (id_carro)
    references carro (id)
);


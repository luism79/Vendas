with cteVendasValidas as (
    select
        c.id id_cliente,
        c.nome,
        c.cpf,
        ca.id id_carro,
        ca.modelo,
        ca.data_cadastro,
        v.data_venda,
        count(v.id_carro) over (partition by c.id) as qtde_carros_cliente
    from cliente c
    join venda v on v.id_cliente = c.id
    join carro ca on ca.id = v.id_carro
    where left(c.cpf, 1) = '0' --apenas cpd que inciam com zero
      and lower(ca.modelo) = 'marea'
      and extract(year from ca.data_cadastro) = 2021
) 
select
    id_cliente,
    id_carro, 
    cpf,
    modelo,
    data_cadastro,
    data_venda
from cteVendasValidas
where qtde_carros_cliente = 1 -- desclassifica quem comprou 2 carros
order by data_venda  -- ordem por data de venda
limit 15;
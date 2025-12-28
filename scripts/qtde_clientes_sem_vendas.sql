select count(*) qtde_clientes_sem_venda
from cliente a
where not exists(select 'x'
                 from venda v
                 where v.id_cliente = a.id)

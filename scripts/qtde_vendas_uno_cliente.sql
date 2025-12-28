select c.nome, count(c.id) qtde_venda
from venda a
  join carro b on a.id_carro = b.id
  join cliente c on a.id_cliente = c.id
where lower(b.modelo) = 'uno'
group by c.nome;


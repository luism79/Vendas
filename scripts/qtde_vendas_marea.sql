select count(c.id) qtde_venda
from venda v
  join carro c on v.id_carro = c.id
where lower(c.modelo) = 'marea';

SELECT * FROM produtos;
SELECT * FROM vendas;

CALL realizar_venda(1, 2);

-- Vai dar erro pois não temos 100 unidades do Produto B
CALL realizar_venda(2, 100); 

-- Vai dar erro pois o produto de ID 99 não existe
CALL realizar_venda(99, 1);
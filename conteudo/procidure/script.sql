CREATE OR REPLACE PROCEDURE realizar_venda(IN p_produto_id integer, IN p_quantidade integer)
 LANGUAGE plpgsql
AS $procedure$
declare
  v_preco numeric(10,2);
  v_estoque integer;
  v_total numeric(10,2);
BEGIN
  SELECT preco, estoque INTO v_preco, v_estoque FROM produtos WHERE id = p_produto_id;

  if (v_preco is null) then
    raise notice 'Erro: Produto não encontrado!';

  elseif (v_estoque < p_quantidade) then
    raise notice 'Erro: Estoque insuficiente!';

  else
    v_total := v_preco * p_quantidade;

    insert into vendas (produto_id, quantidade, valor_total) 
    values (p_produto_id, p_quantidade, v_total);

    update produtos set estoque = estoque - p_quantidade where id = p_produto_id;

    raise notice 'Venda realizada com sucesso! Total: R$ %', v_total;

  end if;
END;
$procedure$;
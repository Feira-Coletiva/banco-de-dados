/*Listar cadastros no banco*/
SELECT v.id, v.nome, o.id, o.titulo, o.disp_status FROM ofertas as o
JOIN produtos as p ON v.id = o.vendedor_id;
/*Retornar os dados do banco*/
SELECT o.id, o.titulo, o.descricao, o.disp_status, p.id, p.nome, p.preco, p.qtd_estoque FROM ofertas as o JOIN produtos as p WHERE o.id = p.id_oferta;

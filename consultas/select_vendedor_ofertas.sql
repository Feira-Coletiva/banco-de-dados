/*Listar cadastros no banco*/
SELECT v.id, v.nome, o.id, o.titulo, o.disp_status FROM vendedores as v
JOIN ofertas as o ON v.id = o.vendedor_id;
/*Retornar os dados do banco*/
SELECT o.id, o.titulo, o.descricao, o.disp_status, v.id, v.telefone, v.chave_pix FROM ofertas as o JOIN vendedores as v WHERE o.id_vendedor = v.id;
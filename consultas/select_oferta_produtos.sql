/*Listar cadastros no banco*/
SELECT o.titulo, o.descricao FROM ofertas as o JOIN produtos as p WHERE o.id = p.idOferta;
/*Retornar os dados do banco*/
SELECT * FROM categorias WHERE id=1;
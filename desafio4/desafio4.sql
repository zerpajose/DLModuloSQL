BEGIN TRANSACTION;
INSERT INTO compra (id, cliente_id, fecha) VALUES (33, 1, CURRENT_DATE);
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (9, 33, 5);
UPDATE producto SET stock = (SELECT stock FROM producto WHERE id = 9)-5 WHERE id = 9;
COMMIT;

-- ERROR:  el nuevo registro para la relación «producto» viola la restricción «check» «stock_valido»

BEGIN TRANSACTION;
INSERT INTO compra (id, cliente_id, fecha) VALUES (33, 2, CURRENT_DATE);
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (1, 33, 3);
UPDATE producto SET stock = (SELECT stock FROM producto WHERE id = 1)-3 WHERE id = 1;

INSERT INTO compra (id, cliente_id, fecha) VALUES (34, 2, CURRENT_DATE);
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (2, 34, 3);
UPDATE producto SET stock = (SELECT stock FROM producto WHERE id = 2)-3 WHERE id = 2;

INSERT INTO compra (id, cliente_id, fecha) VALUES (35, 2, CURRENT_DATE);
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (3, 35, 3);
UPDATE producto SET stock = (SELECT stock FROM producto WHERE id = 3)-3 WHERE id = 3;
COMMIT;

-- Query returned successfully in 36 msec.


SAVEPOINT punto_guardado;
INSERT INTO cliente (id, nombre, email) VALUES (11, 'usuario011', 'usuario011@gmail.com');
SELECT * FROM cliente WHERE id = 11;
ROLLBACK TO SAVEPOINT punto_guardado;
SELECT * FROM cliente;

-- Query returned successfully in 36 msec.
 
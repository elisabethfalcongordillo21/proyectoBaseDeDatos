use proyecto;
 
-- 1. Clientes que han realizado algún pedido
SELECT nombre FROM cliente
WHERE id_cliente IN (SELECT DISTINCT id_cliente FROM pedido);
 
-- 2. Clientes que NO han realizado ningún pedido
SELECT nombre FROM cliente
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM pedido);
 
-- 3. Productos que nunca han sido reseñados
SELECT nombre FROM producto
WHERE id_producto NOT IN (SELECT DISTINCT id_producto FROM reseña);
 
-- 4. Productos con precio superior al precio medio de todos los productos
SELECT nombre, precio FROM producto
WHERE precio > (SELECT AVG(precio) FROM producto);
 
-- 5. Empleados con salario superior al salario medio
SELECT nombre, salario FROM empleado
WHERE salario > (SELECT AVG(salario) FROM empleado);
 
-- 6. Cliente que realizó el pedido más reciente
SELECT nombre FROM cliente
WHERE id_cliente = (
    SELECT id_cliente FROM pedido
    ORDER BY fecha_pedido DESC
    LIMIT 1
);
 
-- 7. Productos que están en el stock mínimo (cantidad menor al promedio de stock)
SELECT nombre FROM producto
WHERE id_producto IN (
    SELECT id_producto FROM stock
    WHERE cantidad_stock < (SELECT AVG(cantidad_stock) FROM stock)
);
 
-- 8. Incidencias gestionadas por el empleado con mayor salario
SELECT descripcion, estado FROM incidencia
WHERE id_incidencia IN (
    SELECT id_incidencia FROM gestion_incidencia
    WHERE id_empleado = (SELECT id_empleado FROM empleado ORDER BY salario DESC LIMIT 1)
);
 
-- 9. Clientes con incidencias en estado 'Pendiente'
SELECT nombre FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente FROM cliente_incidencia
    WHERE id_incidencia IN (
        SELECT id_incidencia FROM incidencia WHERE estado = 'Pendiente'
    )
);
 
-- 10. Productos más caros que el producto más barato de tipo 'digital'
SELECT nombre, precio FROM producto
WHERE precio > (
    SELECT MIN(precio) FROM producto WHERE tipo = 'digital'
);
 
-- 11. Empleados que NO gestionan ninguna incidencia
SELECT nombre FROM empleado
WHERE id_empleado NOT IN (SELECT DISTINCT id_empleado FROM gestion_incidencia);
 
-- 12. Pedidos cuya dirección es de Sevilla
SELECT id_pedido, fecha_pedido FROM pedido
WHERE id_direccion IN (
    SELECT id_direccion FROM direccion WHERE localidad = 'Sevilla'
);
 
-- 13. Clientes VIP que tienen al menos una incidencia
SELECT nombre, tipo FROM cliente
WHERE tipo = 'VIP'
AND id_cliente IN (SELECT DISTINCT id_cliente FROM cliente_incidencia);
 
-- 14. Producto con el stock más alto
SELECT nombre FROM producto
WHERE id_producto = (
    SELECT id_producto FROM stock ORDER BY cantidad_stock DESC LIMIT 1
);
 
-- 15. Producto con el stock más bajo
SELECT nombre FROM producto
WHERE id_producto = (
    SELECT id_producto FROM stock ORDER BY cantidad_stock ASC LIMIT 1
);
 
-- 16. Clientes que han comprado productos de tipo 'digital'
SELECT DISTINCT c.nombre
FROM cliente c
WHERE c.id_cliente IN (
    SELECT p.id_cliente FROM pedido p
    WHERE p.id_pedido IN (
        SELECT pp.id_pedido FROM pedido_producto pp
        WHERE pp.id_producto IN (
            SELECT id_producto FROM producto WHERE tipo = 'digital'
        )
    )
);
 
-- 17. Reseñas de productos con precio superior a 100€
SELECT contenido, puntuacion FROM reseña
WHERE id_producto IN (
    SELECT id_producto FROM producto WHERE precio > 100
);
 
-- 18. Empleado con menor salario
SELECT nombre, salario FROM empleado
WHERE salario = (SELECT MIN(salario) FROM empleado);
 
-- 19. Empleado con mayor salario
SELECT nombre, salario FROM empleado
WHERE salario = (SELECT MAX(salario) FROM empleado);
 
-- 20. Clientes activos que han hecho al menos un pedido
SELECT nombre FROM cliente
WHERE estatus = 'Activo'
AND id_cliente IN (SELECT DISTINCT id_cliente FROM pedido);
 
-- 21. Productos con puntuación media superior a la media global de puntuaciones
SELECT nombre FROM producto
WHERE id_producto IN (
    SELECT id_producto FROM reseña
    GROUP BY id_producto
    HAVING AVG(puntuacion) > (SELECT AVG(puntuacion) FROM reseña)
);
 
-- 22. Pedidos realizados por clientes Premium
SELECT id_pedido, fecha_pedido FROM pedido
WHERE id_cliente IN (
    SELECT id_cliente FROM cliente WHERE tipo = 'Premium'
);
 
-- 23. Incidencias que NO han sido asignadas a ningún empleado
SELECT descripcion, estado FROM incidencia
WHERE id_incidencia NOT IN (SELECT DISTINCT id_incidencia FROM gestion_incidencia);
 
-- 24. Clientes cuya dirección de envío es de Málaga
SELECT c.nombre FROM cliente c
WHERE c.id_cliente IN (
    SELECT p.id_cliente FROM pedido p
    WHERE p.id_direccion IN (
        SELECT id_direccion FROM direccion WHERE localidad = 'Málaga'
    )
);
 
-- 25. Productos que han sido pedidos al menos una vez
SELECT nombre FROM producto
WHERE id_producto IN (SELECT DISTINCT id_producto FROM pedido_producto);
 
-- 26. Clientes con más pedidos que la media de pedidos por cliente
SELECT nombre FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente FROM pedido
    GROUP BY id_cliente
    HAVING COUNT(*) > (
        SELECT AVG(total) FROM (
            SELECT COUNT(*) AS total FROM pedido GROUP BY id_cliente
        ) AS sub
    )
);
 
-- 27. Reseñas con puntuación igual a la puntuación máxima registrada
SELECT contenido, puntuacion FROM reseña
WHERE puntuacion = (SELECT MAX(puntuacion) FROM reseña);
 
-- 28. Reseñas con puntuación igual a la puntuación mínima registrada
SELECT contenido, puntuacion FROM reseña
WHERE puntuacion = (SELECT MIN(puntuacion) FROM reseña);
 
-- 29. Clientes inactivos que tienen incidencias en estado 'En progreso'
SELECT c.nombre, c.estatus FROM cliente c
WHERE c.estatus = 'Inactivo'
AND c.id_cliente IN (
    SELECT ci.id_cliente FROM cliente_incidencia ci
    WHERE ci.id_incidencia IN (
        SELECT id_incidencia FROM incidencia WHERE estado = 'En progreso'
    )
);
 
-- 30. Productos físicos con stock por debajo de 50 unidades
SELECT nombre FROM producto
WHERE tipo = 'fisico'
AND id_producto IN (
    SELECT id_producto FROM stock WHERE cantidad_stock < 50
);
 
-- 31. Pedidos pagados con PayPal
SELECT id_pedido, fecha_pedido FROM pedido
WHERE id_pedido IN (
    SELECT id_pedido FROM metodo_pago WHERE tipo = 'PayPal'
);
 
-- 32. Clientes que han dejado reseñas negativas (puntuación <= 2)
SELECT DISTINCT nombre FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente FROM reseña WHERE puntuacion <= 2
);
 
-- 33. Empleados que gestionan incidencias de clientes VIP
SELECT DISTINCT nombre FROM empleado
WHERE id_empleado IN (
    SELECT id_empleado FROM gestion_incidencia
    WHERE id_incidencia IN (
        SELECT id_incidencia FROM cliente_incidencia
        WHERE id_cliente IN (
            SELECT id_cliente FROM cliente WHERE tipo = 'VIP'
        )
    )
);
 
-- 34. Productos digitales con stock superior al promedio de stock de productos digitales
SELECT nombre FROM producto
WHERE tipo = 'digital'
AND id_producto IN (
    SELECT id_producto FROM stock
    WHERE cantidad_stock > (
        SELECT AVG(s.cantidad_stock) FROM stock s
        INNER JOIN producto p ON s.id_producto = p.id_producto
        WHERE p.tipo = 'digital'
    )
);
 
-- 35. Pedidos entregados en enero de 2025 a clientes activos
SELECT id_pedido FROM pedido
WHERE fecha_entrega BETWEEN '2025-01-01' AND '2025-01-31'
AND id_cliente IN (
    SELECT id_cliente FROM cliente WHERE estatus = 'Activo'
);
 
-- 36. Clientes que han comprado el producto más caro
SELECT nombre FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente FROM pedido
    WHERE id_pedido IN (
        SELECT id_pedido FROM pedido_producto
        WHERE id_producto = (
            SELECT id_producto FROM producto ORDER BY precio DESC LIMIT 1
        )
    )
);
 
-- 37. Incidencias resueltas gestionadas por empleados con salario > 1500
SELECT descripcion FROM incidencia
WHERE estado = 'Resuelto'
AND id_incidencia IN (
    SELECT id_incidencia FROM gestion_incidencia
    WHERE id_empleado IN (
        SELECT id_empleado FROM empleado WHERE salario > 1500
    )
);
 
-- 38. Clientes con reseñas en productos con stock crítico (menos de 20 unidades)
SELECT DISTINCT c.nombre FROM cliente c
WHERE c.id_cliente IN (
    SELECT r.id_cliente FROM reseña r
    WHERE r.id_producto IN (
        SELECT id_producto FROM stock WHERE cantidad_stock < 20
    )
);
 
-- 39. Número de incidencias por cliente, solo los que tienen más de 1
SELECT c.nombre, COUNT(*) AS total_incidencias
FROM cliente_incidencia ci
INNER JOIN cliente c ON ci.id_cliente = c.id_cliente
GROUP BY c.nombre
HAVING COUNT(*) > (SELECT 1);
 
-- 40. Productos con el precio más alto dentro de su tipo
SELECT nombre, precio, tipo FROM producto p1
WHERE precio = (
    SELECT MAX(precio) FROM producto p2 WHERE p2.tipo = p1.tipo
);

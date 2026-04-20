use proyecto;
-- crear usuarios y dar permisos
CREATE USER 'admin_proyecto'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON PROYECTO.* TO 'admin_proyecto'@'localhost';

CREATE USER 'gestor_stock'@'localhost' IDENTIFIED BY '12345';
GRANT SELECT, INSERT, UPDATE, DELETE ON PROYECTO.producto TO 'gestor_stock'@'localhost';
GRANT SELECT, INSERT, UPDATE ON PROYECTO.stock TO 'gestor_stock'@'localhost';
GRANT SELECT ON PROYECTO.pedido TO 'gestor_stock'@'localhost';
GRANT SELECT ON PROYECTO.pedido_producto TO 'gestor_stock'@'localhost';
GRANT SELECT ON PROYECTO.direccion TO 'gestor_stock'@'localhost';

CREATE USER 'soporte_user'@'localhost' IDENTIFIED BY '123456';
GRANT SELECT, INSERT, UPDATE ON PROYECTO.incidencia TO 'soporte_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON PROYECTO.gestion_incidencia TO 'soporte_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON PROYECTO.cliente_incidencia TO 'soporte_user'@'localhost';
GRANT SELECT ON PROYECTO.cliente TO 'soporte_user'@'localhost';
GRANT SELECT ON PROYECTO.pedido TO 'soporte_user'@'localhost';
GRANT SELECT ON PROYECTO.reseña TO 'soporte_user'@'localhost';

CREATE USER 'app_user'@'localhost' IDENTIFIED BY '1234567';
GRANT SELECT ON PROYECTO.producto TO 'app_user'@'localhost';
GRANT SELECT ON PROYECTO.reseña TO 'app_user'@'localhost';
GRANT SELECT ON PROYECTO.stock TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON PROYECTO.usuario TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON PROYECTO.cliente TO 'app_user'@'localhost';
GRANT INSERT, SELECT ON PROYECTO.pedido TO 'app_user'@'localhost';
GRANT INSERT, SELECT ON PROYECTO.pedido_producto TO 'app_user'@'localhost';
GRANT INSERT, SELECT ON PROYECTO.metodo_pago TO 'app_user'@'localhost';
GRANT INSERT, SELECT ON PROYECTO.direccion TO 'app_user'@'localhost';
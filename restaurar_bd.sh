#!/bin/bash
echo "==> Restaurando base de datos peluqueria_canina_db..."
docker exec -i mysql-db mysql -uroot < sql/database_init.sql
echo "==> Base de datos lista con clientes, mascotas y servicios."

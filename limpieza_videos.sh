#!/bin/bash

source .config.env

FECHA=$(date +"%Y-%m-%d %H:%M:%S")

CARPETA_VIDEOS="/var/www/html/seguridad/videos"
LOG="/var/log/seguridad.log"

echo "$FECHA - Iniciando limpieza de vídeos antiguos" >> $LOG

# Borrar vídeos con más de 30 días
find "$CARPETA_VIDEOS" -type f -mtime +30 -delete

echo "$FECHA - Vídeos antiguos eliminados" >> $LOG

# Borrar registros antiguos en la base de datos

mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" <<EOF

DELETE FROM grabaciones
WHERE fecha_hora < NOW() - INTERVAL 30 DAY;

EOF

echo "$FECHA - Registros antiguos eliminados de la base de datos" >> $LOG

echo "$FECHA - Limpieza completada" >> $LOG

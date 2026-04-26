#!/bin/bash

source /home/usuario/sistema_seguridad/.config.env

CARPETA="/var/www/html/seguridad/videos"
LOG="/var/log/seguridad.log"
FECHA=$(date)

# Borrar vídeos de más de 30 días
find "$CARPETA" -type f -name "*.mp4" -mtime +30 -delete

echo "$FECHA - Vídeos antiguos eliminados" >> $LOG

# Borrar registros antiguos en MySQL Docker
docker exec mysql_seguridad mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" <<EOF
DELETE FROM grabaciones
WHERE fecha_hora < NOW() - INTERVAL 30 DAY;
EOF

echo "$FECHA - Registros antiguos eliminados de MySQL" >> $LOG

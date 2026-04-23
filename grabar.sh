#!/bin/bash

source .config.env

ID_EVENTO=$1

CARPETA="/var/www/html/seguridad/videos"
FECHA=$(date +"%Y%m%d_%H%M%S")
ARCHIVO="grabacion_$ID_EVENTO_$FECHA.mp4"

RUTA_COMPLETA="$CARPETA/$ARCHIVO"
RUTA_BD="videos/$ARCHIVO"

mkdir -p "$CARPETA"

ffmpeg -f v4l2 \
-input_format mjpeg \
-framerate 30 \
-video_size 640x480 \
-i /dev/video0 \
-t 10 \
-c:v libx264 \
-preset veryfast \
-pix_fmt yuv420p \
-movflags +faststart \
-an \
-y "$RUTA_COMPLETA"

mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" <<EOF
INSERT INTO grabaciones (nombre, ruta, fecha_hora, id_evento)
VALUES ('$ARCHIVO', '$RUTA_BD', NOW(), $ID_EVENTO);
EOF

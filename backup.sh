#!/bin/bash

source .config.env

FECHA=$(date +"%Y%m%d_%H%M%S")

CARPETA_BACKUP="/home/usuario/backups_seguridad"
CARPETA_PROYECTO="/home/usuario/sistema_seguridad"
CARPETA_WEB="/var/www/html/seguridad"
LOG="/var/log/seguridad.log"

mkdir -p "$CARPETA_BACKUP"

echo "$(date) - Iniciando backup del sistema" >> $LOG

# Backup base de datos
docker exec mysql_seguridad mysqldump --no-tablespaces -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" > "$CARPETA_BACKUP/bbdd_$FECHA.sql"

echo "$(date) - Backup base de datos creado: bbdd_$FECHA.sql" >> $LOG

# Backup proyecto python
tar -czf "$CARPETA_BACKUP/proyecto_python_$FECHA.tar.gz" "$CARPETA_PROYECTO"

echo "$(date) - Backup proyecto python creado" >> $LOG

# Backup proyecto web sin vídeos
tar --exclude='/var/www/html/seguridad/videos' -czf "$CARPETA_BACKUP/proyecto_web_$FECHA.tar.gz" "$CARPETA_WEB"

echo "$(date) - Backup proyecto web creado" >> $LOG

# Borrar backups antiguos
find "$CARPETA_BACKUP" -type f -mtime +30 -delete

echo "$(date) - Limpieza de backups antiguos completada" >> $LOG

echo "$(date) - Backup completado correctamente" >> $LOG

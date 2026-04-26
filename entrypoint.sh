#!/bin/bash

source /var/www/config/.config.env

avisar_apagado() {
    /app/enviar_telegram.sh "⚠️ AVISO: el contenedor del sistema de seguridad se está apagando."
    exit 0
}

trap avisar_apagado SIGTERM SIGINT

service apache2 start

python3 /app/escuchar_nodemcu.py &

wait

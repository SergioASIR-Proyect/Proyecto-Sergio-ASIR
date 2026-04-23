#!/bin/bash

source /home/usuario/sistema_seguridad/config.env

MENSAJE="$1"

curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
-d chat_id="$CHAT_ID" \
-d text="$MENSAJE" > /dev/null

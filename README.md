# Proyecto-Sergio-ASIR
Sistema de seguridad basado en NodeMCU (ESP8266) que detecta eventos mediante un sensor físico, registra las alertas en un servidor Linux y gestiona grabaciones de vídeo automáticas.

# 🔐 Sistema de Seguridad IoT

Sistema de seguridad basado en **NodeMCU (ESP8266)** que detecta eventos mediante un sensor físico y registra automáticamente las alertas en un servidor Linux.  
El sistema incluye grabación automática de vídeo, almacenamiento de eventos y un panel web para su gestión.

---

## ⚙️ Funcionamiento

1. El sensor detecta una apertura.
2. El NodeMCU envía una alerta al servidor por USB/Serial.
3. Un script Python recibe la alerta.
4. El servidor registra el evento en la base de datos.
5. Se inicia una grabación de vídeo asociada al evento.
6. El usuario puede consultar los eventos y reproducir los vídeos desde el panel web.

---

## 🧰 Tecnologías utilizadas

- NodeMCU (ESP8266)
- Python
- PHP
- MySQL
- Apache
- ffmpeg
- systemd
- Fail2ban
- UFW Firewall

---

## 📁 Estructura del proyecto

```
sistema_seguridad
│
├── escuchar_nodemcu.py
├── grabar.sh
├── backup.sh
├── limpieza_videos.sh
├── enviar_telegram.sh
│
├── web
│   ├── acceso.php
│   ├── dashboard.php
│   ├── eventos.php
│   └── login.php
│
└── hardware
    └── nodemcu_codigo.ino
```

---

## 🔒 Seguridad

El sistema incorpora varias medidas de seguridad:

- HTTPS
- Firewall (UFW)
- Protección contra fuerza bruta con Fail2ban
- Autenticación mediante sesiones PHP
- Alertas de monitorización por Telegram

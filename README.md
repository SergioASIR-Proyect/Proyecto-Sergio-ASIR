# Proyecto-Sergio-ASIR
Sistema de seguridad basado en NodeMCU (ESP8266) que detecta eventos mediante un sensor físico, registra las alertas en un servidor Linux y gestiona grabaciones de vídeo automáticas.

# 🔐 Sistema de Seguridad IoT

Sistema de seguridad basado en **NodeMCU (ESP8266)** que detecta eventos mediante un sensor físico y registra automáticamente las alertas en un servidor Linux.  
El sistema incluye grabación automática de vídeo, almacenamiento de eventos, monitorización, acceso remoto seguro y un panel web para su gestión.

---

## ⚙️ Funcionamiento

1. El sensor detecta una apertura.  
2. El NodeMCU envía una alerta al servidor por USB/Serial.  
3. Un script Python recibe la alerta.  
4. El servidor registra el evento en la base de datos.  
5. Se inicia una grabación de vídeo asociada al evento.  
6. Se envía una alerta al usuario mediante Telegram.  
7. El usuario puede consultar los eventos y reproducir los vídeos desde el panel web.  
8. El sistema permite acceso remoto seguro mediante VPN.  
9. Los servicios se ejecutan en contenedores Docker y se monitorizan automáticamente.  

---

## 🧰 Tecnologías utilizadas

- NodeMCU (ESP8266)  
- Python  
- PHP  
- MySQL  
- Apache  
- ffmpeg  
- Docker / Docker Compose  
- WireGuard VPN  
- Prometheus  
- Grafana  
- systemd  
- Fail2ban  
- UFW Firewall  

---

## 📁 Estructura del proyecto

```
sistema_seguridad/
│
├── Dockerfile
├── docker-compose.yml
├── entrypoint.sh
│
├── escuchar_nodemcu.py
├── grabar.sh
├── backup.sh
├── limpieza_videos.sh
├── enviar_telegram.sh
│
├── config/
│   └── web/
│       ├── acceso.php
│       ├── alerta.php
│       ├── bbdd.php
│       ├── dashboard.php
│       ├── eventos.php
│       ├── login.php
│       └── logout.php
│
├── docker/
│   └── mysql/
│       └── init/
│           └── 01_init.sql
│
├── monitoring/
│   └── prometheus/
│       └── prometheus.yml
│
├── seguridad-http.conf
├── seguridad-ssl.conf
├── .gitignore
└── README.md
```

---

## 🐳 Estructura en Docker

El proyecto utiliza Docker Compose para organizar los servicios principales del sistema en contenedores independientes:

- **web**: servidor Apache/PHP, panel de gestión y acceso a grabaciones.
- **mysql**: base de datos del sistema.
- **cadvisor**: recogida de métricas de los contenedores Docker.
- **prometheus**: recolección y almacenamiento de métricas.
- **grafana**: visualización y monitorización del sistema.

---

## 🔒 Seguridad

El sistema incorpora varias medidas de seguridad:

- HTTPS (OpenSSL)  
- Firewall (UFW)  
- Protección contra fuerza bruta con Fail2ban  
- Autenticación mediante sesiones PHP  
- Acceso remoto seguro mediante VPN (WireGuard)  
- Alertas de monitorización y eventos por Telegram  
- Registro de logs para auditoría del sistema  
- Backup automático de datos críticos  

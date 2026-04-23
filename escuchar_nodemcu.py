import serial
import requests
import time
import subprocess
import re
import logging

PUERTO = "/dev/ttyUSB0"
BAUDIOS = 9600
URL = "http://localhost/seguridad/alerta.php?token=CLAVE123&tipo_evento=APERTURA_PUERTA"

# Configuración del log
logging.basicConfig(
    filename="/var/log/seguridad.log",
    level=logging.INFO,
    format="%(asctime)s - %(message)s"
)

print("Iniciando sistema de escucha del NodeMCU...")
logging.info("Iniciando sistema de escucha del NodeMCU")

buffer_serial = ""

while True:
    try:
        print("Conectando al puerto:", PUERTO)
        logging.info("Conectando al puerto %s", PUERTO)

        ser = serial.Serial(PUERTO, BAUDIOS, timeout=1)
        time.sleep(2)

        print("Conectado. Esperando eventos...")
        logging.info("Conectado al puerto serie. Esperando eventos")

        while True:
            linea = ser.readline().decode("utf-8", errors="ignore").strip()

            if linea:
                print("Recibido:", linea)
                logging.info("Recibido: %s", linea)

                buffer_serial += linea

            # Detectar ALERTA aunque llegue fragmentado
            if "ALERTA" in buffer_serial:

                print("Alerta detectada, enviando al servidor...")
                logging.info("Alerta detectada, enviando al servidor")

                try:
                    respuesta = requests.get(URL)
                    texto = respuesta.text.strip()

                    print("Respuesta servidor:", texto)
                    logging.info("Respuesta servidor: %s", texto)

                    match = re.search(r"OK_EVENTO_(\d+)", texto)

                    if match:
                        id_evento = match.group(1)

                        print("Lanzando grabación para evento:", id_evento)
                        logging.info("Lanzando grabación para evento %s", id_evento)

                        subprocess.Popen(
                            ["/home/usuario/sistema_seguridad/grabar.sh", id_evento]
                        )

                    elif "ALARMA_DESACTIVADA" in texto:

                        print("La alarma está desactivada. No se graba vídeo.")
                        logging.info("Alarma desactivada. No se crea evento ni grabación")

                    else:
                        print("Respuesta inesperada del servidor:", texto)
                        logging.warning("Respuesta inesperada del servidor: %s", texto)

                except Exception as e:
                    print("Error al llamar a alerta.php:", e)
                    logging.error("Error al llamar a alerta.php: %s", str(e))

                buffer_serial = ""

    except Exception as e:
        print("Error con el puerto serie:", e)
        logging.error("Error con el puerto serie: %s", str(e))

        print("Reintentando en 5 segundos...")
        logging.info("Reintentando conexión en 5 segundos")

        time.sleep(5)

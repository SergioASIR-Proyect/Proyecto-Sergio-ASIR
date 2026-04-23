<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Content-Type: text/plain; charset=UTF-8");

include_once "bbdd.php";

$config = parse_ini_file("/var/www/config/.config.env");
$token_correcto = $config["token_correcto"];

/* TELEGRAM */
$bot_token = $config["TOKEN"];
$chat_id = $config["CHAT_ID"];

if (!isset($_GET["token"]) || $_GET["token"] !== $token_correcto) {
    http_response_code(403);
    echo "TOKEN_INVALIDO";
    exit;
}

$tipo_evento = isset($_GET["tipo_evento"]) ? $_GET["tipo_evento"] : "APERTURA_PUERTA";

$conn = new mysqli($servidor, $user, $password, $bd);

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

$alarma_activada = true;

$sql_estado = "SELECT estado_alarma FROM log_estado ORDER BY id_estado DESC LIMIT 1";
$resultado_estado = $conn->query($sql_estado);

if ($resultado_estado && $resultado_estado->num_rows > 0) {
    $fila = $resultado_estado->fetch_assoc();
    $alarma_activada = ($fila["estado_alarma"] == 1);
}

if (!$alarma_activada) {
    echo "ALARMA_DESACTIVADA";
    $conn->close();
    exit;
}

$stmt = $conn->prepare("INSERT INTO evento (tipo_evento, fecha_hora) VALUES (?, NOW())");
$stmt->bind_param("s", $tipo_evento);

if ($stmt->execute()) {

    $id_evento = $stmt->insert_id;
    echo "OK_EVENTO_" . $id_evento;

    /* ENVIAR TELEGRAM */
    $mensaje = "🚨 ALERTA SISTEMA SEGURIDAD\nEvento: $tipo_evento\nID: $id_evento\nFecha: " . date("Y-m-d H:i:s");

    $url = "https://api.telegram.org/bot$bot_token/sendMessage?chat_id=$chat_id&text=" . urlencode($mensaje);

    file_get_contents($url);

} else {
    echo "ERROR_INSERT: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
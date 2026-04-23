<?php

include_once "bbdd.php";
session_start();

try {

    if(!isset($_SESSION['user']) || $_SESSION['user']==""){
        header("Location: acceso.php");
    }

    $conexion = mysqli_connect($servidor, $user, $password, $bd);

    if (!$conexion) {
        die("Error en la conexión: " . mysqli_connect_error());
    }

    $sql = "select evento.id_evento, evento.tipo_evento, evento.fecha_hora, grabaciones.nombre, grabaciones.ruta
            from evento
            left join grabaciones on evento.id_evento = grabaciones.id_evento
            order by evento.fecha_hora desc";

    $resultado_sql = mysqli_query($conexion, $sql);
    $eventos = mysqli_fetch_all($resultado_sql, MYSQLI_ASSOC);

} catch (Exception $e) {
    echo "Error: ".$e->getMessage();
}

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Eventos</title>
    <style>
        body{
            margin:0;
            font-family: Arial, sans-serif;
            background-color:#eaf4ff;
            color:#000000;
        }

        .contenedor{
            width:95%;
            max-width:1100px;
            margin:40px auto;
            background-color:#ffffff;
            border:1px solid #b7d8f7;
            border-radius:20px;
            padding:30px;
            box-shadow:0 4px 14px rgba(0,0,0,0.08);
        }

        h2{
            text-align:center;
            margin-top:0;
            margin-bottom:25px;
        }

        table{
            width:100%;
            border-collapse:collapse;
            background-color:#ffffff;
        }

        th, td{
            border:1px solid #cfe4f8;
            padding:12px;
            text-align:center;
        }

        th{
            background-color:#d7ebff;
        }

        tr:nth-child(even){
            background-color:#f7fbff;
        }

        .play{
            display:inline-block;
            text-decoration:none;
            background-color:#8ec5ff;
            color:#000000;
            padding:8px 12px;
            border-radius:12px;
            font-weight:bold;
        }

        .play:hover{
            background-color:#74b7fb;
        }

        .acciones{
            text-align:center;
            margin-top:25px;
        }

        .acciones a{
            display:inline-block;
            margin:10px;
            padding:12px 22px;
            text-decoration:none;
            background-color:#d7ebff;
            color:#000000;
            border-radius:14px;
            font-weight:bold;
        }

        .acciones a:hover{
            background-color:#c4e1ff;
        }
    </style>
</head>
<body>

    <div class="contenedor">
        <h2>Listado de eventos</h2>

        <table>
            <tr>
                <th>ID EVENTO</th>
                <th>TIPO EVENTO</th>
                <th>FECHA Y HORA</th>
                <th>NOMBRE GRABACIÓN</th>
                <th>VER VÍDEO</th>
            </tr>

            <?php
                foreach($eventos as $evento){
                    echo "<tr>";
                    echo "<td>".$evento['id_evento']."</td>";
                    echo "<td>".$evento['tipo_evento']."</td>";
                    echo "<td>".$evento['fecha_hora']."</td>";
                    echo "<td>".$evento['nombre']."</td>";

                    if(isset($evento['ruta']) && $evento['ruta']!=""){
                        echo "<td><a class='play' href='".$evento['ruta']."' target='_blank'>▶</a></td>";
                    } else {
                        echo "<td>-</td>";
                    }

                    echo "</tr>";
                }
            ?>
        </table>

        <div class="acciones">
            <a href="dashboard.php">VOLVER AL DASHBOARD</a>
            <a href="logout.php">CERRAR SESIÓN</a>
        </div>
    </div>

</body>
</html>
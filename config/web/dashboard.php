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

    if (isset($_POST['activar'])) {

        $sql_usuario = "select id_usuario from usuarios where username='".$_SESSION['user']."'";
        $resultado_usuario = mysqli_query($conexion, $sql_usuario);
        $usuario = mysqli_fetch_array($resultado_usuario, MYSQLI_ASSOC);
        $id_usuario = $usuario['id_usuario'];

        $sql_insert = "insert into log_estado (estado_alarma, fecha_hora, id_usuario) values (1, NOW(), ".$id_usuario.")";
        mysqli_query($conexion, $sql_insert);
    }

    if (isset($_POST['desactivar'])) {

        $sql_usuario = "select id_usuario from usuarios where username='".$_SESSION['user']."'";
        $resultado_usuario = mysqli_query($conexion, $sql_usuario);
        $usuario = mysqli_fetch_array($resultado_usuario, MYSQLI_ASSOC);
        $id_usuario = $usuario['id_usuario'];

        $sql_insert = "insert into log_estado (estado_alarma, fecha_hora, id_usuario) values (0, NOW(), ".$id_usuario.")";
        mysqli_query($conexion, $sql_insert);
    }

    $sql_estado = "select * from log_estado order by fecha_hora desc limit 1";
    $resultado_estado = mysqli_query($conexion, $sql_estado);
    $estado = mysqli_fetch_array($resultado_estado, MYSQLI_ASSOC);

    $estado_servicio = trim(shell_exec("pgrep -f escuchar_nodemcu.py"));

} catch (Exception $e) {
    echo "Error: ".$e->getMessage();
}

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Dashboard</title>
    <style>
        body{
            margin:0;
            font-family: Arial, sans-serif;
            background-color:#eaf4ff;
            color:#000000;
        }

        .contenedor{
            width:700px;
            margin:60px auto;
            background-color:#ffffff;
            border:1px solid #b7d8f7;
            border-radius:20px;
            padding:35px;
            box-shadow:0 4px 14px rgba(0,0,0,0.08);
            text-align:center;
        }

        .cabecera{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:20px;
        }

        .cabecera h2{
            margin:0;
        }

        .estado-servicio{
            display:flex;
            align-items:center;
            gap:10px;
            font-weight:bold;
            font-size:14px;
        }

        .circulo{
            width:14px;
            height:14px;
            border-radius:50%;
            display:inline-block;
        }

        .verde{
            background-color:#33b249;
            box-shadow:0 0 8px rgba(51,178,73,0.7);
        }

        .rojo{
            background-color:#d63636;
            box-shadow:0 0 8px rgba(214,54,54,0.7);
        }

        .bienvenida{
            margin-bottom:25px;
        }

        .estado-texto{
            font-size:20px;
            font-weight:bold;
            margin-bottom:25px;
        }

        .selector-estado{
            display:flex;
            justify-content:center;
            gap:20px;
            margin-bottom:30px;
            flex-wrap:wrap;
        }

        .selector-estado input[type="submit"]{
            min-width:220px;
            padding:14px 20px;
            border:none;
            border-radius:999px;
            font-weight:bold;
            font-size:16px;
            cursor:pointer;
            background-color:#d7ebff;
            color:#000000;
            box-shadow:0 2px 6px rgba(0,0,0,0.08);
        }

        .selector-estado input[type="submit"]:hover{
            background-color:#c4e1ff;
        }

        .boton-activo{
            background-color:#8ec5ff !important;
            box-shadow:0 0 14px rgba(95,170,245,0.8) !important;
        }

        .acciones{
            margin-top:15px;
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

        <div class="cabecera">
            <h2>Panel de control</h2>

            <div class="estado-servicio">
                <?php
                    if ($estado_servicio != "") {
                        echo "<span class='circulo verde'></span>";
                        echo "<span>Servicio activo</span>";
                    } else {
                        echo "<span class='circulo rojo'></span>";
                        echo "<span>Servicio inactivo</span>";
                    }
                ?>
            </div>
        </div>

        <p class="bienvenida">Usuario conectado: <?php echo $_SESSION['user']; ?></p>

        <?php
            if ($estado && $estado['estado_alarma']==1) {
                echo "<p class='estado-texto'>Estado del sistema: ACTIVADO</p>";
            } else {
                echo "<p class='estado-texto'>Estado del sistema: DESACTIVADO</p>";
            }
        ?>

        <form action="dashboard.php" method="POST" class="selector-estado">
            <?php
                if ($estado && $estado['estado_alarma']==1) {
                    echo "<input type='submit' name='activar' value='ACTIVADO' class='boton-activo'/>";
                    echo "<input type='submit' name='desactivar' value='DESACTIVADO'/>";
                } else {
                    echo "<input type='submit' name='activar' value='ACTIVADO'/>";
                    echo "<input type='submit' name='desactivar' value='DESACTIVADO' class='boton-activo'/>";
                }
            ?>
        </form>

        <div class="acciones">
            <a href="eventos.php">VER EVENTOS</a>
            <a href="logout.php">CERRAR SESIÓN</a>
        </div>
    </div>

</body>
</html>

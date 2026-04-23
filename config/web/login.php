<?php

include_once "bbdd.php";
session_start();

$userf = $_POST['username'];
$passf = $_POST['pass'];

try {

    $conn = mysqli_connect($servidor, $user, $password, $bd);
    $sql = "select * from usuarios where username='".$userf."'";
    $resultadosql = mysqli_query($conn, $sql);

    if (mysqli_num_rows($resultadosql)==1) {

        $userbbdd = mysqli_fetch_array($resultadosql, MYSQLI_ASSOC);
        $hashpassbbdd = $userbbdd['password'];

        if(password_verify($passf, $hashpassbbdd)) {
            $_SESSION['user'] = $userbbdd['username'];
            $_SESSION['error_login'] = false;
            header("Location: dashboard.php");
        } else {
            unset($_SESSION['user']);
            $_SESSION['error_login'] = true;
            header("Location: acceso.php");    
        }

    } else {
        unset($_SESSION['user']);
        $_SESSION['error_login'] = true;
        $ip = $_SERVER['REMOTE_ADDR'];
        file_put_contents("/var/log/login_seguridad.log", date("Y-m-d H:i:s")." LOGIN_FAIL ".$ip."\n", FILE_APPEND);
        header("Location: acceso.php");
    }
        
} catch (Exception $e) {
    echo "ERROR: ".$e->getMessage();
}

?>
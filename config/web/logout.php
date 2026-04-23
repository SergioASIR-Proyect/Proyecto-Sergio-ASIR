<?php

session_start();

if(!isset($_SESSION['user']) || $_SESSION['user']==""){
    header("Location: acceso.php");
}

unset($_SESSION['user']);
unset($_SESSION['error_login']);
header("Location: acceso.php");

?>
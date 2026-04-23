<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Acceso</title>
<style>
    body{
        margin:0;
        font-family: Arial, sans-serif;
        background-color:#eaf4ff;
        color:#000000;
    }

    .contenedor{
        width:380px;
        margin:100px auto;
        background-color:#ffffff;
        border:1px solid #b7d8f7;
        border-radius:18px;
        padding:30px;
        box-shadow:0 4px 14px rgba(0,0,0,0.08);
    }

    h2{
        text-align:center;
        margin-top:0;
        margin-bottom:25px;
    }

    label{
        display:block;
        margin-bottom:8px;
        font-weight:bold;
    }

    input[type="text"],
    input[type="password"]{
        width:100%;
        padding:12px;
        margin-bottom:18px;
        border:1px solid #9fc8ee;
        border-radius:12px;
        box-sizing:border-box;
        background-color:#f8fcff;
        color:#000000;
    }

    input[type="submit"]{
        width:100%;
        padding:12px;
        border:none;
        border-radius:14px;
        background-color:#8ec5ff;
        color:#000000;
        font-weight:bold;
        cursor:pointer;
    }

    input[type="submit"]:hover{
        background-color:#74b7fb;
    }

    .error{
        margin-top:15px;
        text-align:center;
        color:#c00000;
        font-weight:bold;
    }
</style>
</head>
<body>

    <div class="contenedor">
        <h2>Acceso al sistema</h2>

        <form action="login.php" method="POST">
            <label>Usuario:</label>
            <input type="text" name="username"/>

            <label>Contraseña:</label>
            <input type="password" name="pass"/>

            <input type="submit" value="Acceso">
        </form>

        <?php
            session_start();
            if (isset($_SESSION['error_login']) && $_SESSION['error_login']==true){
                echo "<p class='error'>El usuario y/o la contraseña no son correctas.</p>";
            }
        ?>
    </div>

</body>
</html>
<?php
date_default_timezone_set('Europe/Copenhagen');
include './dbh.inc.php';
include './comments.inc.php';
session_start();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="refresh" content="15;url=logout.php" />

    <link rel="stylesheet" href="styles/styles_login.css">
    <title>Login</title>
</head>

<body>
    <?php
    echo
    "<form method='POST' action='" . getLogin($conn) . "'>
    <input type='text' name='uid'>
    <input type='password' name='pwd'>
        <button type='submit' name='loginSubmit'>Login</button>
    </form>";

    echo
    "<form method='POST' action='" . userLogout() . "'>
        <button type='submit' name='logoutSubmit'>Logout</button>
    </form>";

    if (isset($_SESSION['id'])) {
        echo "You are logged in, sir.";
    } else {
        echo "Sorry mate, you are not logged in.";
    }
    ?>
    <br><br>
    <?php

    if (isset($_SESSION['id'])) {
        echo
        "<form method='POST' action='" . setComment($conn) . "'>
            <input type='hidden' name='uid' value='" . $_SESSION['id'] . "'>
            <input type='hidden' name='date' value='" . date('Y-m-d H:i:s') . "'>
    
            <textarea name='message'></textarea>
    
            <button type='submit' name='commentSubmit'>Comment</button>
    
        </form>";
    } else {
        echo "You need to be logged in order to comment. <br><br>";
    }


    getComments($conn);
    ?>
    <br>

</body>

</html>
<?php

$conn = mysqli_connect('localhost', 'root', '', 'commentsection');

if (!$conn) {
    die("Connection failes: " . mysqli_connect_error());
} else {
    // echo "Connection established, man.";
}

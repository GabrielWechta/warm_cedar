<?php

function generateNavbar(){
    return '<a href="https://github.com/GabrielWechta" class="logo">GW</a>
    <div id="js">
        <div class="toggle" onclick="toggleMenu();"></div>
        <ul class="menu">
            <li><a href="index.php">Home</a></li>
            <li><a href="programing.php">Programing</a></li>
            <li><a href="bragging.php">Bragging</a></li>
            <li><a href="interests.php">Interests</a></li>
            <li><a href="login.php">Login</a></li>
        </ul>
    </div>
    <noscript>
        <ul class="navbar" id="navbar">
            <li><a href="index.php">Home</a></li>
            <li><a href="programing.php">Programing</a></li>
            <li><a href="bragging.php">Bragging</a></li>
            <li><a href="interests.php">Interests</a></li>
            <li><a href="login.php">Login</a></li>
            <a class="close" href="#">
                <img src="https://ljc-dev.github.io/testing0/ham-close.svg" alt="close">
            </a>
        </ul>
        <a class="hamburger" href="#navbar">
            <img src="resources/menu.png" alt="menu">
        </a>
    </noscript>';
}

function generateFooter(){
    return '        <p class="copyright">Gabriel Wechta © 2021 <br>mail: wechtagabriel@gmail.com </p>
    <ul class="list-inline">
        <li class="list-inline-item"><a href="https://github.com/GabrielWechta">GitHub</a></li>
        <li class="list-inline-item"><a href="https://www.chess.com/member/7wodapokisielu">Chess</a></li>
        <li class="list-inline-item"><a href="https://www.youtube.com/channel/UC3ZRWCNsn9DK6MPj4ER_B4Q">YouTube</a>
        </li>
    </ul>';
}

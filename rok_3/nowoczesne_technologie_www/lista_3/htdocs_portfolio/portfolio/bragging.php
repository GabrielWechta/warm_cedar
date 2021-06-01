<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>Gabriel Wechta Portfolio</title>
    <link rel="stylesheet" href="styles/style_comp.css">
</head>

<body>
    <header>
        <?php
        include("foot_nav_handler.php");
        echo generateNavbar();
        ?>
    </header>
    <main class="bragging">
        <h4>Description</h4>
        <p>This section solely intended to bragging about project I made or participated in. </p>
        <hr>
        <section>
            <article>
                <h5>Age Of Divisiveness</h5>
                <p>Complex multiplayer (LAN) strategic game written in Python <i>arcade</i>. Main theme of the game
                    resembles
                    Civilization I and II. Game has self made sprites and beautiful pixel-art graphics.
                </p>
            </article>
            <div class="container">
                <a href="https://github.com/chceswieta/age-of-divisiveness" target="_blank">
                    <img src="resources/aod_logo.png" alt="Age Of Divisiveness logo">
                    <div class="overlay">
                        <div class="text">Click to see project's repo</div>
                    </div>
                </a>
            </div>
        </section>
        <hr>
        <section>
            <div class="container">
                <a href="https://github.com/GabrielWechta/neckcarrying_spruce" target="_blank">
                    <img src="resources/weather.png" alt="weather code">
                    <div class="overlay">
                        <div class="text">Click to see project's repo</div>
                    </div>
                </a>
            </div>
            <article>
                <h5>Weather Conspiracy</h5>
                <p>There is no such thing as weather prediction. There are only
                    guesses and short memory. Or is it? Python project
                    using <i>pandas</i> for data management and <i>beautifulsoup</i> for web scrapping. Big ideas for future
                    optimization and new features. This python can be easily added to system boot, so it can gather data
                    without user action. Those 30 lines of code downloads, understand and translate HTTP request for
                    gathering data and store it accordingly based on today's date. Incredible Python.
                </p>
            </article>
        </section>
        <hr>
        <section>
            <article>
                <h5>Old balls game</h5>
                <p>Back in the begging of games (DOS games time) there was a very popular game called "balls", with easy to
                    learn, hard to master gameplay. My dad was a big fan of this game. He was always thinking about AI
                    for this game. Well this is it.
                </p>
            </article>
            <div class="container">
                <a href="https://github.com/GabrielWechta/paternal_vine" target="_blank">
                    <img src="resources/kulki.png" alt="balls game">
                    <div class="overlay">
                        <div class="text">Click to see project's repo</div>
                    </div>
                </a>
            </div>
        </section>
        <hr>
        <section>
            <div class="container">
                <a href="https://github.com/GabrielWechta/third_wisteria" target="_blank">
                    <img src="resources/third_wisteria_2.png" alt="storm over moscow">
                    <div class="overlay">
                        <div class="text">Click to see project's repo</div>
                    </div>
                </a>
            </div>
            <article>
                <h5>3D JavaScript in action</h5>
                <p>Testing, experimenting and learning fresh JS technologies with some working on a artistic factor. Three
                    sites written in Three.js, one for 3D function graph, one with Photoshop and depth-filter, and one with
                    <i>Master and
                        Margarita</i>. To see visit: <a href="https://gabrielwechta.github.io/third_wisteria" target="_blank">Third Wisteria</a>.
                </p>
            </article>
        </section>
        <hr>
        <section>
            <article>
                <h5>Chess clock in Arduino</h5>
                <p>Self designed and made Arduino project, with input buttons and smart time measurement. Each player has
                    his own button for stopping his clock and starting opponent's. Players' times are set up separately.
                </p>
            </article>
            <div class="container">
                <a href="https://github.com/GabrielWechta/blue_oliveTree" target="_blank">
                    <img src="resources/chess_clock.JPG" alt="chess clock">
                    <div class="overlay">
                        <div class="text">Click to see project's repo</div>
                    </div>
                </a>
            </div>
        </section>
    </main>

    <script type="text/javascript" src="menu.js"></script>

    <footer class="footer-basic-black">
        <?php
        echo generateFooter();
        ?>
    </footer>
</body>

</html>
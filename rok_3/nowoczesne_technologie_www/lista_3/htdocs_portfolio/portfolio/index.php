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
    <section class="banner">
        <section class="textBx">
            <h2>Hi Dear, I am Gabriel Wechta.</h2>
            <a href="#about_me" class="btn">About Me</a>
        </section>
    </section>
    <section id="about_me" class="about">
        <h2>About Me</h2>

        <h4>Birth</h4>
        <p>I was born on the eve of Halloween in 1999 in Zielona Góra, Poland. Given that, curiously, I seem to be quite
            content when spooky stuff happens. On top of that, just like anyone else born around that time in Poland, I
            am
            used to getting presents around the first of November. In my country, the first of November is a holiday,
            during
            which everybody gathers to go visit family graves.
            <br>So graveyards are my happy places.
        </p>

        <hr>

        <h4>Education</h4>
        <p>For the first six years of my life, I lived in Zielona Góra. We then moved to Jelenia Góra. Despite the
            similarity in names, places are pretty far from each other. Upon graduating Primary School, we moved again,
            this
            time to Wrocław, which I am eternally grateful for. There I began junior high school, I was in an
            architecture-oriented class with extended maths and art. Both bizarre and wonderful. When it comes to high
            school, I went to Akademickie Liceum Ogólnokształcące Politechniki Wrocławskiej, which is a school directly
            connected to Wrocław University of Science and Technology. Happy days, as a high school student I had ample
            opportunity to use University assets, both equipment and lecturers. Some of my teachers were high school
            teachers, some were academic, so while solid fundaments were made for the maturity exam, I would also get
            pretty
            good preparation for a completely different approach and style of studying that is offered by the
            university. My
            school understood this potential and exerted it. For example, the maths class was being taught by two
            teachers,
            one who would be preparing us for standard exam evaluation while the other’s class had more of a
            lecture-like
            kind of flow.
            <br>Despite whatever you might expect of a polytechnic high school, some surprisingly huge effort was put
            into
            teaching us decent humanities. At first with some difficulties, after a while - with tremendous respect, my
            science-oriented brain started to appreciate art, literature, and philosophy.
            <br>I am currently studying at the Department of Fundamentals of Computer Science, at Wrocław University of
            Science
            and Technology (in this case "fundamentals" is not a synonym of “basics").
        </p>
        <hr>
    </section>
    <script type="text/javascript" src="menu.js"></script>
    <footer class="footer-basic">
        <?php
        include("visitors.php");
        echo generateFooter();
        ?>
    </footer>
</body>

</html>
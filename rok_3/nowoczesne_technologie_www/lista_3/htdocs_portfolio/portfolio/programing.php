<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>Programing</title>
    <link rel="stylesheet" href="styles/style_comp.css">
</head>

<body>
    <header>
        <?php
        include("foot_nav_handler.php");
        echo generateNavbar();
        ?>
    </header>

    <section class="programing">
        <h4>IT path</h4>
        <p>As it is the case for most kids, my programming education began with learning C++, around the age of 13. Now it
            seems absurd to me how much one has to know before they can understand their first hello world in that language.
            Despite great effort to learn it pretty well and as soon as possible, my true education began in 3rd great of
            high school, during preparation for the maturity exam.
            <br>What a hard time it was. A lot of duties, never-ending exams and tests, tons of work with no reward. In that
            battlefield mess, however, my love for programming begun to blossom.
            <br>After high school, during my studies, my expectations were happily met by lecturers’ approach and
            professionalism. I learned plenty of languages and frameworks (see below). But what is even more important, I
            understood deep programming ideas and rules.
        </p>

        <img src="resources/fireworks.JPG" alt="fireworks">

        <h4>Languages and frameworks</h4>
        <ul class="column-list">
            <li>♕ Python</li>
            <li>♖ Bash</li>
            <li>♖ Java</li>
            <li>♖ Git</li>
            <li>♗ Svn</li>
            <li>♗ C++/C (=C+)</li>
            <li>♗ SQL/NoSQL</li>
            <li>♗ PyQt5 (Python)</li>
            <li>♗ HTML5/CSS3</li>
            <li>♘ Julia</li>
            <li>♘ Spring Boot (Java)</li>
            <li>♘ Keras (Python)</li>
            <li>♘ Django (Python)</li>
            <li>♘ Arcade (Python)</li>
            <li>♘ Arduino</li>
            <li>♘ JavaScript</li>
            <li>♘ Three.js (JavaScript)</li>
            <li>♘ Hardware basics</li>
            <li>♙ Kotlin</li>
            <li>♙ Prolog</li>
            <li>♙ Ada</li>
        </ul>

        <h4>My philosophical rubbish about math</h4>
        <p>At first it may sound like a way too romantic vision of reality but in my opinion, mathematical reasoning is a
            very unnoticed marvel. With every hour spent learning maths and programming (especially logic), I've started to
            notice how everything becomes clearer and more easily understandable. It might be impossible to grasp for people
            who have not spent hundreds of hours considering complex problems and it is still hard to notice for people who
            did, but using mathematical analogies in life boost one's senses significantly. Since I began my studies, I've
            started to notice how many folks make logical mistakes and even empty logical holes in their statements. I have
            always been amazed by how much mathematical reasoning was present in everyday life. In the end, politicians are
            just as unbearable as most nutritionists and "scientists" who do not understand that an experiment's result is
            not a proof on its own.

            At first it may sound like some too romantic vision of reality, but in my opinion, it's a very unnoticed marvel.
            With every hour spent learning math and programming (especially logic), I've started to notice how everything
            becomes clearer and more easily understandable. It's impossible to grasp for people who didn't spend hundreds of
            hours thinking about really complex problems and it's hard to notice for people who did, but using math
            analogies in life boost one's senses significantly. Since I began studies, I've started to notice how many
            folks,
            make logical mistakes and even empty logical holes in their statements. I was always amazed by how much
            mathematical reasoning came to be in everyday life. In the end, politicians are unbearable same as most
            nutritionists and "scientists" who do not understand that experiment's result is not a prove. </p>


        <img src="resources/mountain.JPG" alt="mountain">

        <h4>Job Experience</h4>
        <ul class="color-with-marker">
            <li>I took summer internship in <a href="https://services.harman.com/" target="_blank">Harman Connected Services
                    Poland</a>. I worked there on <b>Java / Spring Boot</b> web app providing quick and easy access for HR to
                see in which tax category workers' job-time should be placed. (summer, 2019)
            </li>
            <li>I gave math private lessons to a high school student, particularly preparing for the maturity exam.
                (Continues)
            </li>
            <li>I was working in pastry factory in Darlington, England as production line worker, along with native english
                speakers. (summer, 2018)
            </li>
            <li>I was working in small, local shop in Poland as a salesman. (summer, 2017)</li>
        </ul>


    </section>

    <script type="text/javascript" src="menu.js"></script>

    <footer class="footer-basic-black">
        <?php
        echo generateFooter();
        ?>
    </footer>
</body>

</html>
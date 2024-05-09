<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page errorPage="login.jsp" %>
<%
session = request.getSession(false);
String adminemail = (String) session.getAttribute("adminemail");
%>
 <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="author" content="clinton nkwocha">
    <meta name="description"
        content="rider is a carpooling application that provides drivers with the ability to create ride offers and passengers to join available ride offers.">
    <meta name="keywords" content="rider, carpool, carpooling, car, pool, offer ride">
    <meta name="language" content="english">
    <meta name="theme-color" content="#2c3e50">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN PANEL</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=mukta:wght@200;300;400;500;600;700;800&family=roboto+mono:ital,wght@1,100&display=swap"
        rel="stylesheet">
    <link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="./css/reset.min.css" type="text/css">
    <link rel="stylesheet" href="./css/style.css" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
</head>

<body>
    <div id="container">
        <nav id="navbar">
            <a href="#"><img src="./images/rider-big.png" alt="rider-logo" title="rider | live, ride, share"></a>
            <input type="checkbox" id="burger-toggle">
            <label id="burger" for="burger-toggle"></label>
            <ul>
                <li>
                    <a href="#" class="shortcut">Home</a>
                </li>
                <li>
                    <a href="#" class="shortcut">All Users</a>
                </li>
                <li>
                    <a href="../Logout" class="shortcut"
                        style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log
                        out <span
                            style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
                </li>
            </ul>
        </nav>
        <section id="wrap">
            <main>
                <h1>Rider</h1>
                <p>Carpooling shouldn't be that hard, right?</p>
                <form action="./Admin_Search_Rides" method="post">
                    <input type="text" id="departure" name="departure" placeholder="Departure"
                        title="Tip: Use the nearest bus stop to you for optimal results." required>
                    <input type="text" id="destination" name="destination" placeholder="Destination"
                        title="Tip: Use the nearest bus stop to your destination for optimal results." required>
                    <input type="date" id="date" name="date" required>
                    <input type="time" id="time" name="time" required>
                    <input type="submit" value="Search Rides" class="pill">
                </form>
            </main>
        </section>

        <footer>
            <span>&copy; 2024 Rider</span>
        </footer>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script type="text/javascript" src="./js/script.js"></script>
    <script>
        const departureInput = document.getElementById('departure');
        const destinationInput = document.getElementById('destination');
        const dateInput = document.getElementById('date');
        const timeInput = document.getElementById('time');

        departureInput.addEventListener('input', checkInputValues);
        destinationInput.addEventListener('input', checkInputValues);

        function checkInputValues() {
            const departureValue = departureInput.value.toLowerCase();
            const destinationValue = destinationInput.value.toLowerCase();

            if (departureValue === destinationValue) {
                alert("Departure and destination cannot be the same.");
                destinationInput.value = '';
            }
        }

        function setCurrentDateTime() {
            var currentDate = new Date();
            var currentDateString = currentDate.toISOString().slice(0, 10); // Format: YYYY-MM-DD
            var currentTimeString = currentDate.toTimeString().slice(0, 5); // Format: HH:MM

            dateInput.value = currentDateString;
            dateInput.min = "1970-01-01"; // Set min date to a past date

            timeInput.value = currentTimeString;
        }
        window.onload = setCurrentDateTime;
    </script>
</body>

</html>

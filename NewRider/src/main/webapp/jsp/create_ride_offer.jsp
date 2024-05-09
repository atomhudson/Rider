<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page errorPage="login.jsp" %>
 <%    
    String firstname = null;
    String lastname = null;
    String email = null;
    session = request.getSession(false);
    if (session == null) {
        response.sendRedirect("html/login_sessionFailed.html");
    } else {
    	firstname = (String) session.getAttribute("fname");
        lastname = (String) session.getAttribute("lname");
        email = (String) session.getAttribute("email");
    }
    String fullname = firstname.substring(0,1).toUpperCase()+firstname.substring(1).toLowerCase() + " " + lastname.substring(0,1).toUpperCase() + lastname.substring(1).toLowerCase();
 %>  
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="author" content="Clinton Nkwocha">
    <meta name="description" content="Rider is a carpooling application that provides drivers with the ability to create ride offers and passengers to join available ride offers.">
    <meta name="keywords" content="rider, carpool, carpooling, car, pool, offer ride">
    <meta name="language" content="English">
    <meta name="theme-color" content="#2c3e50">
    <meta name="viewport" content="width=device-width">
    <title>Create Ride Offer - Rider</title>
    <link href="https://fonts.googleapis.com/css?family=Capriola" rel="stylesheet">
    <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/reset.min.css" type="text/css">
    <link rel="stylesheet" href="../css/style.css" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script type="text/javascript" src="../js/script.js"></script>
  </head>
  <body>
    <div id="container">
      <nav id="navbar">
        <a href="../"><img src="../images/rider-big.png" alt="rider-logo" title="Rider | Live, Ride, Share"></a>
        <input type="checkbox" id="burger-toggle">
        <label id="burger" for="burger-toggle">
          <div></div>
        </label>
        <ul>
        <li>
          <a href="index.jsp" class="shortcut">Home</a>
        </li>
        <li>
          <a href="#" class="shortcut">Offer Ride</a>
        </li>
        <li>
          <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%= fullname%></a>
        </li>
        <li>
          <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
        </li>
      </ul>
      </nav>
      <section class="spread">
        <h2>Create Ride Offer</h2>
        <form action="../Create_Ride_Offer" method="post">
  			<input type="text" name="departure" id="departure" placeholder="Departure" title="Tip: Use the nearest bus stop to you for optimal results." required>
  			<input type="text" name="destination" id="destination" placeholder="Destination" title="Tip: Use the nearest bus stop to your destination for optimal results." required>
  			<input type="date" name="date" id="date" title="Input date of departure." required>
  			<input type="time" name="time" id="time" title="Input time of departure. e.g 06:00 PM" required>
  			<input type="number" name="available-seats" min="1" id="available-seats" placeholder="Available Seats for others" required>
  			<input type="number" name="price" min="50" step="5" id="price" placeholder="Price &#8377; (per person)" title="Input price for the ride.">
  			<input type="submit" class="pill" value="Offer Ride">
		</form>
      </section>
    </div>
     <script>
     const departureInput = document.getElementById('departure');
     const destinationInput = document.getElementById('destination');
     const dateInput = document.getElementById('date');
     const timeInput = document.getElementById('time');

     departureInput.addEventListener('input', checkInputValues);
     destinationInput.addEventListener('input', checkInputValues);

     function checkInputValues() {
       // Convert both inputs to lowercase before comparing
       const departureValue = departureInput.value.toLowerCase();
       const destinationValue = destinationInput.value.toLowerCase();

       if (departureValue === destinationValue) {
         alert("Departure and destination cannot be the same.");
         // You can also clear the destination input value here or take any other action as needed.
         destinationInput.value = '';
       }
     }

     function setCurrentDateTime() {
       var currentDate = new Date();
       var currentDateString = currentDate.toISOString().slice(0, 10); // Format: YYYY-MM-DD
       var currentTimeString = currentDate.toTimeString().slice(0, 5); // Format: HH:MM
       
       dateInput.value = currentDateString;
       dateInput.min = currentDateString;
       
       timeInput.value = currentTimeString;
     }

     window.onload = setCurrentDateTime;

</script>
  </body>
 
</html>
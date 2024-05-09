<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page errorPage="login.jsp" %>
<%    
    String firstname = null;
    String lastname = null;
    session = request.getSession(false);
    if (session == null) {
        response.sendRedirect("html/login_sessionFailed.html");
    } else {
        firstname = (String) session.getAttribute("fname");
        lastname = (String) session.getAttribute("lname");    
    }
    String fullName = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase() + " " +lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
 %>
<!Doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="author" content="clinton nkwocha">
  <meta name="description"
    content="rider is a carpooling application that provides drivers with the ability to create ride offers and passengers to join available ride offers.">
  <meta name="keywords" content="rider, carpool, carpooling, car, pool, offer ride">
  <meta name="language" content="english">
  <meta name="theme-color" content="#2c3e50">
  <meta name="viewport" content="width=device-width">
  <title>Rider | Live, Ride, Share</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=mukta:wght@200;300;400;500;600;700;800&family=roboto+mono:ital,wght@1,100&display=swap"
    rel="stylesheet">
  <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="../css/reset.min.css" type="text/css">
  <link rel="stylesheet" href="../css/style.css" type="text/css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

</head>

<body>
  <div id="container">
    <nav id="navbar">
      <a href="#"><img src="../images/rider-big.png" alt="rider-logo" title="rider | live, ride, share"></a>
      <input type="checkbox" id="burger-toggle">
      <label id="burger" for="burger-toggle">
        
      </label>
      <ul>
        <li>
          <a href="#" class="shortcut">Home</a>
        </li>
        <li>
          <a href="create_ride_offer.jsp" class="shortcut">Offer Ride</a>
        </li>
        <li>
          <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%= fullName %></a>
        </li>
        <li>
          <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
        </li>
      </ul>
    </nav>	
    <section id="wrap">
  <main>
    <h1>Rider</h1>
    <p>Carpooling shouldn't be that hard, right?</p>
    <form action="../Search_Ride_Login" method="post">
    	<input type="text" id="departure" name="departure" placeholder="Departure" title="Tip: Use the nearest bus stop to you for optimal results." required>
    	<input type="text" id="destination" name="destination" placeholder="Destination" title="Tip: Use the nearest bus stop to your destination for optimal results." required>
    	<input type="date" id="date" name="date" required>
    	<input type="time" id="time" name="time" required>
    	<input type="submit" value="Search Rides" class="pill">
  </form>
  </main>
</section>

    <!-- section 2 -->
    <section class="more">
      <h2>Why Rider?</h2>
      <div class="description" id="description-one">
        <div class="image-box"></div>
        <div class="word-box">
          <p>Rider is a carpooling application that provides drivers with the ability to <a
              href="../html/create-ride-offer.html" class="shortcut" style="color: rgb(0, 128, 255);">create ride offers</a> and passengers to join
            available ride offers.</p>
          <p>With rider, you get to optimize the use of your ride, save fuel, money, time and most of all: you get to
            share! <a href="../html/signup.html" class="shortcut" style="color: rgb(0, 128, 255);">Sign up</a> now to see how easy carpooling can be.
            seriously <a href="../html/signup.html" class="shortcut" style="color: rgb(0, 128, 255);">Sign up</a> now.</p>
        </div>
      </div>
    </section>

    <!-- section 2 -->
    <section class="more">
      <h2>Grab The Wheel!</h2>
      <div class="description" id="description-two">
        <div class="image-box"></div>
        <div class="word-box">
          <p>Getting started with rider is as easy as just one click. all you have to do is <a href="../html/signup.html"
              class="shortcut" style="color: rgb(0, 128, 255);">Sign up</a>, <a href="create_ride_offer.jsp" class="shortcut" style="color: rgb(0, 128, 255);">Create a ride
              offer</a> (if you want to offer a ride) and wait for requests.</p>
          <p>After creating a ride offer, you recieve requests from people who would like to ride with you, you can
            either accept or reject them and you're done.</p>
          <p>See, it's that easy. <a href="../html/signup.html" class="shortcut" style="color: rgb(0, 128, 255);">Sign up</a> now to ride your way!</p>
        </div>
      </div>
      <div id="btn-wrap">
        <a href="../html/signup.html" class="pill">Sign up</a>
        <a href="../html/login.html" class="pill">Log in</a>
      </div>
    </section>
  
  <!--Cards-->  
    <div class="cards">
      <div class="container">
        <div class="card">
          <img src="../images/security.png" alt="security icon">
          <h2>Secure Rides</h2>
          <p>Our platform ensures the safety and security of both drivers and passengers through thorough background
            checks and user verification processes.</p>
        </div>
        <div class="card">
          <img src="../images/trust.png" alt="trust icon">
          <h2>Trustworthy Service</h2>
          <p>With our community-based rating system and user reviews, you can trust that you're sharing rides with
            reliable and respectful individuals.</p>
        </div>
        <div class="card">
          <img src="../images/convenience.png" alt="convenience icon">
          <h2>Convenient Booking</h2>
          <p>Booking a ride is quick and easy with our intuitive app. find nearby drivers, schedule rides in advance,
            and enjoy hassle-free travel.</p>
        </div>
      </div>
    </div>
    
    <footer>
      <span>&copy; 2024 Rider</span>
      <span>Made By <a href="https://github.com/atomhudson" target="_blank" rel="noopener">Prashant Saini</a></span>
    </footer>
  </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script type="text/javascript" src="../js/script.js"></script>
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

</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.sql.Date, java.sql.Time,javax.servlet.http.Cookie" %>
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
String fullName = "";
if (firstname != null && lastname != null) {
    fullName = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase() + " " + lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
}
HttpSession session2 = request.getSession(false);

ArrayList<HashMap<String, Object>> rides = (ArrayList<HashMap<String, Object>>) session2.getAttribute("rides");
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
  <title>Available Ride(s) - Rider</title>
  <link href="https://fonts.googleapis.com/css?family=Capriola" rel="stylesheet">
  <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="../css/reset.min.css" type="text/css">
  <link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<body>
<div id="container">
  <nav id="navbar">
    <a href="./"><img src="../images/rider-big.png" alt="rider-logo" title="Rider | Live, Ride, Share"></a>
    <input type="checkbox" id="burger-toggle">
    <label id="burger" for="burger-toggle">
      <div></div>
    </label>
    <ul>
        <li>
          <a href="index.jsp" class="shortcut">Home</a>
        </li>
        <li>
          <a href="create_ride_offer.jsp" class="shortcut">Offer Ride</a>
        </li>
        <li>
          <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%=fullName%></a>
        </li>
        <li>
          <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
        </li>
      </ul>
  </nav>
  <section class="spread">
    <h2>Available Ride(s)</h2>
    <ul id="rides">
      <% for(HashMap<String, Object> ride : rides) { %>
        <li class="ride">
          <div>
            <ul>
            <% 
            	String fname = ride.get("fname").toString();
            	String lname = ride.get("lname").toString();
	            String fullname = fname.substring(0, 1).toUpperCase() + fname.substring(1).toLowerCase() + " " +lname.substring(0, 1).toUpperCase() + lname.substring(1).toLowerCase();
	            String rideId = ride.get("rideId").toString();
	            String email = ride.get("rider_email").toString();
	            
	            Cookie cookie = new Cookie("rideId", rideId);
	            response.addCookie(cookie);
	            
            %>
              <li><strong>Departure: </strong><%= ride.get("Departure")%></li>
              <li><strong>Destination: </strong><%= ride.get("Destination") %></li>
              <li><strong>Date: </strong><%= ride.get("Date") %></li>
              <li><strong>Time: </strong><%= ride.get("Time") %></li>
              <li><strong>Price: </strong><%= ride.get("Price")%></li>
              <li><strong>Rider: </strong><a href="rider.jsp" class="shortcut" onclick="setRideEmailCookie('<%=email%>')"><%=fullname%></a></li>
            </ul>
            <a href="ride_details.jsp" class="pill" onclick="setRideIdCookie('<%=rideId%>')">Ride Details</a>
			<script>
    			function setRideIdCookie(rideId) {
        			document.cookie = "rideId=" + rideId;
    			}
    			function setRideEmailCookie(email) {
        			document.cookie = "rider_email=" + email;
    			}
			</script>
          </div>
        </li>
      <% } %>
    </ul>
  </section>
</div>
</body>
</html>

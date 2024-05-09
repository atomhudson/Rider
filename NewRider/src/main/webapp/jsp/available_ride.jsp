<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.sql.Date, java.sql.Time" %>

<%
ArrayList<HashMap<String, Object>> rides = (ArrayList<HashMap<String, Object>>) request.getAttribute("rides");
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
  <link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="./css/reset.min.css" type="text/css">
  <link rel="stylesheet" href="./css/style.css" type="text/css">
</head>
<body>
<div id="container">
  <nav id="navbar">
    <a href="./"><img src="./images/rider-big.png" alt="rider-logo" title="Rider | Live, Ride, Share"></a>
    <input type="checkbox" id="burger-toggle">
    <label id="burger" for="burger-toggle">
      <div></div>
    </label>
    <ul>
      <li>
        <a href="../" class="shortcut">Home</a>
      </li>
      <li>
        <a href="./Index_Session" class="shortcut">Offer Ride</a>
      </li>
      <li>
        <a href="./html/signup.html" class="shortcut">Sign Up</a>
      </li>
      <li>
        <a href="./html/login.html" class="shortcut">Log In</a>
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
            String firstname = ride.get("fname").toString();
            String lastname = ride.get("lname").toString();

            String fullName = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase() + " " +
                              lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
  		
			%>
              <li><strong>Departure: </strong><%= ride.get("Departure") %></li>
              <li><strong>Destination: </strong><%= ride.get("Destination") %></li>
              <li><strong>Date: </strong><%= ride.get("Date") %></li>
              <li><strong>Time: </strong><%= ride.get("Time") %></li>
              <li><strong>Price: </strong><%= ride.get("Price") %></li>
              <li><strong>Rider: </strong><a href="#" class="shortcut"><%= fullName%></a></li>
            </ul>
            <a href="jsp/login.jsp" class="pill">Ride Details</a>
          </div>
        </li>
      <% } %>
    </ul>
  </section>
</div>
</body>
</html>

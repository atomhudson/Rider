<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page errorPage="login.jsp" %>
<%@ page import="java.util.ArrayList,java.util.HashMap,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%    
    session = request.getSession(false);
    ArrayList<HashMap<String, Object>> rides = (ArrayList<HashMap<String, Object>>) session.getAttribute("rides");
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
    <title>Ride Details - Rider</title>
    <link href="https://fonts.googleapis.com/css?family=Capriola" rel="stylesheet">
    <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/reset.min.css" type="text/css">
    <link rel="stylesheet" href="../css/style.css" type="text/css">
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
            <a href="#" class="shortcut">Home</a>
          </li>
          <li>
            <a href="#" class="shortcut">All Users</a>
          </li>
          <li>
            <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
          </li>
        </ul>
      </nav>
      <section class="spread">
        <h2>Ride(S)</h2>
        <% for(HashMap<String, Object> ride : rides) { %>
        <div id="details-wrap" style="display: inline-block; padding: 5px; margin: 10px">
          <ul>
          <%
          	String RideId = ride.get("rideId").toString();
          	String Departure = ride.get("Departure").toString();
          	String Destination = ride.get("Destination").toString();
          	String Date = ride.get("Date").toString();
          	String Time = ride.get("Time").toString();
          	String Available_Seats = ride.get("Seats").toString();
          	String price = ride.get("Price").toString();
          	String email = ride.get("rider_email").toString();
          	String ridecreated = ride.get("ridecreated").toString();
          %>
            <li><strong>Ride ID: </strong><%= RideId%></li>
            <li><strong>Departure: </strong><%= Departure.substring(0, 1).toUpperCase() + Departure.substring(1).toLowerCase() %></li>
            <li><strong>Destination: </strong><%= Destination.substring(0, 1).toUpperCase() + Destination.substring(1).toLowerCase() %></li>
            <li><strong>Date: </strong><%= Date %></li>
            <li><strong>Time: </strong><%= Time %></li>
            <li><strong>Available Seats: </strong><%= Available_Seats%></li>
            <li><strong>Price(Per Person): </strong><%= price %></li>
            <li><strong>Ride Created on : </strong><%= ridecreated%></li>
            <li><strong>Rider: </strong><a href="#" class="shortcut"><%=email%></a></li>
          </ul>
        </div>
        <%} %>
      </section>
    </div>
  </body>
</html>
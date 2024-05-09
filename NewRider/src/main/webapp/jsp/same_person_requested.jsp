<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page errorPage="login.jsp" %>
<%@ page isErrorPage="true"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
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
String fullname = firstname.substring(0,1).toUpperCase()+firstname.substring(1).toLowerCase() + " " + lastname.substring(0,1).toUpperCase()+lastname.substring(1).toLowerCase();
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
          <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%= fullname%></a>
        </li>
        <li>
          <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
        </li>
      </ul>
  </nav>
  <section class="spread">
            <h2>Requesting this ride is not an option at the moment.</h2>
            <ul id="rides">
                <li>
                    <h3 style="color: red;">Your are same who create this ride offer</h3>         
                </li>
            </ul>
            
            
        </section>
</div>
</body>
</html>

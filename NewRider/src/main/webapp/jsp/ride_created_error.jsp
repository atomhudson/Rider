<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page errorPage="login.jsp" %>
<%@ page isErrorPage="true"%>
<%@ page import="java.io.*, java.util.*,javax.servlet.*, javax.servlet.http.*" %>
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
exception = (Exception) request.getAttribute("Exception");
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
          <a href="#" class="shortcut">Home</a>
        </li>
        <li>
          <a href="jsp/create_ride_offer.jsp" class="shortcut">Offer Ride</a>
        </li>
        <li>
          <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%= fullname%></a>
        </li>
        <li>
          <a href="../Logout" class="shortcut" style="color: white; background-color:black; border-radius: 5.5px;">Log out</a>
        </li>
      </ul>
  </nav>
  <section class="spread">
            <h2>Available Ride(s)</h2>
            <ul id="rides">
                <li>
                    <h3 style="color: red;">Ride Offer Creation Unsuccessful</h3>
                    <a href="#" id="error-link" class="error-link"
                        style="color: sky-blue; text-decoration: underline;">Please review the error details.</a>
                </li>
            </ul>
            <div id="error-details" style="display: none; color: red;">
                <%= exception.toString() %>
            </div>
            <script>
                document.getElementById("error-link").addEventListener("click", function (event) {
                    event.preventDefault(); 
                    document.getElementById("error-details").style.display = "block"; 
                });
            </script>
        </section>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection,javax.servlet.http.Cookie,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>

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

String requestId = null;
Cookie[] ck = request.getCookies();
if (ck != null) {
    for (Cookie c : ck) {
        if ("requestId".equals(c.getName())) {
            requestId = c.getValue();
            break;
        }
    }
}
String rideId = (String) request.getAttribute("rideId");
String email = (String) request.getAttribute("email");
String status = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
    PreparedStatement psmt = con.prepareStatement("SELECT * FROM request WHERE requestid = ?");
    psmt.setString(1, requestId);

    ResultSet rs = psmt.executeQuery();
    
    if (rs.next()) {
        status = rs.getString("status");
    }else{
    	PreparedStatement ps = con.prepareStatement("SELECT * FROM request WHERE rideId = ? and email = >");
        ps.setString(1, rideId);
        ps.setString(2, email);
        ResultSet rs1 = ps.executeQuery();
        if (rs.next()) {
            status = rs1.getString("status");
    	}
    }
    con.close(); // Close connection
} catch (Exception e) {
    e.printStackTrace(); // Print stack trace for debugging purposes
}

String fullName = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase() + " " + lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
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
  <title>Ride Request Status - Rider</title>
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
  <section class="spread">
    <h2>Ride Request Status</h2>
    <ul id="rides">
        <li>
            <h3 style="color: green">Currently, Your Ride Request Status is </h3>
            <% if (status != null) { %>
                <h2 style="color: Red"><%= status.substring(0, 1).toUpperCase() + status.substring(1).toLowerCase() %></h2>
            <% } else { %>
                <h2 style="color: Red">Unknown</h2>
            <% } %>
        </li>
    </ul>
  </section>
</div>
</body>
</html>

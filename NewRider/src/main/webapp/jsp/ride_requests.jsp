<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException,javax.servlet.http.Cookie" %>
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
    
    String fullName = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase() + " " + lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
    
    ArrayList<HashMap<String, Object>> email_request = (ArrayList<HashMap<String, Object>>) request.getAttribute("email_request");
    
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
  <title>Ride Request(s) - Rider</title>
  <link href="https://fonts.googleapis.com/css?family=Capriola" rel="stylesheet">
  <link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="./css/reset.min.css" type="text/css">
  <link rel="stylesheet" href="./css/style.css" type="text/css">
</head>
<body>
<div id="container">
  <nav id="navbar">
    <a href="jsp/index.jsp"><img src="./images/rider-big.png" alt="rider-logo" title="Rider | Live, Ride, Share"></a>
    <input type="checkbox" id="burger-toggle">
    <label id="burger" for="burger-toggle">
      <div></div>
    </label>
    <ul>
      <li>
        <a href="jsp/index.jsp" class="shortcut">Home</a>
      </li>
      <li>
        <a href="jsp/create_ride_offer.jsp" class="shortcut">Offer Ride</a>
      </li>
      <li>
        <a href="jsp/rider_profile.jsp" class="shortcut" style="color: Blue"><%= fullName %></a>
      </li>
      <li>
        <a href="./Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
      </li>
    </ul>
  </nav>
  <section class="spread">
    <h2>Ride Request(s)</h2>
    <div id="details-wrap">
      <ul>
        <% for(HashMap<String, Object> email : email_request) { %>
        <li class="requests">
          <%
            String email_requested = (String) email.get("email");
            String rideId = (String) email.get("rideid");
            String fname = "";
            String lname = "";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
                PreparedStatement ps = c.prepareStatement("SELECT * FROM signup WHERE email = ?");
                ps.setString(1, email_requested);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    Cookie cookie = new Cookie("ride_takker", email_requested);
                    response.addCookie(cookie);
                    fname = rs.getString("fname").substring(0, 1).toUpperCase() + rs.getString("fname").substring(1).toLowerCase();
                    lname = rs.getString("lname").substring(0, 1).toUpperCase() + rs.getString("lname").substring(1).toLowerCase();
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception for debugging purposes
            }
          %>
          <form action="jsp/rider_profile_request.jsp" method="post" id="profileForm" style="display: inline-block;">
            <input type="hidden" name="rider_email" value="<%= email_requested %>">
            <button type="submit" class="shortcut" style="border: none; background: none; padding: 0; margin: 0; cursor: pointer;"><%= fname + " " + lname %></button>
          </form>
          <div style="display: inline-block;">
            <form action="./Accept_Request" method="post" id="acceptForm" style="display: inline-block;">
              <input type="hidden" name="rider_email" value="<%= email_requested %>">
              <input type="hidden" name="rideid" value="<%= rideId %>">
              <button type="submit" class="pill" style="background-color:green; border-radius: 20px; color: var(--bright); padding: 10px; text-decoration: none; text-align: center; margin-left: 10px; display: inline-block;">Accept</button>
            </form>
            <form action="./Reject_Request" method="post" id="rejectForm" style="display: inline-block;"> 
              <input type="hidden" name="rider_email" value="<%= email_requested %>">
              <input type="hidden" name="rideid" value="<%= rideId %>">
              <button type="submit" class="pill" id="cancel" style="background-color: red; border-radius: 20px; color: var(--bright); padding: 10px; text-decoration: none; text-align: center; margin-left: 10px; display: inline-block;">Reject</button>
            </form>
          </div>
        </li>
        <% } %>
      </ul>
    </div>
  </section>
</div>
</body>
</html>

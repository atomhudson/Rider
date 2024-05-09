<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "com.mysql.cj.protocol.Resultset,java.sql.Connection,javax.servlet.http.Cookie,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
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
    String fullName = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase() + " " +lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
    
    
    String rider_email = null;
    if (rider_email == null) {
        rider_email = request.getParameter("rider_email");
    }
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con  = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
    PreparedStatement psmt = con.prepareStatement("Select * from rides where email = ?");
    psmt.setString(1, rider_email);
    
    ResultSet rs = psmt.executeQuery();
    String fname = null;
    String lname = null;
    
    int ride_given = 0;
    while(rs.next()){
    	fname = rs.getString("fname").substring(0,1).toUpperCase() + rs.getString("fname").substring(1).toLowerCase();
    	lname = rs.getString("lname").substring(0,1).toUpperCase() + rs.getString("lname").substring(1).toLowerCase();
    	ride_given++;
    }
    PreparedStatement ps = con.prepareStatement("Select * from request where email = ?");
    ps.setString(1, rider_email);
    ResultSet rs2 = ps.executeQuery();
    int ride_taken = 0;
    while(rs2.next()){
    	ride_taken++;
    }
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
    <title>Rider Profile - Rider</title>
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
          <a href="jsp/index.jsp" class="shortcut">Home</a>
        </li>
        <li>
          <a href="jsp/create_ride_offer.jsp" class="shortcut">Offer Ride</a>
        </li>
        <li>
          <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%= fullName %></a>
        </li>
        <li>
          <a href="./Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
        </li>
      </ul>
      </nav>
      <section class="spread">
        <h2>Rider Profile</h2>
        <div id="details-wrap">
          <div id="profile-pics"></div>
          <h3 style="text-align: center;">change photo</h3>
          <ul>
            <li><strong>First Name: </strong><%=fname%></li>
            <li><strong>Last Name: </strong><%=lname%></li>
            <li><strong>Email Address: </strong><a href="#" class="shortcut"><%=rider_email%></a></li>
            <li><strong>Rides Given: </strong><strong><%= ride_given %></strong></li>
            <li><strong>Rides Taken: </strong><strong><%= ride_taken %></strong></li>
          </ul>
        </div>
      </section>
    </div>
  </body>
</html>
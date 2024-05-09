<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
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
    
    String RideId = request.getParameter("rideid");
    
    Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con  = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
	PreparedStatement psmt = con.prepareStatement("Select * from rides where rideid = ?");
	psmt.setString(1, RideId);
	
	String Firstname = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase();
	String Lastname = lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
	String Departure = null;
	String Destination = null;
	String Date = null;
	String Time = null;
	int Available_Seats=0;
	double price=0;
	
	ResultSet rs = psmt.executeQuery();
	boolean flag = true;
	while(rs.next()){
		flag = false;
		Departure = rs.getString("departure");
		Destination = rs.getString("destination");
		Date = rs.getString("Ddate");
		Time = rs.getString("Dtime");
		Available_Seats = rs.getInt("Seats");
		price = rs.getDouble("Price");
		
	}
    if(flag){
    	response.sendRedirect("ride_details_unavailable.jsp");
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
            <a href="./index.jsp" class="shortcut">Home</a>
          </li>
          <li>
            <a href="./create_ride_offer.jsp" class="shortcut">Offer Ride</a>
          </li>
          <li>
            <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%= Firstname + " " + Lastname %></a>
          </li>
          <li>
            <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
          </li>
        </ul>
      </nav>
      <section class="spread">
        <h2>Ride Details</h2>
        <div id="details-wrap">
          <ul>
            <li><strong>Ride ID: </strong><%= RideId%></li>
            <li><strong>Departure: </strong><%= Departure.substring(0, 1).toUpperCase() + Departure.substring(1).toLowerCase() %></li>
            <li><strong>Destination: </strong><%= Destination.substring(0, 1).toUpperCase() + Destination.substring(1).toLowerCase() %></li>
            <li><strong>Date: </strong><%= Date %></li>
            <li><strong>Time: </strong><%= Time %></li>
            <li><strong>Available Seats: </strong><%= Available_Seats%></li>
            <li><strong>Price(Per Person): </strong><%= price %></li>
            <li><strong>Rider: </strong><a href="#" class="shortcut"><%=Firstname + " " + Lastname%></a></li>
          </ul>
          <form action="../Delete_The_Ride" method="post" onsubmit="return confirm('Are you sure you want to cancel the ride?');">
                <button name="cancelride" id="cancel" class="pill">Cancel Ride</button>
          </form>
        </div>
      </section>
    </div>
  </body>
</html>

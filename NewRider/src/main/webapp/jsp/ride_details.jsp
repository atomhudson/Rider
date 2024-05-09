<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.Rider.RideDetailBean, java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Time,javax.servlet.http.Cookie" %>
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
  	String Firstname = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase();
 	String Lastname = lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();
  	String fullName = Firstname+" "+Lastname;
 	
  	 String rideID = null;
     Cookie[] ck = request.getCookies();
     if (ck != null) {
         for (Cookie c : ck) {
             if ("rideId".equals(c.getName())) {
                 rideID = c.getValue();
                 break;
             }
         }
     }
     
 	int Remaining_seats = 0;
 	
 	RideDetailBean rideDetails = RideDetailBean.getRideDetails(rideID);
 	
 	String fname = rideDetails.getFname();
 	String lname = rideDetails.getLname();
 	String departure = rideDetails.getDeparture().substring(0,1).toUpperCase()+rideDetails.getDeparture().substring(1).toLowerCase();
 	String destination = rideDetails.getDestination().substring(0,1).toUpperCase()+rideDetails.getDestination().substring(1).toLowerCase();
 	String date = rideDetails.getDate();
 	String time = rideDetails.getTime();
 	String rider_email = rideDetails.getEmail();
 	int seats = rideDetails.getSeats();
 	double price = rideDetails.getPrice();

 	if(fname == null || lname == null || departure == null || destination == null || date == null || time == null){
 		response.sendRedirect("ride_details_unavailable.jsp");
 	}
 	
 	String fullname = fname.substring(0,1).toUpperCase()+fname.substring(1).toLowerCase() + " " + lname.substring(0,1).toUpperCase() + lname.substring(1).toLowerCase();
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
            <a href="../" class="shortcut">Home</a>
          </li>
          <li>
            <a href="./create-ride-offer.html" class="shortcut">Offer Ride</a>
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
        <h2>Ride Details</h2>
        <div id="details-wrap">
          <ul>
            <li><strong>Departure: </strong><%=departure%></li>
            <li><strong>Destination: </strong><%=destination %></li>
            <li><strong>Date: </strong><%=date %></li>
            <li><strong>Time: </strong><%=time %></li>
            <li><strong>Available Seats: </strong><%=seats%></li>
            <li><strong>Remaining Seats: </strong>null</li>
            <li><strong>Price(Per Person): </strong><%=price%></li>
            <li><strong>Rider: </strong><a href="rider.jsp" class="shortcut" onclick="setRideEmailCookie('<%=rider_email%>')"><%=fullname %></a></li>
          </ul>
           <script>
    			function setRideEmailCookie(rider_email) {
        			document.cookie = "rider_email=" + rider_email;
    			}
			</script>
          <form action="../Ride_Request" method="post">
    	      	<input type="hidden" name="email" value="<%= email %>">
    			<input type="hidden" name="rideID" value="<%= rideID %>">
			 	<button type="submit" id="join" class="pill">Request to join</button>
		</form>
        </div>
        
      </section>
    </div>
  </body>
</html>
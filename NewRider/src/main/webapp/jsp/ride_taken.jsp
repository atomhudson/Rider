<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.HashMap, java.util.ArrayList, java.sql.Connection, javax.servlet.http.Cookie, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

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
    <title>Ride(s) Given - Rider</title>
    <link href="https://fonts.googleapis.com/css?family=Capriola" rel="stylesheet">
    <link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="./css/reset.min.css" type="text/css">
    <link rel="stylesheet" href="./css/style.css" type="text/css">
</head>
<body>
<div id="container">
    <nav id="navbar">
        <a href="../"><img src="./images/rider-big.png" alt="rider-logo" title="Rider | Live, Ride, Share"></a>
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
                <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
            </li>
        </ul>
    </nav>
    <section class="spread">
        <h2>Ride(s) Taken</h2>
        <ul id="rides">
            <% ArrayList<HashMap<String, Object>> rides_taken = (ArrayList<HashMap<String, Object>>) request.getAttribute("rides_given");

            try {
                if (rides_taken != null && !rides_taken.isEmpty()) {
                    for (HashMap<String, Object> ride_taken : rides_taken) {
                        String rideId = ride_taken.get("rideid").toString();
                        String status = ride_taken.get("status").toString();
                        
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
                        PreparedStatement psmt = con.prepareStatement("SELECT * FROM rides WHERE rideId = ?");
                        psmt.setString(1, rideId);

                        ResultSet rs = psmt.executeQuery();
                        while (rs.next()) {
                            String departure = rs.getString("departure");
                            String destination = rs.getString("destination");
                            String date = rs.getString("Ddate");
                            String time = rs.getString("Dtime");
                            String price = rs.getString("price");
                            String fname = rs.getString("fname").substring(0,1).toUpperCase()+rs.getString("fname").substring(1).toLowerCase();
                            String lname = rs.getString("lname").substring(0,1).toUpperCase()+rs.getString("lname").substring(1).toLowerCase();
                            String rider_email = rs.getString("email");
                            
             %>
            <li class="ride">
                <div>
                    <ul>
                        <li><strong>Departure: </strong><%=departure%></li>
                        <li><strong>Destination: </strong><%= destination %></li>
                        <li><strong>Date: </strong><%=date %></li>
                        <li><strong>Time: </strong><%=time %></li>
                        <li><strong>Price: </strong><%=price%></li>
                        <li><strong>Rider: </strong><a href="jsp/rider.jsp" class="shortcut" style="color: Blue"><%= fname+" "+lname %></a></li>
                        
                    </ul>
						<h3><strong>Status: </strong><span style="color:orange"><%= status %></span></h3>
                    <!--  <a href="./ride-details.html" class="pill">ride details</a>-->
                </div>
            </li>
            <%   
            }
                    con.close(); 
                }
            } else {
                // Handle case where no rides are available
                out.println("No rides available.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error retrieving ride information."+e);
        }
            %>
        </ul>
    </section>
</div>
</body>
</html>

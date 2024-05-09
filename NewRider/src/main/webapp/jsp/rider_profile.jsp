<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.HashMap, java.util.Map, java.util.Set, java.util.Map.Entry, com.Rider.DAO, java.sql.SQLException, java.sql.DriverManager, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
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
    String fullName = firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase() + " " + lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase();

    Connection con = null;
    PreparedStatement psmt = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    int ride_given = 0;
    int ride_taken = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
        psmt = con.prepareStatement("Select * from rides where email = ?");
        psmt.setString(1, email);
        rs = psmt.executeQuery();
        while (rs.next()) {
            ride_given++;
        }
        ps = con.prepareStatement("Select * from request where email = ?");
        ps.setString(1, email);
        rs = ps.executeQuery();
        while (rs.next()) {
            ride_taken++;
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (psmt != null) {
            try {
                psmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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
                <a href="index.jsp" class="shortcut">Home</a>
            </li>
            <li>
                <a href="create_ride_offer.jsp" class="shortcut">Offer Ride</a>
            </li>
            <li>
                <a href="#" class="shortcut" style="color: Blue"><%= fullName %></a>
            </li>
            <li>
                <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
            </li>
        </ul>
    </nav>
    <section class="spread">
        <h2>Rider Profile</h2>
        <div id="details-wrap">
            <%
                DAO db = new DAO();
                boolean flag = db.already_exist(email);
                if (flag) {
            %>
                <div id="profile-pics"></div>
            <% 
                } else {
            %>
                <div id="profile-pics" style="background-image: url('../GetProfilePhoto?email=<%=email%>')"></div>
            <%
                }
            %>  
            <ul>
                <li><strong>First Name: </strong><%=firstname.substring(0, 1).toUpperCase() + firstname.substring(1).toLowerCase()%></li>
                <li><strong>Last Name: </strong><%=lastname.substring(0, 1).toUpperCase() + lastname.substring(1).toLowerCase()%></li>
                <li><strong>Email Address: </strong><a href="mailto:<%=email%>" class="shortcut"><%=email%></a></li>
                <li><strong>Rides Given: </strong><a href="../Ride_Given" class="shortcut"><%=ride_given %></a></li>
                <li><strong>Rides Taken: </strong><a href="../Ride_Taken" class="shortcut"><%=ride_taken%></a></li>
            </ul>
        	<a class="pill " href="edit_profile.jsp">Edit Profile</a>
        	<br>
        	<a class="pill" href="registerVechile.jsp">Register Your Vehicle</a>
        </div>
        
    </section>
</div>
</body>
</html>

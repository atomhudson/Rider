<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    String fullname = firstname.substring(0,1).toUpperCase()+firstname.substring(1).toLowerCase() + " " + lastname.substring(0,1).toUpperCase() + lastname.substring(1).toLowerCase();
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
    <title>Edit Profile - Rider</title>
    <link href="https://fonts.googleapis.com/css?family=Capriola" rel="stylesheet">
    <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/reset.min.css" type="text/css">
    <link rel="stylesheet" href="../css/style.css" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script type="text/javascript" src="../js/script.js"></script>
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
          <a href="rider_profile.jsp" class="shortcut" style="color: Blue"><%= fullname%></a>
        </li>
        <li>
          <a href="../Logout" class="shortcut" style="color: white; background-color:red; border-radius: 5.5px; padding-right: 10px;">Log out <span style="border-left: 8px solid white; border-top: 8px solid transparent; border-bottom: 8px solid transparent; display: inline-block; vertical-align: middle;"></span></a>
        </li>
      </ul>
      </nav>
      <section class="spread">
        <h2>Edit Profile</h2>
        <form action="../EditProfile" method="post" enctype="multipart/form-data">
        	<input type="hidden" name ="email" value="<%=email%>">
        	<label>Change Your First Name</label>
  			<input type="text" name="fname" id="fnmae" placeholder="Change First Name" required>
  			<label>Change Your Last Name</label>
  			<input type="text" name="lname" id="lname" placeholder="Change Last Name" required>
  			<label>Change Your Profile Photo</label>
  			<input type="file" name="ufile" accept=".jpg,.png,.jpeg" required />
  			<input type="submit" class="pill" value="Edit Profile" title="Note: Only jpg, png, jpeg image type is allowed.">

		</form>
      </section>
    </div>
  </body>
</html>
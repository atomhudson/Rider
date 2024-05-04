<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
            <a href="./signup.html" class="shortcut">Sign Up</a>
          </li>
          <li>
            <a href="./login.html" class="shortcut">Log In</a>
          </li>
        </ul>
      </nav>
      <section class="spread">
        <h2>Ride Request(s)</h2>
        <div id="details-wrap">
          <ul>
            <li class="requests">
              <a href="./rider-profile.html" class="shortcut">kasmi kleva</a>
              <span>
                <button class="pill">Accept</button>
                <button class="pill" id="cancel">Reject</button>
              </span>
            </li>
            <li class="requests">
              <a href="./rider-profile.html" class="shortcut">kasmi kleva</a>
              <span>
                <button class="pill">Accept</button>
                <button class="pill" id="cancel">Reject</button>
              </span>
            </li>
            <li class="requests">
              <a href="./rider-profile.html" class="shortcut">kasmi kleva</a>
              <span>
                <button class="pill">Accept</button>
                <button class="pill" id="cancel">Reject</button>
              </span>
            </li>
            <li class="requests">
              <a href="./rider-profile.html" class="shortcut">kasmi kleva</a>
              <span>
                <button class="pill">Accept</button>
                <button class="pill" id="cancel">Reject</button>
              </span>
            </li>
            <li class="requests">
              <a href="./rider-profile.html" class="shortcut">kasmi kleva</a>
              <span>
                <button class="pill">Accept</button>
                <button class="pill" id="cancel">Reject</button>
              </span>
            </li>
          </ul>
        </div>
      </section>
    </div>
  </body>
</html>
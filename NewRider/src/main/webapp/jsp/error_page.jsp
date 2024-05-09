<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
  <!Doctype html>
  <html lang="en">

  <head>
    <meta charset="utf-8">
    <meta name="author" content="clinton nkwocha">
    <meta name="description"
      content="rider is a carpooling application that provides drivers with the ability to create ride offers and passengers to join available ride offers.">
    <meta name="keywords" content="rider, carpool, carpooling, car, pool, offer ride">
    <meta name="language" content="english">
    <meta name="theme-color" content="#2c3e50">
    <meta name="viewport" content="width=device-width">
    <title>Rider | Live, Ride, Share</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
      href="https://fonts.googleapis.com/css2?family=mukta:wght@200;300;400;500;600;700;800&family=roboto+mono:ital,wght@1,100&display=swap"
      rel="stylesheet">
    <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/reset.min.css" type="text/css">
    <link rel="stylesheet" href="../css/style.css" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  </head>
  <body>
    <div id="container">
      <nav id="navbar">
        <a href="#"><img src="../images/rider-big.png" alt="rider-logo" title="rider | live, ride, share"></a>
        <input type="checkbox" id="burger-toggle">
        <label id="burger" for="burger-toggle">
        </label>
      </nav>
      <section id="wrap">
        <main>
          <h1>Error</h1>
          <p>${errorMessage}</p>
        </main>
      </section>
    </div>
  </body>
  </html>
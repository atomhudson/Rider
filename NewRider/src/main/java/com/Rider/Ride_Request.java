package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Ride_Request")
public class Ride_Request extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String SENDER_EMAIL = "riderco.by.prashantsaini@gmail.com";
    private static final String SENDER_PASSWORD = "zgue shsw lwml uqzy";

    private final EmailSender emailSender;

    public Ride_Request() {
        this.emailSender = new EmailSender(SENDER_EMAIL, SENDER_PASSWORD);
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            String rideId = request.getParameter("rideID");
            String email = request.getParameter("email");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root","Warning@09@");
            PreparedStatement psmt = con.prepareStatement("SELECT * FROM rides WHERE rideid = ?");
            psmt.setString(1, rideId);

            ResultSet rs = psmt.executeQuery();

            if (rs.next()) {
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                String email_ride_created = rs.getString("email");
                String departure = rs.getString("departure");
                String destination = rs.getString("destination");
                double price = rs.getDouble("price");
                String date = rs.getString("Ddate");
                String time = rs.getString("Dtime");

                if (email.equals(email_ride_created)) {
                    response.sendRedirect("jsp/same_person_requested.jsp");
                } else {
                    PreparedStatement ps = con.prepareStatement("Select * from request where rideid = ? and email = ? ");
                    ps.setString(1, rideId);
                    ps.setString(2, email);
                    ResultSet already_requested = ps.executeQuery();
                    if (already_requested.next()) {
                    	request.setAttribute("rideId", rideId);
                    	request.setAttribute("email", email);
                        RequestDispatcher rd = request.getRequestDispatcher("jsp/ride_status.jsp");
                        rd.forward(request, response);
                    } else {
                        Random random = new Random();
                        int randomNumber = random.nextInt(0xFFFFFF + 1);

                        String requestId = String.format("%06X", randomNumber);
                        Cookie cookie = new Cookie("requestId", requestId);
                        response.addCookie(cookie);

                        String status = "pending";
                        PreparedStatement addrequeset = con.prepareStatement("Insert into request value(?,?,?,?,NOW())");
                        addrequeset.setString(1, requestId);
                        addrequeset.setString(2, rideId);
                        addrequeset.setString(3, email);
                        addrequeset.setString(4, status);

                        int r = addrequeset.executeUpdate();
                        if (r > 0) {
                            sendConfirmationEmail(email, departure, destination, date, time, price, status);
                            sendNotificationEmail(email_ride_created, fname, lname, departure, destination, date, time);
                            response.sendRedirect("jsp/ride_request_sent.jsp");
                        } else {
                            response.sendRedirect("jsp/ride_request_error.jsp");
                        }
                    }
                }
            } else {
                response.sendRedirect("jsp/ride_details_unavailable.jsp");
            }
        } catch (Exception e) {
            out.print(e);
        }
    }

    private void sendConfirmationEmail(String recipientEmail, String departure, String destination, String date, String time, double price, String status) {
        String subject = "Ride Request Confirmation - Rider Co.";
        String content = "<!DOCTYPE html>\r\n"
        		+ "<html lang=\"en\">\r\n"
        		+ "\r\n"
        		+ "<head>\r\n"
        		+ "    <meta charset=\"UTF-8\">\r\n"
        		+ "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n"
        		+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
        		+ "    <title>Ride Request Notification</title>\r\n"
        		+ "    <style>\r\n"
        		+ "        body {\r\n"
        		+ "            font-family: Arial, sans-serif;\r\n"
        		+ "            background-color: #f4f4f4;\r\n"
        		+ "            padding: 20px;\r\n"
        		+ "        }\r\n"
        		+ "\r\n"
        		+ "        .container {\r\n"
        		+ "            max-width: 600px;\r\n"
        		+ "            margin: 0 auto;\r\n"
        		+ "            background-color: #fff;\r\n"
        		+ "            padding: 30px;\r\n"
        		+ "            border-radius: 10px;\r\n"
        		+ "            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\r\n"
        		+ "        }\r\n"
        		+ "\r\n"
        		+ "        h2 {\r\n"
        		+ "            color: #008000;\r\n"
        		+ "        }\r\n"
        		+ "    </style>\r\n"
        		+ "</head>\r\n"
        		+ "\r\n"
        		+ "<body>\r\n"
        		+ "    <div class=\"container\">\r\n"
        		+ "        <h2>Your Ride Request From "+departure+" to "+destination+" Sent Successfully</h2>\r\n"
        		+ "        <p>Dear "+recipientEmail+",</p>\r\n"
        		+ "        <p>We're writing to inform you that you have requeseted for a ride from "+departure+" to "+destination+" on Rider Co. And your request sent Successfully to the rider</p>\r\n"
        		+ "        <ul>\r\n"
        		+ "            <li><strong>Departure: "+departure+"</strong></li>\r\n"
        		+ "            <li><strong>Destination: "+destination+"</strong></li>\r\n"
        		+ "            <li><strong>Date: "+date+"</strong></li>\r\n"
        		+ "            <li><strong>Time: "+time+"</strong></li>\r\n"
        		+ "            <li><strong>Price: "+price+"</strong></li>\r\n"
        		+ "            <li><strong>Status: "+status+"</strong></li>\r\n"
        		+ "        </ul>\r\n"
        		+ "        <p>Thank you for using Rider Co.</p>\r\n"
        		+ "        <h3>Best regards,</h3>\r\n"
        		+ "        <h2>Rider Co. Team</h2>\r\n"
        		+ "    </div>\r\n"
        		+ "</body>\r\n"
        		+ "\r\n"
        		+ "</html>";

        emailSender.sendEmail(recipientEmail, subject, content);
    }

    private void sendNotificationEmail(String recipientEmail, String fname, String lname, String departure, String destination, String date, String time) {
        String subject = "Ride Request Notification";
        String content = "<!DOCTYPE html>\r\n"
        		+ "<html lang=\"en\">\r\n"
        		+ "\r\n"
        		+ "<head>\r\n"
        		+ "    <meta charset=\"UTF-8\">\r\n"
        		+ "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n"
        		+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
        		+ "    <title>Ride Request Notification</title>\r\n"
        		+ "    <style>\r\n"
        		+ "        body {\r\n"
        		+ "            font-family: Arial, sans-serif;\r\n"
        		+ "            background-color: #f4f4f4;\r\n"
        		+ "            padding: 20px;\r\n"
        		+ "        }\r\n"
        		+ "\r\n"
        		+ "        .container {\r\n"
        		+ "            max-width: 600px;\r\n"
        		+ "            margin: 0 auto;\r\n"
        		+ "            background-color: #fff;\r\n"
        		+ "            padding: 30px;\r\n"
        		+ "            border-radius: 10px;\r\n"
        		+ "            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\r\n"
        		+ "        }\r\n"
        		+ "\r\n"
        		+ "        h2 {\r\n"
        		+ "            color: #008000;\r\n"
        		+ "        }\r\n"
        		+ "    </style>\r\n"
        		+ "</head>\r\n"
        		+ "\r\n"
        		+ "<body>\r\n"
        		+ "    <div class=\"container\">\r\n"
        		+ "        <h2>You have received a ride request on Rider Co.</h2>\r\n"
        		+ "        <p>Dear "+fname.substring(0,1).toUpperCase()+fname.substring(1).toLowerCase()+ " " +lname.substring(0,1).toUpperCase()+lname.substring(1).toLowerCase() +",</p>\r\n"
        		+ "        <p>We're writing to inform you that you have received a ride request on Rider Co. Please login to your account\r\n"
        		+ "            to view the details and respond accordingly.</p>\r\n"
        		+ "        <ul>\r\n"
        		+ "            <li><strong>Departure: "+departure+"</strong></li>\r\n"
        		+ "            <li><strong>Destination: "+destination+"</strong></li>\r\n"
        		+ "            <li><strong>Date: "+date+"</strong></li>\r\n"
        		+ "            <li><strong>Time: "+time+"</strong></li>\r\n"
        		+ "        </ul>\r\n"
        		+ "        <p>Thank you for using Rider Co.</p>\r\n"
        		+ "        <h3>Best regards,</h3>\r\n"
        		+ "        <h2>Rider Co. Team</h2>\r\n"
        		+ "    </div>\r\n"
        		+ "</body>\r\n"
        		+ "\r\n"
        		+ "</html>";
        emailSender.sendEmail(recipientEmail, subject, content);
    }
}

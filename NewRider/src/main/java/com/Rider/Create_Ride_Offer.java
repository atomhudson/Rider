package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Create_Ride_Offer
 */
@WebServlet("/Create_Ride_Offer")
public class Create_Ride_Offer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			
			HttpSession session = request.getSession(false);
			String fname = null;
			String lname = null;
			String email = null;
			if(session == null) {
				response.sendRedirect("html/login_sessionFailed.html");
			}else {
				fname = (String) session.getAttribute("fname");
				lname = (String) session.getAttribute("lname");
				email = (String) session.getAttribute("email");
			}
			
			Random random = new Random();
	        int randomNumber = random.nextInt(0xFFFFFF + 1);
	        
	        String rideId = String.format("%06X", randomNumber);
			String departure = request.getParameter("departure");
			String destination = request.getParameter("destination");
			String date = request.getParameter("date");
			String time = request.getParameter("time");
			int seats = Integer.parseInt(request.getParameter("available-seats"));
			double price = Double.parseDouble(request.getParameter("price"));
			
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con  = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
			PreparedStatement psmt = con.prepareStatement("Insert into rides values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, Now())");
			psmt.setString(1, rideId);
			psmt.setString(2, fname);
			psmt.setString(3, lname);
			psmt.setString(4, email);
			psmt.setString(5, departure);
			psmt.setString(6, destination);
			psmt.setString(7, date);
			psmt.setString(8, time);
			psmt.setInt(9, seats);
			psmt.setDouble(10, price);
			
			int confirm_ride_created = psmt.executeUpdate();
			if(confirm_ride_created != 0) {
				request.setAttribute("rideid", rideId);
				String sEmail="riderco.by.prashantsaini@gmail.com";
				String sPassword="ewzp qzwf byqv dwrn";
				
				Properties props=new Properties();
	            props.put("mail.smtp.host","smtp.gmail.com");
	            props.put("mail.smtp.socketFactory.port","465");
	            props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
	            props.put("mail.smtp.auth","true");
	            props.put("mail.smtp.port","465");
	            Session ses=Session.getInstance(props,
	                new javax.mail.Authenticator() {
	                    protected PasswordAuthentication getPasswordAuthentication(){
	                        return new PasswordAuthentication(sEmail,sPassword);
	                    }
	                }
	            );
	            Message message=new MimeMessage(ses);
	            message.setFrom(new InternetAddress(sEmail));
	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
	            message.setSubject("Ride Created Successfully from "+departure+" to "+destination+".");
	            message.setContent("<!DOCTYPE html>\r\n"
	            		+ "<html lang=\"en\">\r\n"
	            		+ "\r\n"
	            		+ "<head>\r\n"
	            		+ "    <meta charset=\"UTF-8\">\r\n"
	            		+ "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n"
	            		+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
	            		+ "    <title>Rider Co. - Ride Created</title>\r\n"
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
	            		+ "        <h2>Ride Successfully Created</h2>\r\n"
	            		+ "        <p>Dear Owner,</p>\r\n"
	            		+ "        <p>Your ride from <strong>"+departure+"</strong> to <strong>"+destination+"</strong> has been successfully created.</p>\r\n"
	            		+ "        <p>Details of your ride:</p>\r\n"
	            		+ "        <ul>\r\n"
	            		+ "            <li><strong>Ride Id:</strong> "+rideId+" </li>\r\n"
	            		+ "            <li><strong>Departure:</strong> "+departure+"</li>\r\n"
	            		+ "            <li><strong>Destination:</strong> "+destination+"</li>\r\n"
	            		+ "            <li><strong>Departure Date:</strong> "+date+"</li>\r\n"
	            		+ "            <li><strong>Departure Time:</strong> "+time+"IST (UTC+05:30)</li>\r\n"
	            		+ "            <li><strong>Pricing:</strong>&#8377; "+price+"/- person</li>\r\n"
	            		+ "            <li><strong>Available Seats:</strong> "+seats+"</li>\r\n"
	            		+ "            \r\n"
	            		+ "        </ul>\r\n"
	            		+ "        <p>Passengers can now view and request to join your ride.</p>\r\n"
	            		+ "        <p>Thank you for using Rider Co.</p>\r\n"
	            		+ "        <p>Sincerely,</p>\r\n"
	            		+ "        <h2>Rider Co. by Prashant Saini Team</h2>\r\n"
	            		+ "    </div>\r\n"
	            		+ "</body>\r\n"
	            		+ "\r\n"
	            		+ "</html>\r\n"
	            		+ "","text/html" );
	            Transport.send(message);	
				
				RequestDispatcher rs = request.getRequestDispatcher("jsp/ride_created_success.jsp");
				rs.forward(request, response);
			}else {
				response.sendRedirect("jsp/ride_created_error");
			}
		} catch (Exception e) {
			out.print(e);
		}
	}

}

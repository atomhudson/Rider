package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class Accept_Request
 */
@WebServlet("/Accept_Request")
public class Accept_Request extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SENDER_EMAIL = "riderco.by.prashantsaini@gmail.com";
    private static final String SENDER_PASSWORD = "ewzp qzwf byqv dwrn";

    private final EmailSender emailSender;

    public Accept_Request() {
        this.emailSender = new EmailSender(SENDER_EMAIL, SENDER_PASSWORD);
    }
    /**
     * @see HttpServlet#HttpServlet()
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
    	try {
			String email = request.getParameter("rider_email");
			String rideId = request.getParameter("rideid");
			String status = "accpeted";
			Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
            PreparedStatement ps = c.prepareStatement("UPDATE request SET status = ? WHERE email  = ? and rideid = ?");
            ps.setString(1, status);
            ps.setString(2, email);
            ps.setString(3, rideId);
            
            int r = ps.executeUpdate();
            findRideDetails(c, out, rideId, email, status);
            if(r >= 0) {
            	String status_formore = "pending";
            	PreparedStatement psmt = c.prepareStatement("SELECT * FROM request WHERE rideid = ? AND status = ?");
                psmt.setString(1, rideId);
                psmt.setString(2, status_formore);

                ResultSet rs = psmt.executeQuery();
                ArrayList<HashMap<String, Object>> emails = new ArrayList<>();
                while (rs.next()) {
                    HashMap<String, Object> emailData = new HashMap<>();
                    emailData.put("email", rs.getString("email"));
                    emailData.put("rideid", rs.getString("rideid"));
                    emails.add(emailData);
                }

                if (emails.isEmpty()) {
                    response.sendRedirect("jsp/ride_request_unavailable.jsp");
                } else {
                	
                    request.setAttribute("email_request", emails);
                    RequestDispatcher rd = request.getRequestDispatcher("jsp/ride_requests.jsp");
                    rd.forward(request, response);
                }
            }else {
            	response.sendRedirect("jsp/ride_request_unavailable.jsp");
            }
		} catch (Exception e) {
			String errorMessage = "An error occurred: " + e.getMessage();
		    request.setAttribute("errorMessage", errorMessage);
		    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/error_page.jsp");
		    dispatcher.forward(request, response);
		}
    }
    private void findRideDetails(Connection con, PrintWriter out, String rideid, String email, String status) {
    	try {
    		PreparedStatement ps = con.prepareStatement("Select * from rides where rideid = ?");
    		ps.setString(1, rideid);
    		
    		ResultSet rs = ps.executeQuery();
    		String departure = null;
    		String destination = null;
    		String date = null;
    		String time = null;
    		double price = 0;
    		if (rs.next()) {
    			departure = rs.getString("departure");
    			destination = rs.getString("destination");
    			date = rs.getString("Ddate");
    			time = rs.getString("Dtime");
    			price = rs.getDouble("price");
			}
    		String fullname = recipient(con, out, email);
    		sendConfirmationEmail(email, fullname, departure, destination, date, time, price, status);
		} catch (Exception e) {
			out.print(e);
		}    	
    }
    private String recipient (Connection c, PrintWriter out, String email) {
    	String fullname = null;
    	try {
    		PreparedStatement ps = c.prepareStatement("Select * from singup where email = ?");
    		ps.setString(1, email);
    		
    		ResultSet rs = ps.executeQuery();
    		String fname = null;
    		String lname = null;
    		if(rs.next()) {
    			fname = rs.getString("fname").substring(0,1).toUpperCase()+rs.getString("fname").substring(1).toLowerCase();
    			lname = rs.getString("lname").substring(0,1).toUpperCase()+rs.getString("lname").substring(1).toLowerCase();
    			fullname = fname + " " +lname;
    		}
		} catch (Exception e) {
			out.print(e);
		}
    	return fullname;
    }
    private void sendConfirmationEmail(String recipientEmail, String recipientFullname ,String departure, String destination, String date, String time, double price, String status) {
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
        		+ "\r\n"
        		+ "        .accepted {\r\n"
        		+ "            color: #008000;\r\n"
        		+ "            display: inline;\r\n"
        		+ "            font-size: 25px;\r\n"
        		+ "        }\r\n"
        		+ "    </style>\r\n"
        		+ "</head>\r\n"
        		+ "\r\n"
        		+ "<body>\r\n"
        		+ "    <div class=\"container\">\r\n"
        		+ "        <h2>Ride Accepted</h2>\r\n"
        		+ "        <p>Dear "+recipientFullname+",</p>\r\n"
        		+ "        <p>Your ride request has been <strong class=\"accepted\">Accepted</strong> by the ride creator.</p>\r\n"
        		+ "        <p>Ride Details:</p>\r\n"
        		+ "        <ul>\r\n"
        		+ "            <li><strong>Departure:</strong> "+departure+"</li>\r\n"
        		+ "            <li><strong>Destination:</strong> "+destination+"</li>\r\n"
        		+ "            <li><strong>Date:</strong> "+date+"</li>\r\n"
        		+ "            <li><strong>Time:</strong> "+time+"</li>\r\n"
        		+ "            <li><strong>Price:</strong> "+price+"</li>\r\n"
        		+ "            <li><strong>String:</strong> "+status+"</li>\r\n"
        		+ "        </ul>\r\n"
        		+ "        <p>Thank you for using our service.</p>\r\n"
        		+ "        <h3>Best Regards,</h3>\r\n"
        		+ "        <h2>Rider Co. Team</h2>\r\n"
        		+ "    </div>\r\n"
        		+ "</body>\r\n"
        		+ "\r\n"
        		+ "</html>\r\n"
        		+ "";
        emailSender.sendEmail(recipientEmail, subject, content);
    }

}

package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Signup
 */
@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Signup() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        PrintWriter out = response.getWriter();
        try {
        	String sEmail="riderco.by.prashantsaini@gmail.com";
			String sPassword="ewzp qzwf byqv dwrn";
        	
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("mail");
            String password = request.getParameter("pin");
            String confirmPassword = request.getParameter("pin2");

            Class.forName("com.mysql.cj.jdbc.Driver");
			Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
			PreparedStatement preparedStatement = c.prepareStatement("Insert into signup values(?,?,?,?)");
            preparedStatement.setString(1, firstname);
            preparedStatement.setString(2, lastname);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, password);
            
            if(password.equals(confirmPassword)) {
            	int rowsInserted = preparedStatement.executeUpdate();
            	if (rowsInserted > 0) {
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
                    message.setSubject("Welcome to Rider Co. by Prashant Saini");
                    message.setContent("<!DOCTYPE html>\r\n"
                    		+ "<html lang=\"en\">\r\n"
                    		+ "\r\n"
                    		+ "<head>\r\n"
                    		+ "    <meta charset=\"UTF-8\">\r\n"
                    		+ "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n"
                    		+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
                    		+ "    <title>Welcome to Rider Co.</title>\r\n"
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
                    		+ "        <h3>You have Successfully Signed up in to Rider Co.</h3>\r\n"
                    		+ "        <h2>Welcome, Prashant Saini!</h2>\r\n"
                    		+ "        <p>Your Email Id: <strong>"+email+"</strong></p>\r\n"
                    		+ "        <p>Now, you can easily login and offer or take ride(s).</p>\r\n"
                    		+ "        <h3>Thank you,</h3>\r\n"
                    		+ "        <h2>RiderCo. by Prashant Saini</h2>\r\n"
                    		+ "    </div>\r\n"
                    		+ "</body>\r\n"
                    		+ "\r\n"
                    		+ "</html>\r\n"
                    		+ "","text/html" );
                    Transport.send(message);
                    
                    response.sendRedirect("./index.html"); 
                } else {
                    response.sendRedirect("html/signup_not.html"); 
                }
            }else {
            	response.sendRedirect("html/signup_error.html");
            }
        }catch (SQLIntegrityConstraintViolationException se) {
        		response.sendRedirect("html/userexist.html");
		} catch (SQLException e) {
			String errorMessage = "An error occurred: " + e.getMessage();
		    request.setAttribute("errorMessage", errorMessage);
		    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/error_page.jsp");
		    dispatcher.forward(request, response);
        } catch (Exception ae) {
        	String errorMessage = "An error occurred: " + ae.getMessage();
		    request.setAttribute("errorMessage", errorMessage);
		    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/error_page.jsp");
		    dispatcher.forward(request, response);
        }
    }

}


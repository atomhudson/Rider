package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Otp
 */
@WebServlet("/Otp")
public class Otp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SENDER_EMAIL = "riderco.by.prashantsaini@gmail.com";
    private static final String SENDER_PASSWORD = "ewzp qzwf byqv dwrn";
    private final EmailSender emailSender;
    public Otp() {
    	this.emailSender = new EmailSender(SENDER_EMAIL, SENDER_PASSWORD);
    }
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out =response.getWriter();
		try {
		String email = request.getParameter("email");
		SignupDetailBean s = SignupDetailBean.getSignupDetails(email);
		String fname = s.getFirstName().substring(0,1).toUpperCase()+s.getFirstName().substring(1).toLowerCase();
		String lname = s.getLastName().substring(0,1).toUpperCase()+s.getLastName().substring(1).toLowerCase();
		String fullname = fname + " " + lname;
		
		Random random = new Random();
		
        int OTP = random.nextInt(9000) + 1000;
        
        HttpSession otpverfication = request.getSession();
        otpverfication.setAttribute("email", email);
        otpverfication.setAttribute("OTP", OTP);
        
		senOptEmail(email, fullname , OTP);
		RequestDispatcher rd = request.getRequestDispatcher("html/optverfication.html");
		rd.forward(request, response);
		}catch (Exception e) {
			// TODO: handle exception
			out.print(e);
		}
		

	}
	private void senOptEmail(String email, String fullname, int OTP) {
		 String subject = "Password Recovery - Rider Co.";
	     String content = "<!DOCTYPE html>\r\n"
	     		+ "<html lang=\"en\">\r\n"
	     		+ "\r\n"
	     		+ "<head>\r\n"
	     		+ "    <meta charset=\"UTF-8\">\r\n"
	     		+ "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n"
	     		+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
	     		+ "    <title>Password Recovery - Rider Co.</title>\r\n"
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
	     		+ "        <h2>Password Recovery - Rider Co.</h2>\r\n"
	     		+ "        <p>Hello "+fullname+",</p>\r\n"
	     		+ "        <p>We received a request to reset your password. Below is your One-Time Password (OTP) for password recovery:</p>\r\n"
	     		+ "        <h2 style=\"text-align: center; color: #007bff;\">"+OTP+"</h2>\r\n"
	     		+ "        <p>Please use this OTP to reset your password. If you didn't request this, you can safely ignore this email.</p>\r\n"
	     		+ "        <p>Thank you,</p>\r\n"
	     		+ "        <h2>Rider Co. Team</h2>\r\n"
	     		+ "    </div>\r\n"
	     		+ "</body>\r\n"
	     		+ "\r\n"
	     		+ "</html>\r\n"
	     		+ "";
	     emailSender.sendEmail(email, subject, content);
		
	}
}

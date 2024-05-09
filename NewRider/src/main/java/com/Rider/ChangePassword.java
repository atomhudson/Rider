package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ChangePassword
 */
@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SENDER_EMAIL = "riderco.by.prashantsaini@gmail.com";
    private static final String SENDER_PASSWORD = "ewzp qzwf byqv dwrn";
    private final EmailSender emailSender;
    public ChangePassword() {
    	this.emailSender = new EmailSender(SENDER_EMAIL, SENDER_PASSWORD);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out =response.getWriter();
		try {
			HttpSession session = request.getSession(false);
			String email = session.getAttribute("email").toString();
			
			String password = request.getParameter("pin");
			String confirm_password = request.getParameter("pin2");

			if(password.equals(confirm_password)) {
				DAO db = new DAO();
				int r = db.update_password(email, password);
				if(r>0) {
					SignupDetailBean sd = SignupDetailBean.getSignupDetails(email);
					String fname = sd.getFirstName().substring(0,1).toUpperCase()+sd.getFirstName().substring(1).toLowerCase();
					String lname = sd.getLastName().substring(0,1).toUpperCase()+sd.getLastName().substring(1).toLowerCase();
					sendUpdatePassword(email, fname+" "+lname);
					RequestDispatcher rd = request.getRequestDispatcher("jsp/update_password_success.jsp");
					rd.forward(request, response);
				}else {
					RequestDispatcher rd = request.getRequestDispatcher("jsp/update_password_error.jsp");
					rd.forward(request, response);
				}
			}else {
				RequestDispatcher rd = request.getRequestDispatcher("jsp/changepassword_error.jsp");
				rd.forward(request, response);
			}
		}catch (Exception e) {
			out.print(e);
		}

	}
	private void sendUpdatePassword(String email, String fullname) {
		 String subject = "Password Recovery Successfully - Rider Co.";
	     String content = "<!DOCTYPE html>\r\n"
	     		+ "<html lang=\"en\">\r\n"
	     		+ "\r\n"
	     		+ "<head>\r\n"
	     		+ "    <meta charset=\"UTF-8\">\r\n"
	     		+ "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n"
	     		+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
	     		+ "    <title>Password Update Success - Rider Co.</title>\r\n"
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
	     		+ "        <h2>Password Update Successful - Rider Co.</h2>\r\n"
	     		+ "        <p>Hello "+fullname+",</p>\r\n"
	     		+ "        <p>Your password has been successfully updated for your Rider Co. account.</p>\r\n"
	     		+ "        <p>You can now log in with your new password and continue to enjoy our services.</p>\r\n"
	     		+ "        <h3>Thank you,</h3>\r\n"
	     		+ "        <h2>RiderCo. Team</h2>\r\n"
	     		+ "    </div>\r\n"
	     		+ "</body>\r\n"
	     		+ "\r\n"
	     		+ "</html>\r\n"
	     		+ "";
	     emailSender.sendEmail(email, subject, content);
	}
}

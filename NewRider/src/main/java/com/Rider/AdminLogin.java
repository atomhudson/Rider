package com.Rider;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("pin");
		
		AdminDetails ad = AdminDetails.getAdminDetails(email);
		String adminemail = ad.getAdminEmail();
		String adminpassword = ad.getAdminPassword();
		
		if(email.equals(adminemail) && password.equals(adminpassword)) {
			HttpSession session = request.getSession();
			session.setAttribute("adminemail", adminemail);
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin_index.jsp");
			rd.forward(request, response);
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("./index.html");
			rd.forward(request, response);
		}
		
	}

}

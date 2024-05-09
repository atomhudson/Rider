package com.Rider;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Index_Session
 */
@WebServlet("/Index_Session")
public class Index_Session extends HttpServlet {
	private static final long serialVersionUID = 1L;
    @Override
    	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		HttpSession sesssion = request.getSession(false);
    		if(sesssion == null) {
    			response.sendRedirect("html/login.html");;
    		}else {
    			response.sendRedirect("jsp/create_ride_offer.jsp");
    		}
    	
    	}

}

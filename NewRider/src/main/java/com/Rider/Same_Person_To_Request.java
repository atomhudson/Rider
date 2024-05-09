package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Same_Person_To_Request
 */
@WebServlet("/Same_Person_To_Request")
public class Same_Person_To_Request extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    @Override
    	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
    			try {
					HttpSession session = request.getSession(false);
					String email = (String)session.getAttribute("email");
					
					Cookie ck[] = request.getCookies();
					String rideID = null;
					for(Cookie c:ck) {
						rideID = c.getValue();
					}
				 	
				 	Class.forName("com.mysql.cj.jdbc.Driver");
				 	Connection con  = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
				 	PreparedStatement psmt = con.prepareStatement("Select * from rides where rideid = ? ");
				 	psmt.setString(1, rideID);
				 	
				 	ResultSet rs = psmt.executeQuery();
				 	
				 	if(rs.next()) {
				 		String email2 = rs.getString("email");
				 		if(email.equals(email2)) {
//				 			RideDetailBean ridedata2 = RideDetailBean.getRideDetails(rideID);
				 			response.sendRedirect("jsp/ride_details_no_request.jsp");
					 		
					 	}else {
					 		response.sendRedirect("jsp/ride_details.jsp");
					 	}
				 	}
				 	else {
				 		response.sendRedirect("jsp/ride_details_no_request.jsp");
				 	}
				 	
				 	
					
				} catch (Exception e) {
					
					out.print(e);
				}
    	}

}

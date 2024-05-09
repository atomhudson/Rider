package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Delete_Ride_Created
 */
@WebServlet("/Delete_The_Ride")
public class Delete_Ride_Created extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			Cookie ck[] = request.getCookies();
		    String RideId = null;
		    for(Cookie c : ck){
		    	 RideId = c.getValue();
		    }
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
			PreparedStatement psmt = c.prepareStatement("Delete from rides where rideid = ?");
			psmt.setString(1, RideId);
			
			int count_delete_query_affected = psmt.executeUpdate();
			if(count_delete_query_affected != 0) {
				response.sendRedirect("jsp/ride_deleted_success.jsp");
			}else {
				response.sendRedirect("jsp/ride_deleted_error.jsp");
			}
			
		} catch (Exception e) {
			out.print(e);
		}
			
	}

}

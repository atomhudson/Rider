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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Ride_Taken
 */
@WebServlet("/Ride_Taken")
public class Ride_Taken extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   PrintWriter out = response.getWriter();
		   	try {
				
		   		HttpSession session = request.getSession(false);
		   		String email = (String) session.getAttribute("email");
		   		
		   		Class.forName("com.mysql.cj.jdbc.Driver");
				Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
				PreparedStatement ps = c.prepareStatement("Select * from request where email = ?");
				ps.setString(1, email);
				
				ResultSet rs = ps.executeQuery();
				boolean flag = true;
				
				ArrayList<HashMap<String, Object>> rides_taken = new ArrayList<>() ;
				while(rs.next()) {
					flag = false;
					String rideId = rs.getString("rideId");
					String status = rs.getString("status");
					
					HashMap<String, Object> ride = new HashMap<>();
					ride.put("rideid", rideId);
					ride.put("status", status);
					rides_taken.add(ride);

				}
				
				if(flag) {
					response.sendRedirect("jsp/ride_details_unavailable.jsp");
				}else {
					request.setAttribute("rides_given", rides_taken);
					RequestDispatcher rd = request.getRequestDispatcher("jsp/ride_taken.jsp");
					rd.forward(request, response);
				}
			} catch (Exception e) {
				out.print(e);
			}
		}

}

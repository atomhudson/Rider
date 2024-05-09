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
 * Servlet implementation class Ride_Given
 */
@WebServlet("/Ride_Given")
public class Ride_Given extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   @Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   PrintWriter out = response.getWriter();
	   	try {
			
	   		HttpSession session = request.getSession(false);
	   		String email = (String) session.getAttribute("email");
	   		
	   		Class.forName("com.mysql.cj.jdbc.Driver");
			Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
			PreparedStatement ps = c.prepareStatement("Select * from rides where email = ?");
			ps.setString(1, email);
			
			ResultSet rs = ps.executeQuery();
			boolean flag = true;
			
			ArrayList<HashMap<String, Object>> rides_given = new ArrayList<>() ;
			while(rs.next()) {
				flag = false;
				String rideid = rs.getString("rideid");
				String depature = rs.getString("Departure").substring(0,1).toUpperCase()+rs.getString("Departure").substring(1).toLowerCase();
				String destination = rs.getString("Destination").substring(0,1).toUpperCase()+rs.getString("Destination").substring(1).toLowerCase();
				String date = rs.getString("Ddate");
				String time = rs.getString("Dtime");
				String fname = rs.getString("fname").substring(0,1).toUpperCase()+rs.getString("fname").substring(1).toLowerCase();
				String lname = rs.getString("lname").substring(0,1).toUpperCase()+rs.getString("lname").substring(0,1).toLowerCase();
				double price = rs.getDouble("price"); 
				
				HashMap<String, Object> ride = new HashMap<>();
				ride.put("rideid", rideid);
				ride.put("departure", depature);
				ride.put("destination", destination);
				ride.put("date", date);
				ride.put("time", time);
				ride.put("fname", fname);
				ride.put("lname", lname);
				ride.put("price", price);
				
				rides_given.add(ride);

			}
			
			if(flag) {
				response.sendRedirect("jsp/ride_details_unavailable.jsp");
			}else {
				request.setAttribute("rides_given", rides_given);
				RequestDispatcher rd = request.getRequestDispatcher("jsp/ride_given.jsp");
				rd.forward(request, response);
			}
		} catch (Exception e) {
			out.print(e);
		}
	}

}


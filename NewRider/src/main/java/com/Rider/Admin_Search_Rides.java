package com.Rider;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Admin_Search_Rides
 */
@WebServlet("/Admin_Search_Rides")
public class Admin_Search_Rides extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  @Override
  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  PrintWriter out = response.getWriter();
		try {
			HttpSession session = request.getSession(false);
			
			String departure = request.getParameter("departure");
			String destination = request.getParameter("destination");
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String dateString = request.getParameter("date");
			Date date = dateFormat.parse(dateString);
			String time = request.getParameter("time");
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling","root","Warning@09@");
			PreparedStatement ps = c.prepareStatement("SELECT * FROM rides WHERE Departure = ? AND Destination = ? AND (Ddate > ? OR (Ddate = ? AND Dtime >= ?))");

			
			ps.setString(1, departure);
			ps.setString(2, destination);
			ps.setDate(3, new java.sql.Date(date.getTime()));
	        ps.setDate(4, new java.sql.Date(date.getTime()));
			ps.setString(5, time);
			
			ResultSet rs = ps.executeQuery();
			
			ArrayList<HashMap<String, Object>> rides = new ArrayList<>();
			boolean flag = true;
			while(rs.next()) {
				flag = false;
				String rideId = rs.getString("rideid");
				String firstname = rs.getString("fname");
				String lastname = rs.getString("lname");
				String depart = rs.getString("Departure").substring(0,1).toUpperCase()+rs.getString("Departure").substring(1).toLowerCase();
				String desti = rs.getString("Destination").substring(0,1).toUpperCase()+rs.getString("Destination").substring(1).toLowerCase();
				Date ddate =  rs.getDate("Ddate");
				Time dtime = rs.getTime("Dtime");
				Integer seats = rs.getInt("Seats");
				Double price = rs.getDouble("Price");
				String email = rs.getString("email");
				String ridecreated = rs.getString("ridecreated");
				
				HashMap<String, Object> ride = new HashMap<>();
				ride.put("rideId", rideId);
				ride.put("fname", firstname);
				ride.put("lname", lastname);
				ride.put("Departure", depart);
				ride.put("Destination", desti);
				ride.put("Date", ddate);
				ride.put("Time", dtime);
				ride.put("Seats", seats);
				ride.put("Price", price);
				ride.put("rider_email", email);
				ride.put("ridecreated", ridecreated);
				
				rides.add(ride);
				
			}
			if(flag) {
				response.sendRedirect("jsp/unavailable_rides_login.jsp");
			}else {
				session.setAttribute("rides", rides);
				response.sendRedirect("jsp/admin_available_rides.jsp");
//				RequestDispatcher rd = request.getRequestDispatcher("./jsp/admin_available_rides.jsp");
//				rd.forward(request, response);
			}
		} catch (Exception e) {
			out.print(e);
		}

  }

}

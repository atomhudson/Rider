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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class create_ride
 */
@WebServlet("/Search_Ride")
public class Search_Ride extends HttpServlet {
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
    				String firstname = rs.getString("fname");
    				String lastname = rs.getString("lname");
    				String depart = rs.getString("Departure");
    				String desti = rs.getString("Destination");
    				Date ddate =  rs.getDate("Ddate");
    				Time dtime = rs.getTime("Dtime");
    				Integer seats = rs.getInt("Seats");
    				Double price = rs.getDouble("Price");
    				String email = rs.getString("email");
    				
    				
    				HashMap<String, Object> ride = new HashMap<>();
    				ride.put("fname", firstname);
    				ride.put("lname", lastname);
    				ride.put("Departure", depart);
    				ride.put("Destination", desti);
    				ride.put("Date", ddate);
    				ride.put("Time", dtime);
    				ride.put("Seats", seats);
    				ride.put("Price", price);
    				ride.put("rider_email", email);
    				
    				rides.add(ride);
    				
    			}
    			if(flag) {
    				response.sendRedirect("html/unavailable_rides.html");
    			}else {
    				request.setAttribute("rides", rides);
    				RequestDispatcher rd = request.getRequestDispatcher("jsp/available_ride.jsp");
    				rd.forward(request, response);
    			}
			} catch (Exception e) {
				out.print(e);
			}
    		
    	}
}

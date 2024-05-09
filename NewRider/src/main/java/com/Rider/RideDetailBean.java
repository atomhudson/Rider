package com.Rider;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class RideDetailBean implements Serializable{
	private String fname;
	private String lname;
	private String departure;
	private String destination;
	private String Date;
	private String Time;
	private int seats;
	private double price;
	private String email;
	
	public RideDetailBean() {}
	
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	
	public String getDeparture() {
		return departure;
	}
	
	public void setDeparture(String departuer) {
		this.departure = departuer;
	}
	
	public String getDestination() {
		return destination;
	}
	
	public void setDestination(String destination) {
		this.destination = destination;
	}
	
	public String getDate() {
		return Date;
	}
	
	public void setDate(String Date) {
		this.Date = Date;
	}
	
	public String getTime() {
		return Time;
	}
	
	public void setTime(String Time) {
		this.Time = Time;
	}
	
	public int getSeats() {
		return seats;
	}
	
	public void setSeats(int seats) {
		this.seats = seats;
	}
	
	public double getPrice() {
		return price;
	}
	
	public void setPrice(double price) {
		this.price = price;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public static RideDetailBean getRideDetails(String rideID) {
	    RideDetailBean rideDetails = new RideDetailBean();
	    
	    try {
	    	
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
	        PreparedStatement psmt = con.prepareStatement("SELECT * FROM rides WHERE rideid = ?");
	        psmt.setString(1, rideID);
	        ResultSet rs = psmt.executeQuery();
	        if(rs.next()) {
	            rideDetails.setFname(rs.getString("fname"));
	            rideDetails.setLname(rs.getString("lname"));
	            rideDetails.setDeparture(rs.getString("departure"));
	            rideDetails.setDestination(rs.getString("destination"));
	            rideDetails.setDate(rs.getString("Ddate"));
	            rideDetails.setTime(rs.getString("Dtime"));
	            rideDetails.setSeats(rs.getInt("seats"));
	            rideDetails.setPrice(rs.getDouble("price"));
	            rideDetails.setEmail(rs.getString("email"));
	            
	        }
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return rideDetails;    
	}

}


package com.Rider;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDetails {
	private String Adminemail;
	private String Adminpassword;
	public AdminDetails() {}
	
	public String getAdminEmail() {
		return Adminemail;
	}
	
	public void setAdminEmail(String adminemail) {
		this.Adminemail = adminemail;
	}
	
	public String getAdminPassword() {
		return Adminpassword;
	}
	
	public void setAdminPassword(String adminpassword) {
		this.Adminpassword = adminpassword;
	}

	public static AdminDetails getAdminDetails(String email) {
		AdminDetails adminDetails = new AdminDetails();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
	        PreparedStatement psmt = con.prepareStatement("SELECT * FROM admin WHERE adminemail = ?");
	        psmt.setString(1, email);
	        ResultSet rs = psmt.executeQuery();
	        if(rs.next()) {
	        	adminDetails.setAdminEmail(rs.getString("adminemail"));
	        	adminDetails.setAdminPassword(rs.getString("adminpassword"));
	        }
	        con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return adminDetails;
	}
}

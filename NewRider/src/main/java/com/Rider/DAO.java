package com.Rider;

import java.io.InputStream;
import java.sql.*;
import java.util.HashMap;

public class DAO {
	private Connection c;

	public DAO() throws SQLException,ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
	}
	public void closeConnection() throws SQLException {
		c.close();
	}
	
	public boolean already_exist(String email) {
	    boolean flag = true;
	    try {
	        PreparedStatement p = c.prepareStatement("SELECT * FROM update_profile WHERE email = ?");
	        p.setString(1, email);
	        ResultSet rs = p.executeQuery();
	        if (rs.next()) {
	            flag = false;
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    }
	    return flag;
	}

	public int update_profile(InputStream profile_photo,String filename,String email) throws SQLException {
		PreparedStatement p = c.prepareStatement("insert into update_profile values (?,?,?)");
		p.setString(1, email);
		p.setString(2, filename);
		p.setBinaryStream(3, profile_photo);
		int r = p.executeUpdate();
		return r;
	}
	public int update_profile_update(InputStream profile_photo,String filename,String email) throws SQLException {
		PreparedStatement p = c.prepareStatement("UPDATE update_profile SET profile_name = ? , profile_photo = ? where email = ?");
		p.setString(1, filename);
		p.setBinaryStream(2, profile_photo);
		p.setString(3, email);
		int r = p.executeUpdate();
		return r;
	}
	public int update_signup(String email, String fname, String lname) throws SQLException {
	    PreparedStatement p = c.prepareStatement("UPDATE signup SET fname = ? , lname = ? where email = ?");
	    p.setString(1, fname);
	    p.setString(2, lname);
	    p.setString(3, email);
	    int r = p.executeUpdate();
	    return r;
	}
	public int update_password(String email,String update_password) throws SQLException{
		PreparedStatement p = c.prepareStatement("Update signup SET password = ? where email = ?");
		p.setString(1, update_password);
		p.setString(2, email);
		int r = p.executeUpdate();
		return r;
	}
	public HashMap<String,String> getAllFiles() throws SQLException {
	    PreparedStatement p=c.prepareStatement("select email, profile_name from update_profile");
	    ResultSet rs=p.executeQuery();
	    HashMap<String,String> files=new HashMap<>();
	    while(rs.next()) {
	        String email = rs.getString("email");
	        String filename=rs.getString("profile_name");
	        files.put(email, filename);
	    }
	    return files;
	}	
	public byte[] getFileById(String email) throws SQLException {
		PreparedStatement p=c.prepareStatement("select * from update_profile where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		if(rs.next()) 
			return rs.getBytes("profile_photo");
		else
			return null;
	}
	public HashMap<String,Object> getFileAndNameById(String email) throws SQLException {
		PreparedStatement p=c.prepareStatement("select * from update_profile where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			 byte file[]=rs.getBytes("profile_photo");
			 String filename=rs.getString("profile_name");
			 HashMap<String,Object> data=new HashMap<>();
			 data.put("filename", filename);
			 data.put("file", file);
			 return data;
		}
		else
			return null;
	}
}

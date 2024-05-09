package com.Rider;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SignupDetailBean {
    private String firstName;
    private String lastName;

    public SignupDetailBean() {}

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public static SignupDetailBean getSignupDetails(String email) {
        SignupDetailBean signupDetails = new SignupDetailBean();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
            PreparedStatement psmt = con.prepareStatement("SELECT * FROM signup WHERE email = ?");
            psmt.setString(1, email);
            ResultSet rs = psmt.executeQuery();
            if(rs.next()) {
                signupDetails.setFirstName(rs.getString("fname"));
                signupDetails.setLastName(rs.getString("lname"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return signupDetails;
    }
}

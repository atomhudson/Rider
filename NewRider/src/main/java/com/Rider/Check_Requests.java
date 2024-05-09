package com.Rider;

import java.io.IOException;
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

@WebServlet("/Check_Requests")
public class Check_Requests extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String ride_given_id = request.getParameter("ride_given_id");
            String status = "pending";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpooling", "root", "Warning@09@");
            PreparedStatement ps = c.prepareStatement("SELECT * FROM request WHERE rideid = ? AND status = ?");
            ps.setString(1, ride_given_id);
            ps.setString(2, status);

            ResultSet rs = ps.executeQuery();
            ArrayList<HashMap<String, Object>> emails = new ArrayList<>();
            while (rs.next()) {
                HashMap<String, Object> emailData = new HashMap<>();
                emailData.put("email", rs.getString("email"));
                emailData.put("rideid", rs.getString("rideid"));
                // Add more data if needed
                emails.add(emailData);
            }

            if (emails.isEmpty()) {
                response.sendRedirect("jsp/ride_request_unavailable.jsp");
            } else {
                request.setAttribute("email_request", emails);
                RequestDispatcher rd = request.getRequestDispatcher("jsp/ride_requests.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging purposes
            // Handle the exception properly
            response.sendRedirect("jsp/error.jsp");
        }
    }
}

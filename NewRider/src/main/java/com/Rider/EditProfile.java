package com.Rider;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.http.Part;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/EditProfile")
@MultipartConfig
public class EditProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
        try {
            String email = request.getParameter("email");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");

            Part p = request.getPart("ufile");

            InputStream profile_photo = p.getInputStream();
            String filename = p.getSubmittedFileName();

            DAO db = new DAO();
            boolean flag = db.already_exist(email);
            int r = 0;
            if (flag == true) {
                r = db.update_profile(profile_photo, filename, email);
                r = db.update_signup(email, fname, lname); // Corrected method name
            } else {
                r = db.update_profile_update(profile_photo, filename, email);
                r = db.update_signup(email, fname, lname); // Corrected method name
            }
            if (r != 0) {
            	request.getSession().setAttribute("fname", fname);
                request.getSession().setAttribute("lname", lname);
                request.getSession().setAttribute("email", email);
                RequestDispatcher rd = request.getRequestDispatcher("jsp/update_profile_success.jsp");
                rd.forward(request, response);
            } else {
            	request.getSession().setAttribute("fname", fname);
                request.getSession().setAttribute("lname", lname);
                request.getSession().setAttribute("email", email);
                RequestDispatcher rd = request.getRequestDispatcher("jsp.update_profile_error.jsp");
                rd.forward(request, response);
            }

            db.closeConnection();

        } catch (Exception e) {
            out.print(e);
        }
    }
}

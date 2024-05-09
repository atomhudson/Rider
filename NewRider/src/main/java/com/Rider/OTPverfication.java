package com.Rider;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class OTPverfication
 */
@WebServlet("/OTPverfication")
public class OTPverfication extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession otpverify = request.getSession(false);
        int OTP = (int) otpverify.getAttribute("OTP");

        String num1 = request.getParameter("num1");
        String num2 = request.getParameter("num2");
        String num3 = request.getParameter("num3");
        String num4 = request.getParameter("num4");

        String numOTP = num1 + num2 + num3 + num4;
        int enteredOTP = Integer.parseInt(numOTP);

        if (OTP == enteredOTP) {
            RequestDispatcher rd = request.getRequestDispatcher("jsp/changepassword.jsp");
            rd.forward(request, response);
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("html/incorrectOTP.html");
            rd.forward(request, response);
        }
    }

}

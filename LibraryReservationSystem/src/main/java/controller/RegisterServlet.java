package controller;

import dao.UserDAO;
import model.User;
import util.PasswordUtil; // 🔹 Make sure this import is added

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String rawPassword = request.getParameter("password");

        // 🔐 Hash the password
        String hashedPassword = PasswordUtil.hashPassword(rawPassword);

        UserDAO userDAO = new UserDAO();

        if (userDAO.isUserExists(email)) {
            response.sendRedirect("jsp/register.jsp?msg=exists");
        } else {
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(hashedPassword); // 🔐 Store hashed password
            user.setRole("user"); // default role

            boolean registered = userDAO.registerUser(user);

            if (registered) {
                response.sendRedirect("jsp/register.jsp?msg=success");
            } else {
                response.sendRedirect("jsp/register.jsp?msg=error");
            }
        }
    }
}

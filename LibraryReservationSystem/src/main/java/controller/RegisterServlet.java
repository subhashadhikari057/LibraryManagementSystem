package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        if (userDAO.isUserExists(email)) {
            response.sendRedirect("jsp/register.jsp?msg=exists");
        } else {
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(password);
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

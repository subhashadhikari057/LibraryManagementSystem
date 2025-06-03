package controller;

import dao.UserDAO;
import model.User;
import util.PasswordUtil; // 🔹 Make sure to import this

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String rawPassword = request.getParameter("password");

        // 🔐 Hash the password entered by the user
        String hashedPassword = PasswordUtil.hashPassword(rawPassword);

        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticateUser(email, hashedPassword); // 🔐 compare hashed password

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("jsp/admin.jsp");
            } else {
                response.sendRedirect("jsp/user.jsp");
            }
        } else {
            response.sendRedirect("jsp/login.jsp?error=1");
        }
    }
}

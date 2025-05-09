package controller;

import dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class UpdateUserRoleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String role = request.getParameter("role");

        UserDAO userDAO = new UserDAO();
        boolean updated = userDAO.updateUserRole(id, role);

        if (updated) {
            response.sendRedirect("jsp/view-users.jsp");
        } else {
            response.sendRedirect("jsp/view-users.jsp?msg=error");
        }
    }
}

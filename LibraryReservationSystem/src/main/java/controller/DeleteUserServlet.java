package controller;

import dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        UserDAO userDAO = new UserDAO();
        boolean deleted = userDAO.deleteUserById(id);

        if (deleted) {
            response.sendRedirect("jsp/view-users.jsp");
        } else {
            response.sendRedirect("jsp/view-users.jsp?msg=error");
        }
    }
}

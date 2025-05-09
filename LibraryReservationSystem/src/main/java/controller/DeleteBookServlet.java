package controller;

import dao.BookDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteBookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        BookDAO bookDAO = new BookDAO();
        boolean deleted = bookDAO.deleteBook(id);

        if (deleted) {
            response.sendRedirect("jsp/view-books.jsp");
        } else {
            response.sendRedirect("jsp/view-books.jsp?msg=error");
        }
    }
}

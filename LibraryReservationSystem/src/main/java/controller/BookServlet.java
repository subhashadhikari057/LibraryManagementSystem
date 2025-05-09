package controller;

import dao.BookDAO;
import model.Book;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class BookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        String status = request.getParameter("status");

        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        book.setCategory(category);
        book.setStatus(status);

        BookDAO bookDAO = new BookDAO();
        boolean success = bookDAO.addBook(book);

        if (success) {
            response.sendRedirect("jsp/add-book.jsp?msg=success");
        } else {
            response.sendRedirect("jsp/add-book.jsp?msg=error");
        }
    }
}

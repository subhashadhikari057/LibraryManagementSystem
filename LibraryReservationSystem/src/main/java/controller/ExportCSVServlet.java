package controller;

import util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ExportCSVServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"reservations_report.csv\"");

        try (Connection conn = DBConnection.getConnection();
             PrintWriter writer = response.getWriter()) {

            String sql = "SELECT u.full_name, u.email, b.title, b.author, r.reserved_on, r.return_due " +
                         "FROM reservations r " +
                         "JOIN users u ON r.user_id = u.id " +
                         "JOIN books b ON r.book_id = b.id " +
                         "ORDER BY r.reserved_on DESC";

            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                writer.println("User,Email,Book Title,Author,Reserved On,Return Due");

                while (rs.next()) {
                    writer.printf("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"%n",
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getTimestamp("reserved_on"),
                        rs.getTimestamp("return_due"));
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/report.jsp?msg=error");
        }
    }
}

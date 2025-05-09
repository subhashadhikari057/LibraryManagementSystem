package controller;

import util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class UnreserveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try (Connection conn = DBConnection.getConnection()) {

            // Step 1: Delete the reservation by ID
            String deleteSQL = "DELETE FROM reservations WHERE id = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSQL);
            deleteStmt.setInt(1, reservationId);
            int affectedRows = deleteStmt.executeUpdate();

            // Step 2: If deleted, increase stock
            if (affectedRows > 0) {
                String updateStockSQL = "UPDATE books SET stock = stock + 1 WHERE id = ?";
                PreparedStatement stockStmt = conn.prepareStatement(updateStockSQL);
                stockStmt.setInt(1, bookId);
                stockStmt.executeUpdate();

                // Step 3: Set book available if it was previously unavailable
                String checkStockSQL = "SELECT stock FROM books WHERE id = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkStockSQL);
                checkStmt.setInt(1, bookId);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next() && rs.getInt("stock") > 0) {
                    String updateStatusSQL = "UPDATE books SET status = 'available' WHERE id = ?";
                    PreparedStatement statusStmt = conn.prepareStatement(updateStatusSQL);
                    statusStmt.setInt(1, bookId);
                    statusStmt.executeUpdate();
                }
            }

            response.sendRedirect("jsp/my-reservations.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/my-reservations.jsp?msg=error");
        }
    }
}

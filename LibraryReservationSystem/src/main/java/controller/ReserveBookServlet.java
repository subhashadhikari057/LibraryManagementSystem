package controller;

import util.DBConnection;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ReserveBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"user".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try (Connection conn = DBConnection.getConnection()) {

            // Step 1: Check stock
            String getStockSQL = "SELECT stock FROM books WHERE id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(getStockSQL);
            checkStmt.setInt(1, bookId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int stock = rs.getInt("stock");

                // ✅ Step 1.5: Prevent duplicate reservations by the same user
                String checkExistingSQL = "SELECT COUNT(*) FROM reservations WHERE user_id = ? AND book_id = ?";
                PreparedStatement checkExistingStmt = conn.prepareStatement(checkExistingSQL);
                checkExistingStmt.setInt(1, userId);
                checkExistingStmt.setInt(2, bookId);
                ResultSet existingRS = checkExistingStmt.executeQuery();

                if (existingRS.next() && existingRS.getInt(1) > 0) {
                    session.setAttribute("reserve_msg", "You've already reserved this book.");
                    response.sendRedirect("jsp/view-available-books.jsp");
                    return;
                }

                if (stock > 0) {
                    // Step 2: Insert reservation with reserved_on and return_due
                    Timestamp now = new Timestamp(System.currentTimeMillis());
                    Timestamp due = new Timestamp(now.getTime() + 7L * 24 * 60 * 60 * 1000);

                    String insertSQL = "INSERT INTO reservations (user_id, book_id, reserved_on, return_due) VALUES (?, ?, ?, ?)";
                    PreparedStatement insertStmt = conn.prepareStatement(insertSQL);
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, bookId);
                    insertStmt.setTimestamp(3, now);
                    insertStmt.setTimestamp(4, due);
                    insertStmt.executeUpdate();

                    // Step 3: Decrease stock
                    String updateStockSQL = "UPDATE books SET stock = stock - 1 WHERE id = ?";
                    PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSQL);
                    updateStockStmt.setInt(1, bookId);
                    updateStockStmt.executeUpdate();

                    // Step 4: If stock hits 0, mark unavailable
                    if (stock == 1) {
                        String markUnavailableSQL = "UPDATE books SET status = 'unavailable' WHERE id = ?";
                        PreparedStatement markStmt = conn.prepareStatement(markUnavailableSQL);
                        markStmt.setInt(1, bookId);
                        markStmt.executeUpdate();
                    }

                    // ✅ Success
                    session.setAttribute("reserve_msg", "Book reserved successfully!");
                } else {
                    // ❌ Out of stock
                    session.setAttribute("reserve_msg", "Sorry, this book is currently out of stock.");
                }

                response.sendRedirect("jsp/view-available-books.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("reserve_msg", "An error occurred while reserving the book.");
            response.sendRedirect("jsp/view-available-books.jsp");
        }
    }
}

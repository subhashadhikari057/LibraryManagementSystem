<%@ page import="model.User" %>
<%@ page import="model.Book" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    int bookId = Integer.parseInt(request.getParameter("id"));
    BookDAO bookDAO = new BookDAO();
    Book book = bookDAO.getBookById(bookId);
    if (book == null) {
        response.sendRedirect("view-books.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green background */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px;
            max-width: 500px;
            width: 100%;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
            animation: fadeIn 0.6s ease-in-out;
            color: #ffffff;
        }

        h2 {
            text-align: center;
            font-size: 26px;
            margin-bottom: 25px;
            color: #e8f5e9;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
            color: #c8e6c9;
        }

        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            background: rgba(255, 255, 255, 0.95);
            color: #000;
        }

        button {
            margin-top: 25px;
            width: 100%;
            background: #1b5e20;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background: #2e7d32;
            transform: scale(1.03);
        }

        .back-link {
            text-align: center;
            margin-top: 25px;
        }

        .back-link a {
            display: inline-block;
            padding: 10px 20px;
            background-color: rgba(255, 255, 255, 0.9);
            color: #1b5e20;
            font-weight: bold;
            border-radius: 8px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .back-link a:hover {
            background-color: #c8e6c9;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Edit Book</h2>
    <form action="../EditBookServlet" method="post">
        <input type="hidden" name="id" value="<%= book.getId() %>">

        <label>Title:</label>
        <input type="text" name="title" value="<%= book.getTitle() %>" required>

        <label>Author:</label>
        <input type="text" name="author" value="<%= book.getAuthor() %>" required>

        <label>Category:</label>
        <input type="text" name="category" value="<%= book.getCategory() %>" required>

        <label>Status:</label>
        <select name="status" required>
            <option value="available" <%= book.getStatus().equals("available") ? "selected" : "" %>>Available</option>
            <option value="unavailable" <%= book.getStatus().equals("unavailable") ? "selected" : "" %>>Unavailable</option>
        </select>

        <label>Stock:</label>
        <input type="number" name="stock" value="<%= book.getStock() %>" min="0" required>

        <button type="submit">Update Book</button>
    </form>

    <div class="back-link">
        <a href="admin.jsp">Back to Dashboard</a>
    </div>
</div>
</body>
</html>

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

    BookDAO bookDAO = new BookDAO();
    List<Book> books = bookDAO.getAllBooks();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0b3d0b, #1b5e20); /* dark green gradient */
            padding: 40px;
            min-height: 100vh;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.6s ease-in-out;
            color: #fff;
        }

        h2 {
            text-align: center;
            font-size: 26px;
            margin-bottom: 30px;
            color: #c8e6c9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: rgba(255, 255, 255, 0.96);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            text-align: left;
            font-size: 15px;
            color: #000;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #388e3c;
            color: #fff;
        }

        .actions a {
            margin-right: 8px;
            padding: 8px 14px;
            background: #2e7d32;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            font-size: 14px;
            transition: background 0.3s ease;
        }

        .actions a:hover {
            background-color: #1b5e20;
        }

        .actions a.delete {
            background-color: #c62828;
        }

        .actions a.delete:hover {
            background-color: #b71c1c;
        }

        .back-link {
            text-align: center;
            margin-top: 30px;
        }

        .back-link a {
            display: inline-block;
            padding: 10px 20px;
            background-color: rgba(255, 255, 255, 0.9);
            color: #1b5e20;
            font-weight: bold;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .back-link a:hover {
            background-color: #c8e6c9;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>All Books</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Status</th>
            <th>Stock</th>
            <th>Actions</th>
        </tr>
        <%
            for (Book b : books) {
        %>
        <tr>
            <td><%= b.getId() %></td>
            <td><%= b.getTitle() %></td>
            <td><%= b.getAuthor() %></td>
            <td><%= b.getCategory() %></td>
            <td><%= b.getStatus() %></td>
            <td><%= b.getStock() %></td>
            <td class="actions">
                <a href="edit-book.jsp?id=<%= b.getId() %>">Edit</a>
                <a class="delete" href="../DeleteBookServlet?id=<%= b.getId() %>"
                   onclick="return confirm('Are you sure you want to delete this book?');">
                    Delete
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <div class="back-link">
        <a href="admin.jsp">Back to Dashboard</a>
    </div>
</div>
</body>
</html>

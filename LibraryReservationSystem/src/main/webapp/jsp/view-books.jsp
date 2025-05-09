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
<html>
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f7fa;
            padding: 40px;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        h2 {
            color: #004aac;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #e6f0ff;
        }
        .actions a {
            margin-right: 10px;
            padding: 6px 12px;
            background: #004aac;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .actions a.delete {
            background: #d11a2a;
        }
        .actions a:hover {
            opacity: 0.9;
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

        <div style="text-align:center; margin-top: 30px;">
            <a href="admin.jsp" style="
                background-color: #ccc;
                padding: 10px 20px;
                text-decoration: none;
                font-weight: bold;
                color: #000;
                border-radius: 5px;
            ">
                Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>

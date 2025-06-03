<%@ page import="model.User" %>
<%@ page import="model.Book" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    String query = request.getParameter("q");
    BookDAO bookDAO = new BookDAO();
    List<Book> books;

    if (query != null && !query.trim().isEmpty()) {
        books = bookDAO.searchBooks(query);
    } else {
        books = bookDAO.getAvailableBooks();
    }

    String reserveMsg = (String) session.getAttribute("reserve_msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Books</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green theme */
            min-height: 100vh;
            padding: 40px;
            color: #fff;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 28px;
            color: #e8f5e9;
        }

        .alert {
            width: 90%;
            margin: 0 auto 20px auto;
            padding: 15px;
            border-radius: 10px;
            font-size: 15px;
            box-shadow: 0 5px 12px rgba(0, 0, 0, 0.1);
        }

        .alert-info {
            background: rgba(56, 142, 60, 0.15); /* greenish info */
            color: #c8e6c9;
            border-left: 5px solid #66bb6a;
        }

        .alert-warning {
            background-color: rgba(255, 241, 118, 0.15);
            color: #fff9c4;
            border-left: 5px solid #fbc02d;
        }

        form {
            text-align: center;
            margin: 30px auto;
        }

        input[type="text"] {
            padding: 10px;
            width: 300px;
            border-radius: 8px;
            border: none;
            font-size: 15px;
        }

        button[type="submit"] {
            padding: 10px 18px;
            background: #1b5e20;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            margin-left: 10px;
            transition: background 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #2e7d32;
        }

        table {
            width: 95%;
            margin: auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.97);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            overflow: hidden;
            color: #000;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #2e7d32;
            color: white;
        }

        tr:hover {
            background-color: #f1f8f5;
        }

        .btn {
            background: #388e3c;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #2e7d32;
        }

        .back {
            text-align: center;
            margin-top: 30px;
        }

        .back a {
            display: inline-block;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.9);
            color: #1b5e20;
            text-decoration: none;
            font-weight: bold;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .back a:hover {
            background-color: #c8e6c9;
        }

        @media (max-width: 768px) {
            input[type="text"] {
                width: 90%;
                margin-bottom: 10px;
            }

            button[type="submit"] {
                width: 90%;
            }

            table {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<h2>Available Books</h2>

<% if (reserveMsg != null) { %>
<div class="alert alert-info">
    <%= reserveMsg %>
</div>
<% session.removeAttribute("reserve_msg"); } %>

<div class="alert alert-warning">
    <strong>Note:</strong> All reserved books must be returned within <strong>7 days</strong>.
    Late returns may result in fines or suspension.
</div>

<!-- Search Form -->
<form method="get" action="view-available-books.jsp">
    <input type="text" name="q" placeholder="Search by title, author, category"
           value="<%= query != null ? query : "" %>" />
    <button type="submit">Search</button>
</form>

<!-- Books Table -->
<table>
    <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Category</th>
        <th>Stock</th>
        <th>Action</th>
    </tr>
    <% if (books.isEmpty()) { %>
    <tr>
        <td colspan="5">No books found.</td>
    </tr>
    <% } else {
        for (Book b : books) { %>
    <tr>
        <td><%= b.getTitle() %></td>
        <td><%= b.getAuthor() %></td>
        <td><%= b.getCategory() %></td>
        <td><%= b.getStock() %></td>
        <td>
            <form action="../ReserveBookServlet" method="post">
                <input type="hidden" name="bookId" value="<%= b.getId() %>">
                <button type="submit" class="btn">Reserve</button>
            </form>
        </td>
    </tr>
    <% }} %>
</table>

<div class="back">
    <a href="user.jsp">Back to Dashboard</a>
</div>
</body>
</html>

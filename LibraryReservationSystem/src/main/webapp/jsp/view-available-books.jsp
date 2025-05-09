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
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Books</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f7fa;
            padding: 40px;
        }
        h2 {
            text-align: center;
            color: #004aac;
        }
        form {
            text-align: center;
            margin-bottom: 25px;
        }
        input[type="text"] {
            padding: 8px;
            width: 250px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button[type="submit"] {
            padding: 8px 14px;
            background-color: #004aac;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #003377;
        }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ccc;
        }
        th {
            background: #004aac;
            color: white;
        }
        .btn {
            background: #28a745;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background: #218838;
        }
        .back {
            text-align: center;
            margin-top: 20px;
        }
        .back a {
            background: #ccc;
            padding: 10px 20px;
            text-decoration: none;
            color: black;
            border-radius: 5px;
            font-weight: bold;
        }
        .alert {
            width: 90%;
            margin: 0 auto 20px auto;
            padding: 15px;
            border-radius: 5px;
            font-size: 15px;
            box-shadow: 0 0 6px rgba(0, 0, 0, 0.05);
        }
        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border-left: 5px solid #bee5eb;
        }
        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border-left: 5px solid #ffeeba;
        }
    </style>
</head>
<body>
    <h2>Available Books</h2>

    <!-- Reservation Message -->
    <%
        if (reserveMsg != null) {
    %>
    <div class="alert alert-info">
        <%= reserveMsg %>
    </div>
    <%
        session.removeAttribute("reserve_msg");
        }
    %>

    <!-- Important Notice -->
    <div class="alert alert-warning">
        <strong>Note:</strong> All reserved books must be returned within <strong>7 days</strong>.
        Failure to return on time may result in fines or temporary suspension of your account.
    </div>

    <!-- Search Bar -->
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
        <%
            if (books.isEmpty()) {
        %>
        <tr>
            <td colspan="5">No books found.</td>
        </tr>
        <%
            } else {
                for (Book b : books) {
        %>
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
        <%
                }
            }
        %>
    </table>

    <div class="back">
        <a href="user.jsp">Back to Dashboard</a>
    </div>
</body>
</html>

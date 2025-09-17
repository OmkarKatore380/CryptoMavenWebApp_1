<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg p-4 col-md-6 mx-auto">
        <h3 class="text-center text-primary">Login</h3>
        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="text" name="phoneNo" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <p class="text-center mt-3">
            New user? <a href="register.jsp">Register here</a>
        </p>
    </div>
</div>

</body>
</html>

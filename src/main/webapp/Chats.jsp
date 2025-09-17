<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Secure Chat</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #ece5dd;
            font-family: Arial, sans-serif;
        }
        .chat-container {
            width: 70%;
            margin: 20px auto;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }
        .chat-header {
            background: #075e54;
            color: white;
            padding: 15px;
            font-size: 18px;
            font-weight: bold;
        }
        .chat-messages {
            height: 400px;
            overflow-y: scroll;
            padding: 15px;
            background: #f0f0f0;
        }
        .message {
            margin-bottom: 12px;
            padding: 10px 15px;
            border-radius: 18px;
            display: inline-block;
            max-width: 70%;
        }
        .sent {
            background: #dcf8c6;
            text-align: right;
            float: right;
            clear: both;
        }
        .received {
            background: #fff;
            text-align: left;
            float: left;
            clear: both;
        }
        .chat-input {
            padding: 10px;
            background: #eee;
        }
    </style>
</head>
<body>

<div class="chat-container">
    <!-- Header -->
    <div class="chat-header">
        Secure Chat - Welcome, <%= session.getAttribute("username") %>
    </div>

    <!-- Messages -->
    <div class="chat-messages">
        <%-- Example messages (replace with DB messages using Hibernate) --%>
        <div class="message sent">Hello, how are you?</div>
        <div class="message received">I’m fine, thanks! What about you?</div>
        <div class="message sent">All good, working on project.</div>
    </div>

    <!-- Input -->
    <div class="chat-input">
        <form action="SendMessageServlet" method="post" class="d-flex">
            <input type="text" name="message" class="form-control me-2" placeholder="Type a message" required>
            <button type="submit" class="btn btn-success">Send</button>
        </form>
    </div>
</div>

</body>
</html>

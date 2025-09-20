<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.hibernate.*" %>
<%@ page import="org.hibernate.cfg.*" %>
<%@ page import="com.org.main.Entities" %>

<%
    String loggedUser = (String) session.getAttribute("loggedUser");
    if(loggedUser == null){
        response.sendRedirect("Login.jsp");
        return;
    }

    // Fetch all users via Hibernate
    List<Entities> users = new ArrayList<>();
 // Fetch all users via Hibernate except the logged-in one
    try {
        Configuration cfg = new Configuration();
        cfg.configure("com/org/config/hibernate.cfg.xml");
        SessionFactory sf = cfg.buildSessionFactory();

        Session hibSession = sf.openSession();
        users = hibSession.createQuery("FROM Entities e WHERE e.name <> :loggedUser", Entities.class)
                          .setParameter("loggedUser", loggedUser)
                          .list();
        hibSession.close();
    } catch(Exception e){
        e.printStackTrace();
    }

%>


<!DOCTYPE html>
<html>
<head>
    <title>Secure Chats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #1e1e1e; color: white; font-family: Arial, sans-serif; }
        .screen { display: none; height: 100vh; }
        .active { display: block; }
        .users-list { background-color: #2c2c2c; padding: 20px; }
        .user-item { background: #3c3c3c; padding: 15px; margin: 8px 0; border-radius: 8px; cursor: pointer; }
        .user-item:hover { background: #4a4a4a; }
        .chat-header { background: #2c2c2c; padding: 15px; font-weight: bold; }
        .messages { height: calc(100vh - 120px); padding: 20px; overflow-y: auto; background: #1e1e1e; }
        .msg { background: #3a3f44; display: inline-block; padding: 10px 15px; border-radius: 10px; margin: 5px 0; }
        .msg.you { background: #4a7856; float: right; clear: both; }
        .chat-input { display: flex; border-top: 1px solid #444; }
        .chat-input input { flex: 1; padding: 12px; border: none; background: #2c2c2c; color: white; }
        .chat-input button { padding: 12px 20px; background: #4a7856; border: none; color: white; }
        .back-btn { background: none; border: none; color: white; margin-right: 10px; }
    </style>
    <script>
        function openChat(name) {
            document.getElementById("usersScreen").classList.remove("active");
            document.getElementById("chatScreen").classList.add("active");
            document.getElementById("chatWith").innerText = "Chat with " + name;
        }
        function goBack() {
            document.getElementById("chatScreen").classList.remove("active");
            document.getElementById("usersScreen").classList.add("active");
        }
    </script>
</head>
<body>

    <div id="usersScreen" class="screen active users-list">
        <h3>Tasks for <%= loggedUser %></h3>
        <hr>
        <% if(users.isEmpty()) { %>
            <p>No users registered yet.</p>
        <% } else { %>
            <% for(Entities u : users){ %>
                <div class="user-item" onclick="openChat('<%= u.getName() %>')"><%= u.getName() %></div>
            <% } %>
        <% } %>
    </div>

    <div id="chatScreen" class="screen">
        <div class="chat-header">
            <button class="back-btn" onclick="goBack()">⬅ Back</button>
            <span id="chatWith">Chat</span>
        </div>
        <div class="messages">
            <div class="msg">Hello! This is demo chat.</div>
        </div>
        <div class="chat-input">
            <input type="text" placeholder="Type a message...">
            <button>Send</button>
        </div>
    </div>

</body>
</html>

package com.org.Reg;

import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import javax.servlet.annotation.*;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.org.main.Entities;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        String name = req.getParameter("name");
        long phoneNo = Long.parseLong(req.getParameter("phoneNo"));
        String password = req.getParameter("password");

        try {
            // Hibernate config
            Configuration cfg = new Configuration();
            cfg.configure("com/org/config/hibernate.cfg.xml"); // keep file in resources
            SessionFactory sessionFactory = cfg.buildSessionFactory();
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();

            // Create entity
            Entities user = new Entities();
            user.setName(name);
            user.setPhoneNo(phoneNo);
            user.setPassword(password);

            // Save in DB
            session.save(user);
            transaction.commit();
            session.close();

            // Success
            req.setAttribute("message", "User registered successfully!");
            RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("Register.jsp");
            rd.forward(req, resp);
        }
    }
}

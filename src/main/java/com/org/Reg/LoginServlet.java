package com.org.Reg;

import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import javax.servlet.annotation.*;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import com.org.main.Entities;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        long phoneNo = Long.parseLong(req.getParameter("phoneNo"));
        String password = req.getParameter("password");

        try {
            // Hash input password
            String hashedPassword = HashUtil.hashPassword(password);

            Configuration cfg = new Configuration();
            cfg.configure("com/org/config/hibernate.cfg.xml");
            SessionFactory sessionFactory = cfg.buildSessionFactory();
            Session session = sessionFactory.openSession();

            String hql = "FROM Entities E WHERE E.phoneNo = :phone AND E.password = :pass";
            org.hibernate.query.Query<Entities> query = session.createQuery(hql, Entities.class);
            query.setParameter("phone", phoneNo);
            query.setParameter("pass", hashedPassword);

            Entities user = query.uniqueResult();
            session.close();

            if (user != null) {
                HttpSession hs = req.getSession();
                hs.setAttribute("loggedUser", user.getName());

                resp.sendRedirect("home.jsp");
            } else {
                req.setAttribute("error", "Invalid phone number or password!");
                RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
                rd.forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Something went wrong: " + e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
            rd.forward(req, resp);
        }
    }
}

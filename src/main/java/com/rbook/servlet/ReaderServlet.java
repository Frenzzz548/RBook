package com.rbook.servlet;

import com.rbook.dao.ComicDAO;
import com.rbook.model.Comic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ReaderServlet", urlPatterns = {"/comic/view"})
public class ReaderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null) {
            resp.sendRedirect(req.getContextPath() + "/comics");
            return;
        }
        try {
            Comic c = ComicDAO.find(Integer.parseInt(id));
            req.setAttribute("comic", c);
            req.getRequestDispatcher("/comic_view.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

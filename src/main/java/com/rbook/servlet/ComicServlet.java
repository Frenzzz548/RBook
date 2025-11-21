package com.rbook.servlet;

import com.rbook.dao.ComicDAO;
import com.rbook.model.Comic;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "ComicServlet", urlPatterns = {"/comics", "/comic"})
@MultipartConfig
public class ComicServlet extends HttpServlet {
    private File uploadDir;

    @Override
    public void init() throws ServletException {
        String up = System.getenv("UPLOAD_DIR");
        if (up == null || up.isBlank()) {
            String base = getServletContext().getRealPath("/");
            up = base + File.separator + "uploads";
        }
        uploadDir = new File(up);
        if (!uploadDir.exists()) uploadDir.mkdirs();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String action = req.getParameter("action");
        try {
            if (id != null && "edit".equals(action)) {
                Comic c = ComicDAO.find(Integer.parseInt(id));
                req.setAttribute("comic", c);
                req.getRequestDispatcher("/comic_edit.jsp").forward(req, resp);
                return;
            }
            List<Comic> list = ComicDAO.listAll();
            req.setAttribute("comics", list);
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("create".equals(action) || "update".equals(action)) {
                String title = req.getParameter("title");
                String author = req.getParameter("author");
                String description = req.getParameter("description");
                Part coverPart = req.getPart("cover");
                String coverFilename = null;
                if (coverPart != null && coverPart.getSize() > 0) {
                    String ext = ".jpg";
                    String submitted = coverPart.getSubmittedFileName();
                    if (submitted != null && submitted.contains(".")) ext = submitted.substring(submitted.lastIndexOf('.'));
                    coverFilename = UUID.randomUUID().toString() + ext;
                    File f = new File(uploadDir, coverFilename);
                    coverPart.write(f.getAbsolutePath());
                }

                Comic c = new Comic();
                c.setTitle(title);
                c.setAuthor(author);
                c.setDescription(description);
                if (coverFilename != null) c.setCover("/uploads/" + coverFilename);

                if ("create".equals(action)) {
                    ComicDAO.create(c);
                } else {
                    String id = req.getParameter("id");
                    c.setId(Integer.parseInt(id));
                    // if cover not uploaded, keep existing
                    if (c.getCover() == null) {
                        Comic existing = ComicDAO.find(c.getId());
                        if (existing != null) c.setCover(existing.getCover());
                    }
                    ComicDAO.update(c);
                }
                resp.sendRedirect(req.getContextPath() + "/comics");
                return;
            }

            if ("delete".equals(action)) {
                String id = req.getParameter("id");
                if (id != null) ComicDAO.delete(Integer.parseInt(id));
                resp.sendRedirect(req.getContextPath() + "/comics");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/comics");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

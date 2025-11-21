<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.rbook.model.Comic" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Edit Komik</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
  <h2>Tambah / Edit Komik</h2>
  <%
    Comic c = (Comic) request.getAttribute("comic");
  %>
  <form method="post" action="<%=request.getContextPath()%>/comics" enctype="multipart/form-data">
    <input type="hidden" name="action" value="<%= c==null?"create":"update"%>">
    <% if (c!=null) { %>
      <input type="hidden" name="id" value="<%=c.getId()%>">
    <% } %>
    <div class="mb-3">
      <label class="form-label">Judul</label>
      <input class="form-control" name="title" value="<%= c==null?"":c.getTitle()%>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Penulis</label>
      <input class="form-control" name="author" value="<%= c==null?"":c.getAuthor()%>">
    </div>
    <div class="mb-3">
      <label class="form-label">Deskripsi</label>
      <textarea class="form-control" name="description"><%= c==null?"":c.getDescription()%></textarea>
    </div>
    <div class="mb-3">
      <label class="form-label">Cover (opsional)</label>
      <input type="file" name="cover" class="form-control">
    </div>
    <button class="btn btn-primary">Simpan</button>
    <a class="btn btn-secondary" href="<%=request.getContextPath()%>/comics">Batal</a>
  </form>
</div>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rbook.model.Comic" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>RBook - Baca Komik</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <div class="container">
    <a class="navbar-brand" href="<%=request.getContextPath()%>/">RBook</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/login">Login</a></li>
        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/register">Daftar</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1>Daftar Komik</h1>
    <a class="btn btn-primary" href="<%=request.getContextPath()%>/comic?action=edit">Tambah Komik</a>
  </div>
  <div class="row">
    <% List<Comic> list = (List<Comic>) request.getAttribute("comics");
       if (list != null) {
         for (Comic c : list) {
    %>
    <div class="col-md-4 mb-4">
      <div class="card h-100">
        <img src="<%=c.getCover() == null ? request.getContextPath() + "/css/placeholder.png" : c.getCover()%>" class="card-img-top card-cover" alt="cover">
        <div class="card-body d-flex flex-column">
          <h5 class="card-title"><%=c.getTitle()%></h5>
          <p class="card-text text-muted">oleh <%=c.getAuthor()%></p>
          <p class="card-text"><%=c.getDescription() == null ? "" : (c.getDescription().length()>120? c.getDescription().substring(0,120)+"...":c.getDescription())%></p>
          <div class="mt-auto d-flex gap-2">
            <a class="btn btn-sm btn-outline-primary" href="<%=request.getContextPath()%>/comic/view?id=" + c.getId()>Baca</a>
            <a class="btn btn-sm btn-secondary" href="<%=request.getContextPath()%>/comic?action=edit&id=" + c.getId()>Edit</a>
            <form method="post" action="<%=request.getContextPath()%>/comics" onsubmit="return confirm('Hapus komik?');">
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="id" value="<%=c.getId()%>">
              <button class="btn btn-sm btn-danger">Hapus</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%   }
       }
    %>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

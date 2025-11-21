<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.rbook.model.Comic" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>View Komik</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
<div class="container mt-4">
  <a href="<%=request.getContextPath()%>/comics" class="btn btn-light mb-3">← Kembali</a>
  <%
    Comic c = (Comic) request.getAttribute("comic");
    if (c!=null) {
  %>
  <div class="row">
    <div class="col-md-4">
      <img src="<%= c.getCover()==null?request.getContextPath()+"/css/placeholder.png":c.getCover() %>" class="img-fluid comic-cover" alt="cover">
    </div>
    <div class="col-md-8">
      <h2><%=c.getTitle()%></h2>
      <p class="text-muted">oleh <%=c.getAuthor()%></p>
      <p><%=c.getDescription()%></p>
      <a class="btn btn-primary" href="<%=request.getContextPath()%>/comic/view?id=<%=c.getId()%>">Buka Reader</a>
    </div>
  </div>
  <% } else { %>
    <p>Komik tidak ditemukan.</p>
  <% } %>
</div>
</body>
</html>

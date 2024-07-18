<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDao" %>
<%@ page import="bean.Product" %>
<%@ page import="java.io.*, java.sql.*" %>

<%
    // Check if user is logged in
    HttpSession httpSession = request.getSession();
    if (httpSession == null || httpSession.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve form parameters
    int productId = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    int brandId = Integer.parseInt(request.getParameter("brand"));
    int price = Integer.parseInt(request.getParameter("price"));
    String color = request.getParameter("color");
    String specification = request.getParameter("specification");
    String imageUrl = request.getParameter("image_url");

    // Create Product object
    Product product = new Product();
    product.setProduct_id(productId);
    product.setName(name);
    product.setBrand_id(brandId);
    product.setPrice(price);
    product.setColor(color);
    product.setSpecification(specification);
    product.setImage_url(imageUrl);

    // Update product using ProductDao
    ProductDao productDao = new ProductDao();
    boolean isUpdated = productDao.updateProduct(product);

    // Redirect based on update result
    if (isUpdated) {
%>
        <script type="text/javascript">
            alert("Product updated successfully!");
            window.location.href = "viewproduct.jsp";
        </script>
<%
    } else {
%>
        <script type="text/javascript">
            alert("Error updating product. Please try again.");
            window.location.href = "editProduct.jsp?id=<%= productId %>&error=1";
        </script>
<%
    }
%>

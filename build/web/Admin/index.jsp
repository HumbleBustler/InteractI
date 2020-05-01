
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../Bootstrap/bootstrap.min.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
             <div class="row">
            <div class="col-md-12">
           <h1 style="text-align: center">Welcome to Admin Panel</h1><br>
         <%@include file="navigation_bar.jsp" %> 
         
            </div>
             </div><br><br>
        <div class="row">
            <div  class="col-md-4"></div>
            <div class="col-md-4">
                <img src="../Resources/logo.jpg" class="img img-responsive img-thumbnail" width="500">
            </div>
        </div>
        </div>
    </body>
</html>
<%
    
 String logout = request.getParameter("logout");
    if(logout != null){
        session.invalidate();
        response.sendRedirect("../index.jsp");
    }
%>
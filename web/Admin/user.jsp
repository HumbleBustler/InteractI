<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    if(!session.getAttribute("type").equals("admin")){
        response.sendRedirect("../index.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href= "../Bootstrap/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
    </head>
    <body class="container">
        <h1 style="text-align: center">Admin Panel</h1><hr>
        <h3 style="text-align: center; color: red">Manage Super User</h3>

        <%@include file="navigation_bar.jsp" %>
        
        <div class="row">
            <div class="col-md-6" style="border-right: 1px solid black">
                <h4 style="text-align: center">Add Users</h4>
                
                <form method="post" >
                    <div class="input-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" required size="30">
                    </div>
                    
                    
                    <div class="input-group">
                        <label>Password</label> 
                        <input type="password" name="password" class="form-control" required size="26">
                    </div>
                    
                    <br>
                    <div class="form-group">
                        <input type="submit" name="submit" value="Create" class="btn btn-primary">
                    </div>
                </form>
                
            </div>
            <div class="col-md-6">
                <h4>View All Users</h4>
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>Email</th>
                            <th>Type</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <%
                    try{
                    String query1 = "select * from user ";
                    Connection.Db_Connection cc= new Connection.Db_Connection();
                    Statement st1  = Connection.Db_Connection.connection().createStatement();
                    ResultSet rs = st1.executeQuery(query1);
                    
                    while(rs.next()){
                        String name = rs.getString("username");
                        String type = rs.getString("type");
                        out.println("<tr>");
                        out.println("<td> "+name+" </td>");
                        out.println("<td> "+type+" </td>");
                        if(name.equalsIgnoreCase("adnan@gmail.com")){
                            out.println("<td> Head</td>");
                        }else
                        out.println("<td><a href='user.jsp?username="+name+" '> Delete </a></td>");
                        out.println("</tr>");
                    }
                    rs.close();
                    st1.close();
                    }catch(Exception e){
                       out.println(e);
                    }
                    %>
                    
                </table>
                
            </div>
        </div>
    </body>
</html>
<% 
         String submit = request.getParameter("submit");
         if(submit != null){
         String email = request.getParameter("email");
         String password = request.getParameter("password");
         String type = "Admin";
         
         String query  = "INSERT INTO user(username , password , type) VALUES('"+email+"' , '"+password+"' , '"+type+"') ";
          try{
              Connection.Db_Connection cc = new Connection.Db_Connection();
              Statement st3 = Connection.Db_Connection.connection().createStatement();
              st3.executeUpdate(query);
               out.println("<script> alert('New User has been created'); </script>");
               response.sendRedirect("user.jsp");
               st3.close();
          }catch(SQLException e){
              if(e.getErrorCode() == 1062){
               out.println("<script> alert('This Email is already Registered'); </script>");
              }
          }
          catch(Exception e){
              out.println(e);
          }
            
         }
         
  String username_delete = request.getParameter("username");
    if(username_delete !=null ){
        String delete_query = "DELETE FROM user WHERE username ='"+username_delete+"' ";
        try{
            Statement sttt = Connection.Db_Connection.connection().createStatement();
            sttt.executeUpdate(delete_query);
            sttt.close();
            out.println("<script> alert('User has been Deleted');  </script>");
            response.sendRedirect("user.jsp");
        }catch(Exception e){
            out.println(e);
        }
    }
    
    
   
%>
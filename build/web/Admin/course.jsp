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
        <h3 style="text-align: center; color: red">Manage Lecturer</h3>
        <%@include file="navigation_bar.jsp" %>
        <br>
        <div class="row">
            <div class="col-md-4" style="border-right: 1px solid black">
                <h4 style="text-align: center">Add Courses</h4><br><br>
                
                <form method="post" >
                    <div class="input-group">
                        <label>Course Code</label>
                        <input type="text" name="id" class="form-control" required size="31" id="id">
                    </div>                    
                    <div class="input-group">
                        <label>Course Title</label> 
                        <input type="text" name="title" class="form-control" required size="32" id="title">
                    </div>
                    <div class="input-group">
                        <label>Prerequistes</label> 
                        <input type="text" name="prerequisit" class="form-control" required size="31" id="sirname">
                    </div>
                    
                    
                    <br>
                    <div class="input-group">
                        <center> <input type="submit" name="submit" value="Add Course" class="btn btn-default"> 
                         <input type="submit" name="Update" value="Update Course" class="btn btn-default"> </center> 
                        
                    </div>
                </form>
                
            </div>
            <div class="col-md-8">
                <h4>View All Lecturer</h4><br><br>
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>Course Code</th>
                            <th>Course Title</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <%
                    try{
                    String query1 = "select * from course";
                    Connection.Db_Connection cc= new Connection.Db_Connection();
                    Statement st1  = Connection.Db_Connection.connection().createStatement();
                    ResultSet rs = st1.executeQuery(query1);
                    
                    while(rs.next()){
                        String lid = rs.getString("cid");
                        String title = rs.getString("title");
                        String sirname = rs.getString("prerequistes");
                        out.println("<tr>");
                        out.println("<td> "+lid+" </td>");
                        out.println("<td> "+title+" </td>");
                        out.println("<td><a href='course.jsp?update="+lid+" '> Update </a></td>");
                        out.println("<td><a href='course.jsp?delete="+lid+" '> Delete </a></td>");
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
        </div><br><br>
    </body>
</html>
<% 
         String submit = request.getParameter("submit");
         if(submit != null){
         String title  =request.getParameter("title");
         String sirname = request.getParameter("prerequisit");
         String id = request.getParameter("id");
         
         
          try{
              if(Connection.Db_Connection.connection() == null){
                  Connection.Db_Connection.connect();
              }
              Statement st3 = Connection.Db_Connection.connection().createStatement();
              String  query3 = "INSERT INTO course(cid , title, prerequistes) VALUES('"+id+"' , '"+title+"' , '"+sirname+"')";     
              st3.executeUpdate(query3);
              response.sendRedirect("course.jsp");
              st3.close();
          }catch(SQLException e){
              if(e.getErrorCode() == 1062){
               out.println("<script> alert('This Email is already Registered'); </script>");
              }
              out.println(e);
          }
          catch(Exception e){
              out.println(e);
          }
            
         }//end of if statement
         
  String sid = request.getParameter("delete");
    if(sid !=null ){
        String delete_query = "DELETE FROM course WHERE cid ='"+sid+"' ";
        try{
            Statement sttt = Connection.Db_Connection.connection().createStatement();
            sttt.executeUpdate(delete_query);
            sttt.close();
            out.println("<script> alert('User has been Deleted');  </script>");
            response.sendRedirect("course.jsp");
        }catch(Exception e){
            out.println(e);
        }
    }
    
    
    
    String update_id = request.getParameter("update");
    if(update_id !=null){
        String update_search = "select * from course where cid ='"+update_id+"' ";
        try{
            Statement upSt= Connection.Db_Connection.connection().createStatement();
            ResultSet rss = upSt.executeQuery(update_search);
            if(rss.next()){
                String title = rss.getString("title");
                String prerequistes = rss.getString("prerequistes");
                out.println("<script> document.getElementById('id').value = "+update_id+"; </script>");
                out.println("<script> document.getElementById('title').value = '"+title+"'; </script>");
                out.println("<script> document.getElementById('sirname').value = '"+prerequistes+"'; </script>");
                
                rss.close();
                upSt.close();
            }//end of while loop
        }catch(Exception e){
            out.println(e);
        }
    }
    
    
    String update = request.getParameter("Update");
    if(update != null){
         String title1  =request.getParameter("title");
         String prerequisit = request.getParameter("prerequisit");
         String id1 = request.getParameter("id");
         String idd = request.getParameter("update");
         String update_query = "UPDATE course SET title = '"+title1+"'  , prerequistes = '"+prerequisit+"' where cid = '"+idd+"' ";
         try{
            Statement update_statement = Connection.Db_Connection.connection().createStatement();
            update_statement.executeUpdate(update_query);
            update_statement.close();
            response.sendRedirect("course.jsp");
         }catch(SQLException e){
             if(e.getErrorCode() == 1062){
                 out.println("<script> alert('This Email is Alredy Registered'); </script>");
             }
             out.println(e);
         }
         catch(Exception ex){
             out.println(ex);
         }
    }
   
%>
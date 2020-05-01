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
        <h3 style="text-align: center; color: red">Manage Student</h3>

       <%@include file="navigation_bar.jsp" %>
        <br>
        <div class="row">
            <div class="col-md-4" style="border-right: 1px solid black">
                <h4 style="text-align: center">Add Student</h4><br><br>
                
                <form method="post" >
                    <div class="input-group">
                        <label>Student ID</label>
                        <input type="text" name="id" class="form-control" required size="30" id="id">
                    </div>                    
                    <div class="input-group">
                        <label>First Name</label> 
                        <input type="text" name="fname" class="form-control" required size="29" id="fname">
                    </div>
                    <div class="input-group">
                        <label>Sir Name</label> 
                        <input type="text" name="sname" class="form-control" required size="31" id="sirname">
                    </div>
                    
                     <div class="input-group">
                        <label>Email</label> 
                        <input type="email" name="email" class="form-control" required size="34" id="email">
                    </div>
                    
                     <div class="input-group">
                        <label>Major</label> 
                        <input type="text" name="major" class="form-control" required size="34" id="major">
                    </div>
                    
                     <div class="input-group">
                        <label>Password</label> 
                        <input type="password" name="password" class="form-control" required size="30" id="password">
                    </div>
                    
                    <br>
                    <div class="input-group">
                        <center> <input type="submit" name="submit" value="Add Student" class="btn btn-default"> 
                         <input type="submit" name="Update" value="Update" class="btn btn-default"> </center> 
                        
                    </div>
                </form>
                
            </div>
            <div class="col-md-8">
                <h4>View All Students</h4><br><br>
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>S_ID</th>
                            <th>First Name</th>
                            <th>Sir Name</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <%
                    try{
                    String query1 = "select * from student";
                    Connection.Db_Connection cc= new Connection.Db_Connection();
                    Statement st1  = Connection.Db_Connection.connection().createStatement();
                    ResultSet rs = st1.executeQuery(query1);
                    
                    while(rs.next()){
                        String sid = rs.getString("sid");
                        String fname = rs.getString("fname");
                        String sirname = rs.getString("surname");
                        out.println("<tr>");
                        out.println("<td> "+sid+" </td>");
                        out.println("<td> "+fname+" </td>");
                        out.println("<td> "+sirname+" </td>");
                        out.println("<td><a href='student.jsp?update="+sid+" '> Update </a></td>");
                        out.println("<td><a href='student.jsp?delete="+sid+" '> Delete </a></td>");
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
         String email = request.getParameter("email");
         String password = request.getParameter("password");
         String fname  =request.getParameter("fname");
         String sirname = request.getParameter("sname");
         String major = request.getParameter("major");
         String id = request.getParameter("id");
         
         String type = "Student";
         
         String query  = "INSERT INTO user(username , password , type) VALUES('"+email+"' , '"+password+"' , '"+type+"') ";
          try{
              if(Connection.Db_Connection.connection() == null){
                  Connection.Db_Connection.connect();
              }
              Statement st3 = Connection.Db_Connection.connection().createStatement();
              st3.executeUpdate(query);
              String  query3 = "INSERT INTO student(sid , fname , surname , email , major , password) VALUES('"+id+"' , '"+fname+"' , '"+sirname+"' , '"+email+"' , '"+major+"' , '"+password+"')";     
              st3.executeUpdate(query3);
              response.sendRedirect("student.jsp");
              st3.close();
          }catch(SQLException e){
              if(e.getErrorCode() == 1062){
               out.println("<script> alert('This Email is already Registered'); </script>");
              }
          }
          catch(Exception e){
              out.println(e);
          }
            
         }//end of if statement
         
  String sid = request.getParameter("delete");
    if(sid !=null ){
        String delete_query = "DELETE FROM student WHERE sid ='"+sid+"' ";
        try{
            Statement sttt = Connection.Db_Connection.connection().createStatement();
            sttt.executeUpdate(delete_query);
            sttt.close();
            out.println("<script> alert('User has been Deleted');  </script>");
            response.sendRedirect("student.jsp");
        }catch(Exception e){
            out.println(e);
        }
    }
    
    
    
    String update_id = request.getParameter("update");
    if(update_id !=null){
        String update_search = "select * from student where sid ='"+update_id+"' ";
        try{
            Statement upSt= Connection.Db_Connection.connection().createStatement();
            ResultSet rss = upSt.executeQuery(update_search);
            if(rss.next()){
                String fname = rss.getString("fname");
                String sirname = rss.getString("surname");
                String email = rss.getString("email");
                String major = rss.getString("major");
                out.println("<script> document.getElementById('id').value = "+update_id+"; </script>");
                out.println("<script> document.getElementById('fname').value = '"+fname+"'; </script>");
                out.println("<script> document.getElementById('sirname').value = '"+sirname+"'; </script>");
                out.println("<script> document.getElementById('email').value = '"+email+"'; </script>");
                out.println("<script> document.getElementById('major').value = '"+major+"'; </script>");
                rss.close();
                upSt.close();
            }//end of while loop
        }catch(Exception e){
            out.println(e);
        }
    }
    
    
    String update = request.getParameter("Update");
    if(update != null){
         String email1 = request.getParameter("email");
         String fname1  =request.getParameter("fname");
         String sirname1 = request.getParameter("sname");
         String major1 = request.getParameter("major");
         String id1 = request.getParameter("id");
         String idd = request.getParameter("update");
         String update_query = "UPDATE student SET  fname ='"+fname1+"' , surname='"+sirname1+"' , major ='"+major1+"'  where sid = '"+idd+"'   ";
         try{
            Statement update_statement = Connection.Db_Connection.connection().createStatement();
            update_statement.executeUpdate(update_query);
            update_statement.close();
            response.sendRedirect("student.jsp");
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
<%@page import="Connection.Db_Connection"%>
<%@page import="Connection.Db_Returns"%>
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
        <h3 style="text-align: center; color: red">Assign Courses to Lecturer</h3>
        <%@include file="navigation_bar.jsp" %>
        <br>
        <div class="row">
            <div class="col-md-4" >
                <h4 style="text-align: center">Assign Course</h4><br><br>
                
                <form method="post" >
                    <div class="input-group">
                        <label >Select Lecturer</label>
                        <select name="lecturer" class="form-control">
                            <% 
                            String query = "select * from lecturer";
                            Statement st =  Db_Connection.connection().createStatement();
                            ResultSet lecture_rs = st.executeQuery(query);
                            while(lecture_rs.next()){
                                String id = lecture_rs.getString("lid");
                                String name = lecture_rs.getString("gname");
                                out.println("<option value="+id+"> "+name+" </option>");
                            }
                            
                            %>
                        </select>
                    </div>
                       
                             <div class="input-group">
                        <label >Select Course</label>
                        <select name="course" class="form-control">
                            <% 
                            query = "select * from course";
                            st =  Db_Connection.connection().createStatement();
                            ResultSet course_rs = st.executeQuery(query);
                            while(course_rs.next()){
                                String id = course_rs.getString("cid");
                                String name = course_rs.getString("title");
                                out.println("<option value="+id+"> "+name+" </option>");
                            }
                            
                            %>
                        </select>
                    </div>
                        
                        <div class="input-group">
                        <label >Select Semester</label>
                        <select name="semester" class="form-control">
                            <option value="1">Semester 1</option>
                            <option value="2">Semester 2</option>
                            <option value="3">Semester 3</option>
                            <option value="4">Semester 4</option>
                            <option value="5">Semester 5</option>
                            <option value="6">Semester 6</option>
                            <option value="7">Semester 7</option>
                            <option value="8">Semester 8</option>
                        </select>
                    </div>
                        <div class="input-group">
                            <label>Enter Capacity</label>
                            <input type="number" name="capacity" class="form-control"  size="10" required >
                        </div>   
                        <br>
                        <br>
                        <div class="input-group">
                            <input type="submit" name="submit" class="btn btn-danger" value="Assign ">
                        </div>   
                        
                </form>
                
            </div>
            <div class="col-md-8" style="border-left: 1px solid black">
                <h4>View All Lecturer</h4><br><br>
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>CCID</th>
                            <th>Course Title</th>
                            <th>Lecturer</th>
                            <th>Semester</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <%
                    try{
                    String query1 = "select * from course_conduction";
                    Statement st1  = Connection.Db_Connection.connection().createStatement();
                    ResultSet rs = st1.executeQuery(query1);
                    
                    while(rs.next()){
                        String ccid = rs.getString("ccid");
                        String title = rs.getString("cid");
                        title = Db_Returns.Db_Return("course", "cid", title, "title");
                        String lecturere = rs.getString("lid");
                        lecturere = Db_Returns.Db_Return("lecturer", "LID", lecturere, "gname");
                        String Semester = rs.getString("semester");
                        out.println("<tr>");
                        out.println("<td> "+ccid+" </td>");
                        out.println("<td> "+title+" </td>");
                        out.println("<td> "+lecturere+" </td>");
                        out.println("<td> "+Semester+" </td>");
                        out.println("<td><a href='assignment.jsp?delete="+ccid+" '> Delete </a></td>");
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
          String lecturer = request.getParameter("lecturer");
          String course = request.getParameter("course");
          String semester = request.getParameter("semester");
          String capacity = request.getParameter("capacity");
              
          try{
              if(Connection.Db_Connection.connection() == null){
                  Connection.Db_Connection.connect();
              }
              Statement st3 = Connection.Db_Connection.connection().createStatement();
              String  query3 = "INSERT INTO course_conduction(lid , cid , semester , capacity) VALUES('"+lecturer+"' , '"+course+"' , '"+semester+"' , '"+capacity+"')";     
              st3.executeUpdate(query3);
              response.sendRedirect("assignment.jsp");
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
         
  String ccid = request.getParameter("delete");
    if(ccid !=null ){
        String delete_query = "DELETE FROM course_conduction WHERE ccid ='"+ccid+"' ";
        try{
            Statement sttt = Connection.Db_Connection.connection().createStatement();
            sttt.executeUpdate(delete_query);
            sttt.close();
            out.println("<script> alert('Conducted Course has been deleted has been Deleted');  </script>");
            response.sendRedirect("assignment.jsp");
        }catch(Exception e){
            out.println(e);
        }
    }
    
    
    
   
    
    
%>
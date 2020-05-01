<%@page import="Connection.Db_Connection"%>
<%@page import="Connection.Db_Returns"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Panel</title>
        <link rel="stylesheet" href="../Bootstrap/bootstrap.min.css">
    </head>
    <body class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 style="text-align:  center; padding: 50px; border-radius:5px; color: white; box-shadow: 0px 0px 10px gainsboro ; background-color: #23527c" > Student Panel</h1><hr><hr>
                <br>
                <div class="row">
                    <div class="col-md-3">
                        <%@include file="navigation.jsp" %>
                    </div>
                    <div class="col-md-9" >
                        <h3 style="text-align: center">Enroll Yourself for Course below in list </h3><hr>
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Course</th>
                                    <th>Lecturer</th>
                                    <th>Email</th>
                                    <th>Capacity</th>
                                    <th>Semester</th>
                                    <th>Action</th>
                                </tr>
                                <% 
                                String query = "select * from course_conduction ";
                                try{
                                    Statement st = Connection.Db_Connection.connection().createStatement();
                                    ResultSet rs = st.executeQuery(query);
                                    while(rs.next()){
                                        String idd = rs.getString("ccid");
                                        String lecture = rs.getString("lid");
                                        String course = rs.getString("cid");
                                     
                                        String capacity  = rs.getString("capacity");
                                        String semester = rs.getString("semester");
                                        String email = Db_Returns.Db_Return("lecturer", "lid", lecture, "email");
                                        lecture = Db_Returns.Db_Return("lecturer", "lid", lecture, "gname");
                                        course = Db_Returns.Db_Return("course", "cid", course, "title");
                                      
                                        String user_DD = session.getAttribute("username").toString();
                                        user_DD = Db_Returns.Db_Return("student", "email", user_DD, "sid");
               
                                      
                                         
                                        out.println("<tr>");
                                        out.println("<td>"+course+"  </td>");
                                        out.println("<td>"+lecture+"  </td>");
                                        out.println("<td>"+email+"  </td>");
                                        out.println("<td>"+capacity+"  </td>");
                                        out.println("<td>"+semester+"  </td>");
                                        out.println("<td> <a href='Enroll_Yourself.jsp?take="+idd+"'>Take</a> </td>");
                                        
                                        out.println("</tr>");
                                        
                                    }
                                }catch(SQLException e){
                                    out.println(e);
                                }
                                %>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>


<% 
           String take = request.getParameter("take");
           if(take != null){
               
               String user = session.getAttribute("username").toString();
               String course_id = Db_Returns.Db_Return("course_conduction", "ccid", take, "cid");
               String student_id = Db_Returns.Db_Return("student", "email", user, "sid");
               String semester = Db_Returns.Db_Return("course_conduction", "ccid", take, "semester");
               String max_Allowed= Db_Returns.Db_Return("course_conduction", "ccid", take, "capacity");
               int maxAlloed = 0;
               if(max_Allowed != null){
                   maxAlloed = Integer.parseInt(max_Allowed);
               }

               Statement state = Db_Connection.connection().createStatement();
               String Enrolled_quer = "select Count(*) as maxx from enrollment where semester ='"+semester+"' AND cid = '"+course_id+"' ";
               ResultSet count_Rss = state.executeQuery(Enrolled_quer);
              int max_enrolled = 0;
               if(count_Rss.next()){
                  max_enrolled = count_Rss.getInt("maxx");
               }
               String check_query = "select * from enrollment where sid = '"+student_id+"' and cid = '"+course_id+"' ";
               ResultSet rss  = state.executeQuery(check_query);
               boolean found = false;
               while(rss.next()){
                   found = true;
               }
                  try{
                   if(max_enrolled >= maxAlloed){
                       out.println("<script> alert('Class is Full of Max Allowed Students');  </script>");
                   }else{ 
                   if(found == false){
                   String insert_query = "INSERT INTO enrollment(sid , cid , semester) VALUES('"+student_id+"' , '"+course_id+"','"+semester+"')";
                   state.executeUpdate(insert_query);
                   out.println("<script> alert('You took course successfully');  </script>");
                   response.sendRedirect("Enroll_Yourself.jsp");
                   }else{
                       out.println("<script> alert('You Already Taken This Course');  </script>");
                   }
                   }
               }catch(SQLException e){
                   out.println(e);
               } 
              
           }
%>
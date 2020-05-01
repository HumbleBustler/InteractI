<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Connection.Db_Returns"%>
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
                    <div  class="col-md-9">
                        <% 
                        String current  = request.getParameter("current");
                        if(current != null){
                            out.println("<h3>Current Semester Courses </h3><hr>");
                            String student_id = session.getAttribute("username").toString();
                            student_id = Db_Returns.Db_Return("student", "email", student_id, "sid");
                            String semester_query = "select * from enrollment where sid = '"+student_id+"' AND semester = (select MAX(semester) from enrollment) ";
                            try{
                             Statement st = Connection.Db_Connection.connection().createStatement();
                             ResultSet rss = st.executeQuery(semester_query);
                             int count = 0;
                             while(rss.next()){
                                 count++;
                                 String sid  = rss.getString("sid");
                                 String cid = rss.getString("cid");
                                 String course_title = Db_Returns.Db_Return("course", "cid", cid, "title");
                                 String lecture_name = Db_Returns.Db_Return("course_conduction", "cid", cid, "lid");
                                 String idd = lecture_name;
                                 lecture_name = Db_Returns.Db_Return("lecturer", "lid", lecture_name, "gname");
                                 String lecture_email = Db_Returns.Db_Return("lecturer", "lid", idd, "email");
                                 String pre = Db_Returns.Db_Return("course", "cid", cid, "prerequistes");
                                 out.println("<h4 style='color:red'> Course No : "+count+"</h4>");
                                %>
                                
                                <table class="table table-bordered table-hover table-striped">
                                     <thead>
                                         <tr>
                                             <th>Course Title</th>
                                             <th>Lecturer </th>
                                             <th>Email</th>
                                             <th>Pre-requisites </th>
                                         </tr>
                                     </thead>
                                 <%
                                 out.println("<tr>");
                                 out.println("<td> "+course_title+" </td>");
                                 out.println("<td> "+lecture_name+" </td>");
                                 out.println("<td> "+lecture_email+" </td>");
                                 out.println("<td> "+pre+" </td>");
                                 out.println("<tr> ");        
                                 %>
                                 </table>
                                 <%
                             }   
                             
                            }catch(SQLException e){
                                out.println(e);
                            }
                        }
                        
                        
                        
                            current  = request.getParameter("old");
                        if(current != null){
                            out.println("<h3>Old Courses you have taken  </h3><hr>");
                            String student_id = session.getAttribute("username").toString();
                            student_id = Db_Returns.Db_Return("student", "email", student_id, "sid");
                            String semester_query = "select * from enrollment where sid = '"+student_id+"' AND semester != (select MAX(semester) from enrollment) ";
                            try{
                             Statement st = Connection.Db_Connection.connection().createStatement();
                             ResultSet rss = st.executeQuery(semester_query);
                             int count = 0;
                             while(rss.next()){
                                 count++;
                                 String sid  = rss.getString("sid");
                                 String cid = rss.getString("cid");
                                 String course_title = Db_Returns.Db_Return("course", "cid", cid, "title");
                                 String lecture_name = Db_Returns.Db_Return("course_conduction", "cid", cid, "lid");
                                 String idd = lecture_name;
                                 lecture_name = Db_Returns.Db_Return("lecturer", "lid", lecture_name, "gname");
                                 String lecture_email = Db_Returns.Db_Return("lecturer", "lid", idd, "email");
                                 String pre = Db_Returns.Db_Return("course", "cid", cid, "prerequistes");
                                 out.println("<h4 style='color:red'> Course No : "+count+"</h4>");
                                %>
                                
                                <table class="table table-bordered table-hover table-striped">
                                     <thead>
                                         <tr>
                                             <th>Course Title</th>
                                             <th>Lecturer </th>
                                             <th>Email</th>
                                             <th>Pre-requisites </th>
                                         </tr>
                                     </thead>
                                 <%
                                 out.println("<tr>");
                                 out.println("<td> "+course_title+" </td>");
                                 out.println("<td> "+lecture_name+" </td>");
                                 out.println("<td> "+lecture_email+" </td>");
                                 out.println("<td> "+pre+" </td>");
                                 out.println("<tr> ");        
                                 %>
                                 </table>
                                 <%
                             }   
                             
                            }catch(SQLException e){
                                out.println(e);
                            }
                        }
                        
                        
                        String view_marks = request.getParameter("view_marks");
                        if(view_marks != null){
                            String student_id = session.getAttribute("username").toString();
                            student_id = Db_Returns.Db_Return("student", "email", student_id, "sid");
                            String query = "select * from assessment  where sid = '"+student_id+"'";
                            try{
                                Statement view_statement = Connection.Db_Connection.connection().createStatement();
                                ResultSet view_rs = view_statement.executeQuery(query);
                                int count = 0;
                                while(view_rs.next()){
                                    count++;
                                    String eid = view_rs.getString("eid");
                                    String A2 = view_rs.getString("A1");
                                    String A1 = view_rs.getString("A2");
                                    String coures_id = Db_Returns.Db_Return("enrollment", "eid", eid, "cid");
                                    String semester = Db_Returns.Db_Return("enrollment", "eid", eid, "semester");
                                    String course_title = Db_Returns.Db_Return("course", "cid", coures_id, "title");
                                    out.println("<h4> Course : "+count+"  </h4>");
                                    %>
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>Course</th>
                                                <th>Semester</th>
                                                <th>Marks 1</th>
                                                <th>Marks 2</th>
                                            </tr>
                                        </thead>
                                        <%  
                                        out.println("<tr>");
                                        out.println("<td>"+course_title+"</td>");
                                        out.println("<td>"+semester+"</td>");
                                        out.println("<td>"+A1+"</td>");
                                        out.println("<td>"+A2+"</td>");
                                        out.println("</tr>");
                                        %>
                                    </table>
                                    <%
                                }//end of while loop
                            }catch(SQLException e){
                                out.println(e);
                            }
                        }//end of if statement 
                        
                     %>
                        
                     <%   // View your profile code
                    String profile = request.getParameter("profile");
                    if(profile !=null ){
                        String username_profile =session.getAttribute("username").toString();
                        try{
                            String profile_query = "select * from student where email = '"+username_profile+"' ";
                            Statement profile_stStatemet = Connection.Db_Connection.connection().createStatement();
                            ResultSet profile_rs = profile_stStatemet.executeQuery(profile_query);
                            if(profile_rs.next()){
                                String name = profile_rs.getString("fname");
                                String sirname = profile_rs.getString("surname");    
                                String campus = profile_rs.getString("major");
                                String email = profile_rs.getString("email");
                                out.println("<h2> Your Profile  </h2><br><hr><br>");
                                out.println("<h4> Name     : <small>"+name+"  </small>  </h4><br>  ");
                                out.println("<h4> Surname     : <small>"+sirname+"  </small>  </h4><br>  ");
                                out.println("<h4> Major     : <small>"+campus+"  </small>  </h4><br>  ");
                                out.println("<h4> E mail     : <small>"+email+"  </small>  </h4><br>  ");           

                            }
                        }catch(SQLException e){
                            out.println(e);
                        }
                    }
                    %>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

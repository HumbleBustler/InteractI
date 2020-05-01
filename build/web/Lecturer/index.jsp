<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Connection.Db_Returns"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String username = session.getAttribute("username").toString();
    if(username == null){
        response.sendRedirect("../index.jsp");
    }
    
     String logout = request.getParameter("logout");
    if(logout != null){
        session.invalidate();
        response.sendRedirect("../index.jsp");
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lecture Home</title>
        <link href="../Bootstrap/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 style="text-align:  center; padding: 50px; border-radius:5px; color: white; box-shadow: 0px 0px 10px gainsboro ; background-color: orange" > Lecturer Panel</h1><hr><hr>
            </div>
            <div class="row">
                <div class="col-md-3" >
                    <%@include file="navigation.jsp" %>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-8">
                    <%
                        String list = request.getParameter("couse_list");
                        if(list != null){
                         %>
                         <h3 style="text-align: center">Courses List</h3>
                         <table class="table table-hover table-bordered table-striped">
                             <thead>
                                 <tr>
                                     <th>Lecturer Name</th>
                                     <th>Course</th>
                                     <th>Semester</th>
                                     <th>Capacity</th>
                                 </tr>
                                 
                             </thead>
                            <%
                            try{
                            String usernamea = session.getAttribute("username").toString();
                             usernamea = Db_Returns.Db_Return("lecturer", "email", usernamea, "LID");
                             
                             String query_list_course = "select * from course_conduction where lid = '"+usernamea+"' ";
                             Statement list_statement = Connection.Db_Connection.connection().createStatement();
                             ResultSet rs_list = list_statement.executeQuery(query_list_course);
                             while(rs_list.next()){
                                 String lecture_name = rs_list.getString("lid");
                                 String lecture_course = rs_list.getString("cid");
                                 lecture_name = Db_Returns.Db_Return("lecturer", "LID", lecture_name, "gname");
                                 lecture_course = Db_Returns.Db_Return("course", "cid", lecture_course, "title");
                                 String list_semester  =  rs_list.getString("semester");
                                 String capacity  = rs_list.getString("capacity");
                                 out.println("<tr>");
                                 out.println("<td> "+lecture_name+" </td>");
                                 out.println("<td> "+lecture_course+" </td>");
                                 out.println("<td> "+list_semester+" </td>");
                                 out.println("<td> "+capacity+" </td>");
                                 out.println("</tr>");
                             }
                             rs_list.close();
                             list_statement.close();
                            }catch(SQLException e){
                                out.println(e);
                            }
                            catch(Exception e){
                                out.println(e);     
                            }
                            
                            %>
                         </table>
                        <%     // Here the code to display profile of logedin  person

                        }
                    %>
                    <%  
                    String profile = request.getParameter("profile");
                    if(profile !=null ){
                        String username_profile =session.getAttribute("username").toString();
                        try{
                            String profile_query = "select * from lecturer where email = '"+username_profile+"' ";
                            Statement profile_stStatemet = Connection.Db_Connection.connection().createStatement();
                            ResultSet profile_rs = profile_stStatemet.executeQuery(profile_query);
                            if(profile_rs.next()){
                                String name = profile_rs.getString("gname");
                                String sirname = profile_rs.getString("surname");    
                                String campus = profile_rs.getString("campus");
                                String email = profile_rs.getString("email");
                                out.println("<h2> Your Profile  </h2><br><hr><br>");
                                out.println("<h4> Name     : <small>"+name+"  </small>  </h4><br>  ");
                                out.println("<h4> Surname     : <small>"+sirname+"  </small>  </h4><br>  ");
                                out.println("<h4> Campus     : <small>"+campus+"  </small>  </h4><br>  ");
                                out.println("<h4> email     : <small>"+email+"  </small>  </h4><br>  ");           

                            }
                        }catch(SQLException e){
                            out.println(e);
                        }
                    }
                    %>
                    
                    <%      //View all students code
                    
                    String capacity = request.getParameter("capacity");
                    if(capacity != null){
                        %>
                        <table class="table table-bordered table-hover table-striped>"
                               <thead>
                                <tr>
                                    <th>Course Title</th>
                                    <th>Course Capacity</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                        
                        <%
                        String lecture_idd = session.getAttribute("username").toString();
                        lecture_idd = Db_Returns.Db_Return("lecturer", "email", lecture_idd, "LID");
                        String query = "SELECT * FROM course_conduction where LID = '"+lecture_idd+"' ";
                        try{
                            Statement capacity_st = Connection.Db_Connection.connection().createStatement();
                            ResultSet rsss = capacity_st.executeQuery(query);
                            while(rsss.next()){
                                String course_counduct_id1 = rsss.getString("ccid");
                                String title = rsss.getString("cid");
                                title = Db_Returns.Db_Return("course", "cid", title, "title");
                                String course_capacity = rsss.getString("capacity");
                                out.println("<tr>");
                                out.println("<td> "+title+" </td>");
                                out.println("<td> "+course_capacity+" </td>");
                                out.println("<td> <a href='index.jsp?capacity=1&ccid="+course_counduct_id1+"' >Change </a></td>");
                                out.println("</tr>");
                            }
                        }catch(SQLException e){
                            out.println(e);
                        }
                    }
                    %>
                    </table>
                    
                    <%
                    String update = request.getParameter("ccid");
                    if(update != null){
                        %>
                        <form method="post">
                            <div class="input-group">
                                <label><% out.println(Db_Returns.Db_Return("course", "cid", Db_Returns.Db_Return("course_conduction", "ccid", update, "cid"), "title")); %></label>
                                <input type="number" name="capacity11"  class="form-control" required>
                            </div>
                                <br>
                                <div class="input-group">
                                    <input type="submit" name="sub" value="Change" class="btn btn-default" required>
                                </div>
                        </form>
                        <%
                                
                       String value = request.getParameter("sub");
                       if(value != null){
                          try{
                          String capacity_of_class = request.getParameter("capacity11");
                          out.println(capacity_of_class);
                          String course_counduct_id =request.getParameter("ccid");
                          String query_update = "UPDATE course_conduction SET capacity = '"+capacity_of_class+"' where ccid ='"+course_counduct_id+"' ";
                          Statement update_st = Connection.Db_Connection.connection().createStatement();
                          update_st.executeUpdate(query_update);
                          response.sendRedirect("index.jsp?capacity=1");
                          }catch(SQLException e){
                              out.println(e);
                          }
                       }
                    }
                     // View all students code
                    String viewall = request.getParameter("viewAll");
                    if(viewall != null){
                     String lecture_id_viewall =  Db_Returns.Db_Return("lecturer", "email", session.getAttribute("username").toString(),"lid");
                     
                    }
                  
                    %>
                    
                    
                </div>
            </div>
        </div>
    </body>
</html>

<%@page import="java.util.ArrayList"%>
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
                        String enter = request.getParameter("enter");
                        if(enter !=null){
                        out.println("<h3 style='text-align:center'> Insert  Marks </h3><hr>");   
                        String teacher_id = session.getAttribute("username").toString();
                        teacher_id = Db_Returns.Db_Return("lecturer", "email", teacher_id, "lid");
                        String query = "select * from course_conduction where lid = '"+teacher_id+"' ";
                        try{
                            Statement course_statement = Connection.Db_Connection.connection().createStatement();
                            ResultSet rs = course_statement.executeQuery(query);
                            out.println("<form method='post'>");
                            out.println("<select class='form-control' name='subject'>");
                            while(rs.next()){
                                String cid = rs.getString("cid");
                                String title =  Db_Returns.Db_Return("course", "cid", cid, "title");
                                out.println(" <option value='"+cid+"'> "+title+" </option>");
                            }//end of while here
                            out.println("</select >");
                            out.println("<br> <input type='submit' name='sub' value='View' class='btn btn-default'>");
                            out.println("</form>");
                        }catch(SQLException e){
                            out.println(e);
                        }
                        
                        
                        ArrayList<String> course = new ArrayList();
                        String view_all_submit = request.getParameter("sub");
                        if(view_all_submit !=null){
                            out.println("<h3 style='text-align:center'> "+Db_Returns.Db_Return("course", "cid", request.getParameter("subject"), "title")+" </h3>");
                            %>
                            <form method="post">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Assessment 1</th>
                                        <th>Assessment 2</th>
                                    </tr>
                                </thead>
                           
                            <%
                            try{
                                int count = 0;
                            String course_id =  request.getParameter("subject");
                            String lecture_id = session.getAttribute("username").toString();
                            query = "select * from enrollment where cid = '"+course_id+"'   " ;
                            Statement sttt = Connection.Db_Connection.connection().createStatement();
                            ResultSet rss = sttt.executeQuery(query);
                            out.println("<input type='number'  hidden ='true' value='"+course_id+"' name='course_id'  >");
                            while(rss.next()){
                                count++;
                                String id = rss.getString("sid");
                                String  student  = Db_Returns.Db_Return("student", "sid", id ,"fname");
                                out.println("<tr>");
                                out.println("<td> "+student+" </td>");
                                out.println("<td> <input type='number' name='"+id+"' class='from-control' required> </td>");
                                out.println("<td> <input type='number' name='"+id+"1' class='from-control' required> </td>");
                                out.println("</tr>");
                            } 
                           
                            out.println("<br><tr>");
                            out.println("<td> <input type='submit' name='submit_marks' class='btn btn-default'></td>");
                            out.println("</tr>");
                            }catch(Exception e){
                                out.println(e);
                            }
                         }
                        %>
                          </table>
                        </form>
                        <%
                        String add_db = request.getParameter("submit_marks");
                        if(add_db != null){
                          try{
                            String course_id =  request.getParameter("course_id");
                            String lecture_id = session.getAttribute("username").toString();
                            query = "select * from enrollment where cid = '"+course_id+"'   " ;
                            Statement st = Connection.Db_Connection.connection().createStatement();
                            ResultSet rs = st.executeQuery(query);
                            while(rs.next()){
                               String eid = request.getParameter("course_id");
                               eid = Db_Returns.Db_Return("enrollment", "cid", eid, "eid");
                               String semester = Db_Returns.Db_Return("enrollment", "eid", eid, "semester");
                               String id = rs.getString("sid");
                               String as1 = request.getParameter(id);
                               String as2 = request.getParameter(id+"1");
                               try{
                                query = "INSERT INTO assessment(sid , eid , A1 , A2) VALUES('"+id+"', '"+eid+"' , '"+as1+"' , '"+as2+"')";
                                Statement st_insert = Connection.Db_Connection.connection().createStatement();
                                st_insert.executeUpdate(query);
                                      
                                query = "select MAX(aid) as abc from assessment";
                                ResultSet rss = st_insert.executeQuery(query);
                                rss.next();
                                int max = rss.getInt("abc");
                               query = "INSERT INTO course_assessment(cid  ,aid, semester) VALUES('"+course_id+"' ,'"+max+"', '"+semester+"')";
                               st_insert.executeUpdate(query);
                               }catch(SQLException e){
                                   out.println(e);
                               }
                            }  
                        }
                         catch(SQLException e){
                              out.println(e);
                           }
                        }
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                       //Edit marks code here
                        String edit  = request.getParameter("edit");
                        if(edit != null){
                        out.println("<h3 style='text-align:center'> Update Marks </h3>");   
                        String teacher_id = session.getAttribute("username").toString();
                        teacher_id = Db_Returns.Db_Return("lecturer", "email", teacher_id, "lid");
                        String query = "select * from course_conduction where lid = '"+teacher_id+"' ";
                        try{
                            Statement course_statement = Connection.Db_Connection.connection().createStatement();
                            ResultSet rs = course_statement.executeQuery(query);
                            out.println("<form method='post'>");
                            out.println("<select class='form-control' name='subject'>");
                            while(rs.next()){
                                String cid = rs.getString("cid");
                                String title =  Db_Returns.Db_Return("course", "cid", cid, "title");
                                out.println(" <option value='"+cid+"'> "+title+" </option>");
                            }//end of while here
                            out.println("</select >");
                            out.println("<br> <input type='submit' name='sub' value='View' class='btn btn-default'>");
                            out.println("</form>");
                        }catch(SQLException e){
                            out.println(e);
                        }
                        
                        
                        ArrayList<String> course = new ArrayList();
                        String view_all_submit = request.getParameter("sub");
                        if(view_all_submit !=null){
                            out.println("<h3 style='text-align:center'> "+Db_Returns.Db_Return("course", "cid", request.getParameter("subject"), "title")+" </h3>");
                            %>
                            <form method="post">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Assessment 1</th>
                                        <th>Assessment 2</th>
                                    </tr>
                                </thead>
                           
                            <%
                            try{
                                int count = 0;
                            String course_id =  request.getParameter("subject");
                            String lecture_id = session.getAttribute("username").toString();
                            query = "select * from course_assessment where cid = '"+course_id+"'   " ;
                            Statement sttt = Connection.Db_Connection.connection().createStatement();
                            ResultSet rss = sttt.executeQuery(query);
                            out.println("<input type='number'  hidden ='true' value='"+course_id+"' name='course_id'  >");
                            while(rss.next()){
                                count++;
                                String aid = rss.getString("aid");
                                String eid = Db_Returns.Db_Return("assessment", "aid", aid, "eid");
                                
                                String  student  = Db_Returns.Db_Return("assessment", "aid", aid, "sid");
                                student  = Db_Returns.Db_Return("student", "sid", student, "fname");
                                 String A1 = Db_Returns.Db_Return("assessment", "aid", aid ,"A1");
                                String A2 = Db_Returns.Db_Return("assessment", "aid", aid ,"A2");
                                out.println("<tr>");
                                out.println("<td> "+student+" </td>");
                                out.println("<td> <input type='number' name='"+aid+"update' value='"+A1+"' class='from-control' required> </td>");
                                out.println("<td> <input type='number' name='"+aid+"update1' value='"+A2+"' class='from-control' required> </td>");
                                out.println("</tr>");
                            } 
                           
                            out.println("<br><tr>");
                            out.println("<td> <input type='submit' name='submit_marks' class='btn btn-default'></td>");
                            out.println("</tr>");
                            }catch(Exception e){
                                out.println(e);
                            }
                         }
                        %>
                          </table>
                        </form>
                        <%
                        String add_db = request.getParameter("submit_marks");
                        if(add_db != null){
                          try{
                            String course_id =  request.getParameter("course_id");
                            String lecture_id = session.getAttribute("username").toString();
                            query = "select * from course_assessment where cid = '"+course_id+"'     " ;
                            Statement st = Connection.Db_Connection.connection().createStatement();
                            ResultSet rs = st.executeQuery(query);
                            while(rs.next()){
                               String eid = request.getParameter("cid");
                               eid = Db_Returns.Db_Return("enrollment", "cid", eid, "eid");
                               String aid = rs.getString("aid");
                               eid = Db_Returns.Db_Return("assessment", "aid", aid, "eid");
                               String as1 = request.getParameter(aid+"update");
                               String as2 = request.getParameter(aid+"update1");
                               Statement stt  = Connection.Db_Connection.connection().createStatement();
                               query = "update assessment set A1 = '"+as1+"' , A2 = '"+as2+"' where aid = '"+aid+"' ";
                               stt.executeUpdate(query);
                               }}catch(SQLException e){
                                   out.println(e);
                               }catch(Exception e){
                                   out.println(e);
                               }
                            }  
                        }
                        
                        
                      
                    %>
              
                </div>
            </div>
        </div>
    </body>
</html>
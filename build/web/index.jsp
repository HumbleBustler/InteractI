<%@page import="java.sql.Connection"%>
<%@page import="Connection.Db_Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/Include/header.jsp" %>
<% 
    Db_Connection.connect();
    Connection con  = Db_Connection.connection();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>

    </head>
    <body class="container"><br><br>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4"  style="box-shadow: 0px 0px 10px #DCDCDC">
                <h1 style="text-align: center">Login</h1><hr>
                
              <form method="post" >
                <div class="input-group">
                     <label>Email </label>
                     <input type="email" class="form-control" name="username" required size="24">
                </div>
          
               <div class="input-group">
                     <label>Password </label>
                     <input type="password" class="form-control" name="password" required>
                </div>
                  <br>
                  <div class="input-group">
                      <label>Select Type</label>
                      <select name="type" class="form-control" required>
                          <option value="student">  Student &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</option>
                          <option value="teacher">Teacher</option>
                          <option value="admin"> Admin</option>
                      </select>
                  </div>  
                  
                  <br>
                  <div class="input-group">
                      <input type="submit" class="btn btn-default" name="submit" value="Login">
                  </div>  
                     
              </form><br><br><br><br>
                <div class="row">
                    <div class="col-md-12">
                        <h4 style="text-align: center"><a href="aboutus.html">About Us</a></h4>
                    </div>
                </div> 
                
            </div>
            
        </div> 
    </body>
</html>

<% 
 String login = request.getParameter("submit");
    if(login != null){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String type = request.getParameter("type");
        
        
        String query = "SELECT * FROM user where username ='"+username+"' AND password = '"+password+"' and type = '"+type+"'";
        ResultSet rs=  null;
        try{
             Statement st = Db_Connection.connection().createStatement();
            rs = st.executeQuery(query);
            if(rs.next()){
                if(type.equalsIgnoreCase("admin")){
                    out.println("Admin");
                    response.sendRedirect("Admin/index.jsp");
                }else if(type.equalsIgnoreCase("student")){
                   response.sendRedirect("Student/index.jsp");
                }else{
                   response.sendRedirect("Lecturer/index.jsp");
                }
                session.setAttribute( "username", username );
                session.setAttribute("type", type);
            }else{
                out.println("<script> alert('Your Email or Password is Wrong! Try Again'); </script>");
            }
            rs.close();
            st.close();
        }catch(Exception ex){
         out.println(ex);   
        }
    }
   
    
    
  
    
%>
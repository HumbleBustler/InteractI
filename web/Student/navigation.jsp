<div class="panel panel-default">
    <div class="panel-heading">Navigate</div>
    <div class="panel-body"><br>
      <h5><a href="index.jsp?current=1">View Current Courses</a></h5><br>
      <h5><a href="index.jsp?view_marks=1">View Marks</a></h5><br>
      <h5><a href="index.jsp?old=1">View Old Courses</a></h5><br>
      <h5><a href="Enroll_Yourself.jsp">Enroll Yourself</a></h5><br>
      <h5><a href="index.jsp?profile=1">View Profile</a></h5><br>
      <h5><a href="navigation.jsp?logout">Logout</a></h5><br>
  </div>
  <div class="panel-footer"><strong>User info : <% out.println(session.getAttribute("username").toString()); %></strong></div>
</div>

<% 
        String logout = request.getParameter("logout");
        if(logout != null){
            session.invalidate();
            response.sendRedirect("../index.jsp");
        }
%>
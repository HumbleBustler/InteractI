                          <div class="panel panel-primary">
                            <div class="panel-heading">Navigation Menu</div>
                            <div class="panel-body">
                                <strong><a href="index.jsp?couse_list=1">Courses List</a></strong><br><br> 
                                <strong><a href="assesment_marks.jsp?enter=1">Assesment Marks</a></strong><br><br>
                                 <strong><a href="assesment_marks.jsp?edit=1">Edit Marks</a></strong><br><br>
                                <strong><a href="index.jsp?capacity=1">Change Capacity </a></strong><br><br>
                                 <strong><a href="index.jsp?profile">Your Profile</a></strong><br><br>
                                 <strong><a href="../index.jsp?logout=1">Logout</a></strong><br><br>

                            </div>
                            <div class="panel-footer"><b>User info :</b> <%  out.println(session.getAttribute("username"));  %></div>
                        </div>
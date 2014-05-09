<%-- 
    Document   : cse-add-user
    Created on : 29.04.2014, 22:36:24
    Author     : oneplayer
--%>

<jsp:include page="../generic/header.jsp" flush="true">
    <jsp:param name="titleText" value="Administrator's dashboard"/>
</jsp:include>

<jsp:include page="../generic/dashboardheader.jsp" flush="true">
    <jsp:param name="dashboardText" value="Administrator's dashboard"/>
</jsp:include>

<div class="container">
    <div class="row">
        <jsp:include page="adm-leftmenu.jsp" flush="true">
            <jsp:param name="active" value="add-user" />
        </jsp:include>

        <div class="col-md-9 divitem">
            <form role="form" action="Controller">
                <div class="row">

                    <div class="col-md-7">
                        <h3>Adding new user:</h3>
                        <div class="input-group paddingtop">
                            <span class="input-group-addon">Name</span>
                            <input type="text" class="form-control" name="name" placeholder="Enter full name">
                        </div>
                        <div class="input-group paddingtop">
                            <span class="input-group-addon">E-mail</span>
                            <input type="text" class="form-control" name="email" placeholder="Enter e-mail">
                        </div>
                        <!--                         <div class="input-group paddingtop">
                                                    <span class="input-group-addon">Password</span>
                                                    <input type="text" class="form-control" name="password" placeholder="Enter e-mail">
                                                </div>
                                                 <div class="input-group paddingtop">
                                                    <span class="input-group-addon">Password (confirm)</span>
                                                    <input type="text" class="form-control" name="conf_password" placeholder="Enter e-mail">
                                                </div>-->
                        <!-- Remake to SELECT -->
                        <div class="input-group paddingtop">
                            <span class="input-group-addon">Group</span>
                            <select name="role_id" class="form-control">
                                <option value="">Select group</option>
                                <option value="5">Customer</option>
                                <option value="2">Provision engineer</option>
                                <option value="3">Installation engineer</option>
                                <option value="4">Customer support engineer</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-default margintop" name="command" value="adm_add_user"><span class="glyphicon glyphicon-plus"></span> Add user</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../generic/footer.jsp" flush="true"/>
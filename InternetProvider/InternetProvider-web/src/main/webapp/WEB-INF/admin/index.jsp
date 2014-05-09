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
        <jsp:include page="adm-leftmenu.jsp" flush="true"/>
        <div class="col-md-9 nopadding">
            <jsp:include page="../generic/gen-userinfo.jsp" flush="true"/>
        </div>
        
    </div>
</div>
<jsp:include page="../generic/footer.jsp" flush="true"/>
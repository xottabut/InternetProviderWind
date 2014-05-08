<%-- 
    Document   : cse-page-selected-task
    Created on : May 5, 2014, 1:37:11 PM
    Author     : Anatolii
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../generic/header.jsp" flush="true">
    <jsp:param name="titleText" value="Provisioning Engineer's dashboard"/>
</jsp:include>

<jsp:include page="../generic/dashboardheader.jsp" flush="true">
    <jsp:param name="dashboardText" value="Provisioning Engineer's dashboard"/>
</jsp:include>

<div class="container">
    <div class="row">
        <jsp:include page="pe-leftmenu.jsp" flush="true"/>

        <div class="col-md-9 divitem">
            <br/>ID:${task.id}
            <br/>Status:${task.status}
            <br/>Type:${task.type}
            <br/>Performer:${task.user.name}
            <br/>Costumer Address: ${task.serviceOrder.serviceLocation.address}
            <br/>Provider name: ${task.serviceOrder.providerLocation.name}
            <br/>Provider Address: ${task.serviceOrder.providerLocation.address}
            <br/>Port ID:${task.serviceOrder.serviceInstance.circuit.port.id}
            <br/>Device ID:${task.serviceOrder.serviceInstance.circuit.port.device.id}
            <br/>Device name:${task.serviceOrder.serviceInstance.circuit.port.device.name}
            <c:if test="${task.status=='ACTIVE'}">
                <form action="Controller" method="POST">
                    <input type="hidden" name="task_id" value="${task.id}"/>
                    <c:if test="${task.type=='CREATE_CIRCUIT'}">
                        <input type="hidden" name="command" value="setup_circuit"/>
                        <input type="submit" value="Setup circuit"/>
                    </c:if>
                    <c:if test="${task.type=='MODIFY_CIRCUIT'}">
                        <input type="hidden" name="command" value=""/>
                        <input type="submit" value="Modify circuit"/>
                    </c:if>
                    <c:if test="${task.type=='DELETE_CIRCUIT'}">
                        <input type="hidden" name="command" value=""/>
                        <input type="submit" value="Delete circuite"/>
                    </c:if>
                </form>
            </c:if>
        </div>
        <div class="col-md-offset-3">
        </div>
    </div>
</div>

<jsp:include page="../generic/footer.jsp" flush="true"/>

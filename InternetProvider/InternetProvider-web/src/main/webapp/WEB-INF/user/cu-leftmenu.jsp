<%-- 
    Document   : leftmenu
    Created on : 29.04.2014, 17:39:08
    Author     : oneplayer
--%>

<div class="col-md-3 leftmenu">
    <!-- Left column -->

    <ul id="myTab" class="nav nav-pills nav-stacked">
        <script src="js/bootstrap-tab.js"></script>
        <script type="text/javascript">
            $('#myTab a').click(function(e) {
                e.preventDefault();
                $(this).tab('show');
            });
        </script>
        <li class="nav-header"></li>
        <li class="active"><a href="#" data-toggle="pill"><i class="glyphicon glyphicon-list"></i> Profile</a></li>
        <li class="active"><a href="Controller?command=cu_orders"><i class="glyphicon glyphicon-list"></i> Orders</a></li>
    </ul>

    <hr>
</div>

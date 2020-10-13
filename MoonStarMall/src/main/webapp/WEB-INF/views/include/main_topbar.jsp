<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="/">PROJECT</a>
            <div class="nav-collapse">
                <ul id="menu" class="nav">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Contanct</a></li>
                </ul>
            </div><!-- /.nav-collapse -->
            <ul class="nav pull-right"> <!-- user-menu dropdown --> 
                <li class="dropdown" id="user-menu">
                    <a href="#user-menu" class="dropdown-toggle" data-toggle="dropdown">
                        <i style="opacity: 0.40;" class="icon-user icon-white">&nbsp;</i>&nbsp;Anonymous
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li data-name="user-activity"><a href="#">Preferences</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Logout</a></li>
                    </ul>
                </li>
            </ul> <!-- /user-menu dropdown --> 
        </div>
    </div><!-- /navbar-inner -->
</div>
<div class="span10">
    <div class="well"><h1>Sample content</h1></div>
</div>
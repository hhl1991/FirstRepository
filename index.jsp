<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "0");
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/font-awesome.min.css">
<script src="<%=path%>/js/laydate.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datetimepicker/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/js/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css"
	href="<%=path%>/js/bootstrap/css/bootstrap-select.css" />
<script type="text/javascript"
	src="<%=path%>/js/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/bootstrap/js/bootstrap-select.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/bootstrap/js/bootstrap-treeview.min.js"></script>
<!-- 引入EasyUI -->
<link id="easyuiTheme" rel="stylesheet"
	href="resources/easyui/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css"
	type="text/css"></link>
<link rel="stylesheet" type="text/css"
	href="resources/easyui/themes/icon.css"></link>
<link rel="stylesheet" type="text/css" href="resources/common.css"></link>
<script type="text/javascript"
	src="resources/easyui/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript"
	src="resources/easyui/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript"
	src="resources/init.js" charset="utf-8"></script>


<script type="text/javascript" src="./dwr/engine.js"></script>
<script type="text/javascript" src="./dwr/util.js"></script>
<script type="text/javascript" src="./dwr/interface/Message.js"></script>


<style type="text/css">
#main-nav {
            margin-left: 1px;
        }
 
            #main-nav.nav-tabs.nav-stacked > li > a {
                padding: 10px 8px;
                font-size: 12px;
                font-weight: 600;
                color: #4A515B;
                background: #E9E9E9;
                background: -moz-linear-gradient(top, #FAFAFA 0%, #E9E9E9 100%);
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FAFAFA), color-stop(100%,#E9E9E9));
                background: -webkit-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                background: -o-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                background: -ms-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                background: linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9');
                -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9')";
                border: 1px solid #D5D5D5;
                border-radius: 4px;
            }
 
                #main-nav.nav-tabs.nav-stacked > li > a > span {
                    color: #4A515B;
                }
 
                #main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover {
                    color: #FFF;
                    background: #3C4049;
                    background: -moz-linear-gradient(top, #4A515B 0%, #3C4049 100%);
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#4A515B), color-stop(100%,#3C4049));
                    background: -webkit-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: -o-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: -ms-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049');
                    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049')";
                    border-color: #2B2E33;
                }
 
                    #main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover > span {
                        color: #FFF;
                    }
 
            #main-nav.nav-tabs.nav-stacked > li {
                margin-bottom: 4px;
            }
 
        /*定义二级菜单样式*/
        .secondmenu a {
            font-size: 10px;
            color: #4A515B;
            text-align: center;
        }
 
        .navbar-static-top {
            background-color: #212121;
            margin-bottom: 5px;
        }
 
        .navbar-brand {
            background: url('') no-repeat 10px 8px;
            display: inline-block;
            vertical-align: middle;
            padding-left: 50px;
            color: #fff;
        }
</style>

</head>

<body>



<div class="navbar navbar-duomi navbar-static-top" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#" id="logo">系统异常监控
                </a>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
                <ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
                    <li id="ttli">
                        <a onclick="showtt()">
                            <i class="glyphicon"></i>
                            首页         
                        </a>
                    </li>
                    <li id="ttlogli">
                        <a onclick="showttlog()">
                            <i class="glyphicon"></i>
                          错误日志        
                        </a>
                    </li>
                </ul>
            </div>
            <div class="col-md-10">
	  <!--  手工补采 -->
	  <div id="ttdiv">
	    <div>
		开始时间：<input style="height: 34px; padding: 6px 12px; font-size: 14px; line-height: 1.42857143; color: #555; background-color: #fff; background-image: none; border: 1px solid #ccc; border-radius: 4px; -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s; -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s; transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;"
				id="startdate" name="startdate" class="laydate-icon"
				onClick="laydate({elem: '#startdate',istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"
				readonly /> 结束时间：<input	style="height: 34px; padding: 6px 12px; font-size: 14px; line-height: 1.42857143; color: #555; background-color: #fff; background-image: none; border: 1px solid #ccc; border-radius: 4px; -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s; -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s; transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;"
				size="16" type="text" id="enddate" name="enddate"
				class="laydate-icon"
				onClick="laydate({elem: '#enddate',istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"
				readonly />
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 使用存储过程:<input type="checkbox" id="ifpro" />
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<button type="button" class="btn" onclick="tableOnclick()">提交</button>
				<label id="msg"></label>
		</div>
		<div>
			<table id="tt" nowrap="false" style="table-layout: fixed;"></table>
		</div>
	</div>
	<!-- 手动结束 -->

	<!-- 日志 -->
	<div style="display: none;" id="ttlogdiv">
		<div>
		日期：<input
			style="height: 34px; padding: 6px 12px; font-size: 14px; line-height: 1.42857143; color: #555; background-color: #fff; background-image: none; border: 1px solid #ccc; border-radius: 4px; -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s; -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s; transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;"
		    id="logdate" name="logdate" class="laydate-icon"
			onClick="laydate({elem: '#logdate',istime: true, format: 'YYYY-MM-DD',choose:function(datas){getOperationTime(datas)}})"
			readonly onchange="loadLog()"/>
			运营时间：
		   <select id="selectpicker1" ></select>
		   <input type="checkbox" id="showonlyerror">&nbsp&nbsp只显示异常
		   <input type="checkbox" id="showallerror">&nbsp&nbsp显示全部异常
		   &nbsp&nbsp&nbsp&nbsp<input type="button" value="查询" onclick="initlogtreegrid()">
		</div>
		<div>	
		   <table id="ttlog" nowrap="false" style="table-layout: fixed;"></table>
		</div>
   </div>
  <!-- 日志结束 -->
  
  
            </div>
        </div>
    </div>
</body>
</html>
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
<script src="<%=path%>/js/calendar.js"></script>
<script src="<%=path%>/js/laydate.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datetimepicker/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datetimepicker/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/js/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/js/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript"
	src="<%=path%>/js/bootstrap/js/bootstrap.min.js"></script>
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



<script type="text/javascript" src="./dwr/engine.js"></script>
<script type="text/javascript" src="./dwr/util.js"></script>
<script type="text/javascript" src="./dwr/interface/Message.js"></script>
<script type="text/javascript">
	$(function() {
		dwr.engine.setActiveReverseAjax(true);
		dwr.engine.setNotifyServerOnPageUnload(true);
		$('#tt').treegrid({
			url : 'gdupWeb/initTable.do',
			treeField : 'specName',
			idField : 'specId',
			animate : "true",
			rownumbers : "true",
			singleSelect : false,
			allowCellEdit : true,
			showCheckBox : true,
			checkRecursive : false,
			onlyLeafCheck : true,
			columns : [ [ {
				field : 'specId',
				title : '',
				width : 20,
				align : 'center',
				checkbox : true
			},//,formatter:formatcheckbox
			{
				field : 'specName',
				title : 'SPECNAME',
				width : 280,
				align : 'left'
			}, {
				field : 'prcSituation',
				title : 'ERSituation',
				width : 180,
				formatter : function(value, rowData, rowIndex) {
					return " " + rowData.prcSituation;
				}
			}, {
				field : 'sparkSituation',
				title : 'KVSituation',
				width : 180,
				formatter : function(value, rowData, rowIndex) {
					return " " + rowData.sparkSituation;
				}
			}, {
				field : 'prcTaskCause',
				title : 'ERTaskCause',
				width : 431,
				formatter : function(value, rowData, rowIndex) {
					return "" + rowData.prcTaskCause;
				}
			}, {
				field : 'sparkTaskCause',
				title : 'KVTaskCause',
				width : 431,
				formatter : function(value, rowData, rowIndex) {
					return "" + rowData.sparkTaskCause;
				}
			}, ] ],
			onLoadSuccess : function(row) {
				initTable();
			},
			onClickRow : function(row) {
				/*  				var temp = false;
				 				var tempId = row.specId;
				 				var rows = $("#tt").treegrid('getSelections');
				 				for (var i = 0; i < rows.length; i++) {
									var rowTemp = rows[i];
									if (tempId == rowTemp.specId) {
										temp = true;
									}
								}
								if (temp) {
									$("#check_"+row.specId).prop("checked",true);
								}else{
									$("#check_"+row.specId).removeAttr("checked");
								} */
			}
		});

		function init(tree) {
			var $checkableTree = $('#treeview-checkable').treeview(
					{
						data : tree,
						showIcon : false,
						showCheckbox : true,
						showTags : true,
						bootstrap2 : false,
						levels : 5,
						onNodeChecked : function(event, node) {
							$('#checkable-output').prepend(
									'<p>' + node.text + ' was checked</p>');
						},
						onNodeUnchecked : function(event, node) {
							$('#checkable-output').prepend(
									'<p>' + node.text + ' was unchecked</p>');
						}
					});

			var findCheckableNodess = function() {
				return $checkableTree.treeview('search', [
						$('#input-check-node').val(), {
							ignoreCase : false,
							exactMatch : false
						} ]);
			};
			var checkableNodes = findCheckableNodess();

			// Check/uncheck/toggle nodes
			$('#input-check-node').on(
					'keyup',
					function(e) {
						checkableNodes = findCheckableNodess();
						$('.check-node').prop('disabled',
								!(checkableNodes.length >= 1));
					});

			$('#btn-check-node.check-node').on('click', function(e) {
				$checkableTree.treeview('checkNode', [ checkableNodes, {
					silent : $('#chk-check-silent').is(':checked')
				} ]);
			});

			$('#btn-uncheck-node.check-node').on('click', function(e) {
				$checkableTree.treeview('uncheckNode', [ checkableNodes, {
					silent : $('#chk-check-silent').is(':checked')
				} ]);
			});

			$('#btn-toggle-checked').on('click', function(e) {
				var allNode = $checkableTree.treeview('getEnabled', 0);
				$checkableTree.treeview('toggleNodeChecked', [ allNode, {
					silent : $('#chk-check-silent').is(':checked')
				} ]);
			});

			// Check/uncheck all
			$('#btn-check-all').on('click', function(e) {
				$checkableTree.treeview('checkAll', {
					silent : $('#chk-check-silent').is(':checked')
				});
			});

			$('#btn-uncheck-all').on('click', function(e) {
				$checkableTree.treeview('uncheckAll', {
					silent : $('#chk-check-silent').is(':checked')
				});
			});
		}

		var tree;
		/* $.ajax({
			  type:'post',
			  url:'gdupWeb/init.do',
			  success:function(data){
			      init(data);
			      
			  }
		   }); */

	});

	var intID;//定时器ID 
	function submit() {
		$("#msg").html("");
		var arr = new Array();
		var $tree = $('#treeview-checkable');
		arr = $tree.treeview('getChecked', 0);
		var fristArr = new Array();
		var secondArr = new Array();
		var thirdArr = new Array();
		var fourthArr = new Array();
		if (arr.length == 0) {
			alert("请选择节点");
			return;
		}
		for (var i = 0; i < arr.length; i++) {
			var node = arr[i];
			var temp = $('#treeview-checkable')
					.treeview('getNode', node.nodeId);
			var href = node.href;
			if (href.indexOf("root") > -1) {
				var v = 2;
				continue;
			} else {
				if (typeof (node.parentId) == "undefined") {
					fristArr.push(href);
				} else {
					if (typeof (($tree.treeview('getNode', node.parentId)).parentId) == "undefined") {
						secondArr.push(href);
					} else if (typeof ($tree.treeview('getNode', ($tree
							.treeview('getNode', node.parentId)).parentId).parentId) == "undefined") {
						thirdArr.push(href);
					} else {
						fourthArr.push(href);
					}
				}
			}
		}
		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val()
		if (startdate == "") {
			alert("请选择开始时间");
			return;
		}
		if (enddate == "") {
			alert("请选择结束时间");
			return;
		}
		var ifpro = "0";
		if ($('#ifpro').is(':checked')) {
			ifpro = "1";
		}
		$.ajax({
			type : 'post',
			traditional : true,
			url : 'gdupWeb/runtask.do',
			data : {
				firstSpecIDs : fristArr,
				secondSpecIDs : secondArr,
				thirdSpecIDs : thirdArr,
				fourthSpecIDs : fourthArr,
				startdate : startdate,
				enddate : enddate,
				ifPro : ifpro
			},
			success : function(data) {
				if (data == "1") {
					//clearInterval(intID);
				}
			}
		});
	}

	function getMsg() {
		$.get('gdupWeb/getMsg.do', function(data) {
			$("#msg").text(data);
		});
	}
	function onPageLoad() {
		directController.onPageLoad("568839130");
	}
	function showMessage(autoMessage) {
		$("#msg").append(autoMessage);
	}

	function getDate(message) {
		// message 是后台处理完成返回的数据
		if (message != null && message != "" && message != "任务开始"
				&& message != "全部存储过程执行完毕" && message != "任务结束"
				&& message != "全部的spark服务执行完毕") {
			if (message.indexOf("开始执行存储过程") > 0) {
				var node = $('#tt').treegrid('find', message.split(",")[0]);
				node.prcSituation = "执行中";
				$('#tt').treegrid('update', {
					id : node.specId,
					row : node
				});
				$("#check_" + node.specId).prop("checked", true);
			} else if (message.indexOf("存储过程执行完成") > 0) {
				var node = $('#tt').treegrid('find', message.split(",")[0]);
				node.prcSituation = "完成";
				node.sparkSituation = "未开始";
				node.prcTaskCause = "";
				node.sparkTaskCause = "";
				$('#tt').treegrid('update', {
					id : node.specId,
					row : node
				});
				$("#check_" + node.specId).prop("checked", true);
			} else if (message.indexOf("存储过程执行出错") > 0) {
				var node = $('#tt').treegrid('find', message.split(",")[0]);
				node.prcSituation = "出错";
				node.sparkSituation = "不执行";
				node.prcTaskCause = message.split(",")[2];
				$('#tt').treegrid('update', {
					id : node.specId,
					row : node
				});
				$("#check_" + node.specId).prop("checked", true);
			} else if (message.indexOf("spark服务开启") > 0) {
				var node = $('#tt').treegrid('find', message.split(",")[0]);
				node.sparkSituation = "执行中";
				node.prcTaskCause = "";
				node.sparkTaskCause = "";
				$('#tt').treegrid('update', {
					id : node.specId,
					row : node
				});
				$("#check_" + node.specId).prop("checked", true);
			} else if (message.indexOf("spark服务成功") > 0) {
				var node = $('#tt').treegrid('find', message.split(",")[0]);
				node.sparkSituation = "执行成功";
				node.prcTaskCause = "";
				node.sparkTaskCause = "";
				$('#tt').treegrid('update', {
					id : node.specId,
					row : node
				});
				$("#check_" + node.specId).prop("checked", true);
			} else if (message.indexOf("spark出错") > 0) {
				var node = $('#tt').treegrid('find', message.split(",")[0]);
				node.sparkSituation = "执行出错";
				node.sparkTaskCause = message.split(",")[2];
				$('#tt').treegrid('update', {
					id : node.specId,
					row : node
				});
				$("#check_" + node.specId).prop("checked", true);
			} else if (message.indexOf("spark服务将不执行") > 0) {
				var node = $('#tt').treegrid('find', message.split(",")[0]);
				node.sparkSituation = "不执行";
				$('#tt').treegrid('update', {
					id : node.specId,
					row : node
				});
				$("#check_" + node.specId).prop("checked", true);
			}
		} else if (message == "任务开始") {
			alert(message);
			//$("#msg").append(message);  
		} else if (message.indexOf("全部存储过程执行完毕") > 0) {

		} else if (message == "任务结束") {
			alert(message);
		} else if (message.indexOf("全部spark服务执行完毕") > 0) {

		}
		initTable();

	}

	function initTable() {
		$(".tree-icon,.tree-file").removeClass("tree-icon tree-file");
		$(".tree-icon,.tree-folder").removeClass(
				"tree-icon tree-folder tree-folder-open tree-folder-closed");
	}
	//获取选中的结点
	function getSelected() {
		var idList = "";
		$("input:checked").each(function() {
			var id = $(this).attr("id");

			if (id.indexOf('check_type') == -1 && id.indexOf("check_") > -1)
				idList += id.replace("check_", '') + ',';

		})
		alert(idList);
	}

	function formatcheckbox(val, row) {
		return "<input type='checkbox' onclick=show('" + row.specId
				+ "') id='check_" + row.specId + "' "
				+ (row.checked ? 'checked' : '') + "/>";
	}
	function tableOnclick() {
		$("#msg").html("");
		var fristArr = new Array();
		var secondArr = new Array();
		var thirdArr = new Array();
		var fourthArr = new Array();
		var rows = $("#tt").treegrid('getSelections');
		$('#tt').treegrid('reload');
		if (rows.length == 0) {
			alert("请选择节点");
			return;
		}
		for (var i = 0; i < rows.length; i++) {
			var id = rows[i].specId;
			var node = $('#tt').treegrid('getParent', rows[i].specId);//dependSpecId
			if (node == null) {
				fristArr.push(rows[i].specId);
			} else {
				if (node.dependSpecId == "") {
					secondArr.push(rows[i].specId);
				} else {
					if (($('#tt').treegrid('getParent', node.specId)).dependSpecId == "") {
						thirdArr.push(rows[i].specId);
					} else {
						fourthArr.push(rows[i].specId);
					}
				}
			}
			$("#check_" + id).prop("checked", true);
		}

		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val()
		if (startdate == "") {
			alert("请选择开始时间");
			return;
		}
		if (enddate == "") {
			alert("请选择结束时间");
			return;
		}
		var ifpro = "0";
		if ($('#ifpro').is(':checked')) {
			ifpro = "1";
		}
		$.ajax({
			type : 'post',
			traditional : true,
			url : 'gdupWeb/runtask.do',
			data : {
				firstSpecIDs : fristArr,
				secondSpecIDs : secondArr,
				thirdSpecIDs : thirdArr,
				fourthSpecIDs : fourthArr,
				startdate : startdate,
				enddate : enddate,
				ifPro : ifpro
			},
			success : function(data) {
				if (data == "1") {
				}
			}
		});

	}
	function show(checkid) {
		var obj = $('#check_' + checkid).is(':checked');
		if (obj) {
			$('#tt').treegrid('unselect', checkid);
		} else {
			$('#tt').treegrid('select', checkid);
		}
	}
</script>
</head>
<body>
	<!-- 	<div style="width: 30%;float: left;overflow-y:scroll;height:670px">
	<input id="btn-check-all" type="button" value="全选"/>
	<input id="btn-uncheck-all" type="button" value="全不选"/>
	<input id="btn-toggle-checked" type="button" value="反选"/>
	<div id="treeview-checkable"></div>
	</div> -->
	<!-- 	<div class="container-fluid" style="float: left;width: 25%">
	<div class="row-fluid">
	<div class="span12">
		<div class="control-group" style="width: 20%">
			<div class="controls">
			    <div class="controls">
					<label class="control-label" for="startdate">开始时间：</label>
				    <input style="display: block;
  			height: 34px;padding: 6px 12px;font-size: 14px;line-height: 1.42857143;color: #555;
  			background-color: #fff;background-image: none;border: 1px solid #ccc;border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  			-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  			transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;" id="startdate" name="startdate" class="laydate-icon" onClick="laydate({elem: '#startdate',istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"   readonly>
				</div>
			</div>
		<div class="controls">
		<label class="control-label" for="enddate">结束时间：</label>
    		<input style="display: block;
  			height: 34px;padding: 6px 12px;font-size: 14px;line-height: 1.42857143;color: #555;
  			background-color: #fff;background-image: none;border: 1px solid #ccc;border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  			-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  			transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;" size="16" type="text" id="enddate" name="enddate" class="laydate-icon" onClick="laydate({elem: '#enddate',istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" readonly>
		</div>
				</div>
				<div class="control-group" style="width: 60%" >
					<div class="controls">
						 <label class="checkbox"><input type="checkbox" id="ifpro"/> 使用存储过程</label> <button type="button"  class="btn" onclick="tableOnclick()">提交</button><br>
						 <label class="checkbox"><input type="checkbox" id="ifpro"/> 使用存储过程</label> <button type="button"  class="btn" onclick="submit()">提交</button>
						<label id="msg"></label>
					</div>
				</div>
			</div>
		</div>

</div> -->
	<div>

		开始时间：<input
			style="height: 34px; padding: 6px 12px; font-size: 14px; line-height: 1.42857143; color: #555; background-color: #fff; background-image: none; border: 1px solid #ccc; border-radius: 4px; -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s; -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s; transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;"
			id="startdate" name="startdate" class="laydate-icon"
			onClick="laydate({elem: '#startdate',istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"
			readonly /> 结束时间：<input
			style="height: 34px; padding: 6px 12px; font-size: 14px; line-height: 1.42857143; color: #555; background-color: #fff; background-image: none; border: 1px solid #ccc; border-radius: 4px; -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075); -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s; -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s; transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;"
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
</body>
</html>
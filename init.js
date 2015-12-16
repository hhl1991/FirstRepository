$(function() {
	dwr.engine.setActiveReverseAjax(true);
	dwr.engine.setNotifyServerOnPageUnload(true);
	inittreegrid();
	$("#showallerror").click(function(){  
        if($('#showallerror').is(':checked')){  
            $("#showonlyerror").attr("disabled",true);  
            $("#selectpicker1").attr("disabled",true);  
        }else{  
            $("#showonlyerror").removeAttr("disabled");  
            $("#selectpicker1").removeAttr("disabled");  
        }  
    })  
});

function inittreegrid() {
	var temp = 0;
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
		}, {
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
			return temp = 1;
		}
	});
}

function getDate(message) {
	// message 是后台处理完成返回的数据
	if (message != null && message != "" && message != "TaskBegin"
			&& message != "AllProFinish" && message != "TaskFinish"
			&& message != "AllSparkFinish") {
		if (message.indexOf("proBegin") > 0) {
			var node = $('#tt').treegrid('find', message.split(",")[0]);
			node.prcSituation = "执行中";
			$('#tt').treegrid('update', {
				id : node.specId,
				row : node
			});
			$("#check_" + node.specId).prop("checked", true);
		} else if (message.indexOf("proSuccess") > 0) {
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
		} else if (message.indexOf("proError") > 0) {
			var node = $('#tt').treegrid('find', message.split(",")[0]);
			node.prcSituation = "出错";
			node.sparkSituation = "不执行";
			node.prcTaskCause = message.split(",")[2];
			$('#tt').treegrid('update', {
				id : node.specId,
				row : node
			});
			$("#check_" + node.specId).prop("checked", true);
		} else if (message.indexOf("sparkBegin") > 0) {
			var node = $('#tt').treegrid('find', message.split(",")[0]);
			node.sparkSituation = "执行中";
			node.prcTaskCause = "";
			node.sparkTaskCause = "";
			$('#tt').treegrid('update', {
				id : node.specId,
				row : node
			});
			$("#check_" + node.specId).prop("checked", true);
		} else if (message.indexOf("sparkSuccess") > 0) {
			var node = $('#tt').treegrid('find', message.split(",")[0]);
			node.sparkSituation = "执行成功";
			node.prcTaskCause = "";
			node.sparkTaskCause = "";
			$('#tt').treegrid('update', {
				id : node.specId,
				row : node
			});
			$("#check_" + node.specId).prop("checked", true);
		} else if (message.indexOf("sparkError") > 0) {
			var node = $('#tt').treegrid('find', message.split(",")[0]);
			node.sparkSituation = "执行出错";
			node.sparkTaskCause = message.split(",")[2];
			$('#tt').treegrid('update', {
				id : node.specId,
				row : node
			});
			$("#check_" + node.specId).prop("checked", true);
		} else if (message.indexOf("sparkNotRun") > 0) {
			var node = $('#tt').treegrid('find', message.split(",")[0]);
			node.sparkSituation = "不执行";
			$('#tt').treegrid('update', {
				id : node.specId,
				row : node
			});
			$("#check_" + node.specId).prop("checked", true);
		}
	} else if (message == "TaskBegin") {
		alert("任务开始");
		// $("#msg").append(message);
	} else if (message.indexOf("AllProFinish") > 0) {

	} else if (message == "TaskFinish") {
		alert("任务结束");
	} else if (message.indexOf("AllSparkFinish") > 0) {

	}
	initTable();

}

function initTable() {
	$(".tree-icon,.tree-file").removeClass("tree-icon tree-file");
	$(".tree-icon,.tree-folder").removeClass(
			"tree-icon tree-folder tree-folder-open tree-folder-closed");
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
	if (rows.length == 0) {
		alert("请选择节点");
		return;
	}
	inittreegrid();
	for (var i = 0; i < rows.length; i++) {
		var id = rows[i].specId;
		var node = $('#tt').treegrid('getParent', rows[i].specId);// dependSpecId
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


function initlogtreegrid() {
	
	var data = $("#logdate").val();
	var time = $("#selectpicker1").val();
	
	var showonlyerror = "0";
	if ($('#showonlyerror').is(':checked')) {
		showonlyerror = "1";
	} 
	var showallerror = "0";
	if ($('#showallerror').is(':checked')) {
		showallerror = "1"
	}
	//alert(data+","+time+","+showonlyerror+","+showallerror);
	$('#ttlog').treegrid({
		url : 'gdupWeb/getLog.do?data='+data+'&time='+time+'&showonlyerror='+showonlyerror+'&showallerror='+showallerror,
		//url : 'gdupWeb/getLog.do',
		treeField : 'LOGID', 
		idField : 'LOGID', 
		animate : "true",
		rownumbers : "true",
		singleSelect : false,
		pagination:true,
		pageSize : 20,
		pageList : [20, 30, 40],
		columns : [ [ {
			field : 'LOGTYPE',
			title : '日志类型',
			width : 50,
			align : 'center',
			formatter : function(value, rowData, rowIndex) {
				if (rowData.LOGTYPE==1) {
					return "手工"; 
				} else if(rowData.LOGTYPE==0) {
					return "自动" ;
				}else{
					
				}
			}
		}, {
			field : 'TABLEDESC',
			title : '表名',
			width : 280,
			align : 'left'
		}, {
			field : 'DATABGTIME',
			title : '数据开始时间',
			width : 180
		}, {
			field : 'DATAENDTIME',
			title : '数据结束时间',
			width : 180
		}, {
			field : 'ERBGTIME',
			title : 'ER层执行开始时间',
			width : 180
		}, {
			field : 'ERENDTIME',
			title : 'ER层执行开始时间',
			width : 180
		},{
			field : 'KVBGTIME',
			title : 'KV层执行开始时间',
			width : 180
		},{
			field : 'KVENDTIME',
			title : 'KV层执行结束时间',
			width : 180
		},{
			field : 'LOG',
			title : '日志',
			width : 431
		}] ],
		onLoadSuccess : function(row) {
			initTable();
		}
	});
}
function getOperationTime(datas){
	//alert(datas);
	$.ajax({
		type : 'post',
		traditional : true,
		url : 'gdupWeb/getoperationtime.do',
		data : {
			data : datas
		},
		success : function(date) {
			$("#selectpicker1").html(date);
		}
	});
}

function showtt(){
	$("#ttdiv").show();
	$("#ttlogdiv").hide();
	$("#ttli").attr("class","active");
	$("#ttlogli").removeAttr("class","active");
}

function showttlog(){
	$("#ttdiv").hide();
	$("#ttlogdiv").show();
	$("#ttli").removeAttr("class","active");
	$("#ttlogli").attr("class","active");
}

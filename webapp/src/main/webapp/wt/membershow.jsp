
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String path = request.getContextPath(); %>
<html>
<head>
    <title>Insert title here</title>
</head>
<body>
<%--引入easyui的js文件begin--%>
<link href="<%=path %>/js/easyui_full.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/js/iconfont/iconfont.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/js/theme.default/master.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/js/js/reset.min.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/js/icon.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path %>/js/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/iconfont/iconfont.js"></script>
<script type="text/javascript" src="<%=path %>/js/js/jquery.easyui-1.5.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/js/insdep-extend.min.js"></script>
<%--end--%>
<table id="wtcheckee" border="1" bgcolor="#0099ff"></table>
<div id="wtcheckaa">
    <a href="javascript:addOrEdit('add')" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
    <a href="javascript:addOrEdit('edit')" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
    <a href="javascript:delll(null)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
</div>
<div id="dd"></div>
<script type="text/javascript">
    $(function () {
        membershow();
    })
    function membershow() {
        //查询会员方法
        $('#wtcheckee').datagrid({
            url:'<%=path%>/wt/queryMember',
            columns:[[
                {field:'',title:'',checkbox:true},
                {field:'memberid',title:'主键Id',width:52 },
                {field:'membernum',title:'会员帐号',width:52 },
                {field:'membername',title:'会员姓名',width:52 },
                {field:'memberdj',title:'会员等级',width:52 },
                {field:'memberjf',title:'会员积分 ',width:52 },
                {field:'memberflag',title:'会员状态',width:'5%',formatter:function(value,row,index){
                    if(value==1){
                        return "正常";
                    }else{
                        return "锁定";
                    }
                }},
                {field:'memberdate',title:'创建日期',width:52 },
                {field:'membersex',title:'会员性别',width:'5%',formatter:function(value,row,index){
                    if(value==1){
                        return "男";
                    }else{
                        return "女";
                    }
                }},
                {field:'memberphone',title:'手机号 ',width:52 },
                {field:'memberidcard',title:'身份证号 ',width:52 }
            ]],
            //分页
            fit:true,
            //fitColumns:true,
            striped:true,
            pagination:true,
            //singleSelect:true,
            ctrlSelect:true,
            pageList:[5,10,15,20],
            toolbar:'#wtcheckaa',

        });
    }

</script>
<script type="text/javascript">
    function delll(){
        var ids="";
        //获取所有被选中的行
        var arr = $("#wtcheckee").datagrid("getSelections");
        for (var i = 0; i < arr.length; i++) {
            ids+=","+arr[i].memberid;
        }
        ids = ids.substr(1);
        $.ajax({
            url:"<%=request.getContextPath()%>/wt/delMember",
            type:"post",
            data:{"ids":ids},
            dataType:"json",
            async:false,
            success:function(data){

                if(data.success){
                    $.messager.alert("提示","删除成功！");
                    membershow();
                }else{
                    $.messager.alert("警告","删除失败！");
                }
            }
        })
    }
</script>
<script type="text/javascript">
    function addOrEdit(ii){
        var title="";
        var href ="";
        if(ii=="edit"){
            title="修改会员信息";

            var arr = $("#wtcheckee").datagrid("getSelections");
            if(arr.length!=1){
                $.messager.alert("警告","请选择一行数据进行修改！");
                return;
            }else{
                href="<%=path%>/wt/toUpdateMember?id="+arr[0].memberid;
            }
        }else if(ii=="add"){
            title="新增会员信息";
            href="/wt/addMember.jsp";
        }
        $('#dd').dialog({
            title: title,
            width: 400,
            height: 400,
            closed: false,
            cache: false,
            href: href,
            modal: true,
            buttons:[{
                text:'保存',
                handler:function(){
                    $("#data").form('submit',{
                        url:"<%=path%>/wt/addMember",
                        onSubmit:function(){
                            var isValid = $(this).form('validate');
                            if(!isValid){
                                $.messager.alert("提示",'输入有误！请检查输入！');
                                return false;
                            }
                        },
                        success:function(data){
                            var data = eval('(' + data + ')');
                            if(data.success){
                                $.messager.alert("提示",data.msg);
                                $('#dd').dialog('close');
                                $('#wtcheckee').datagrid('load');
                            }else{
                                $.messager.alert("提示",data.msg);
                            }
                        }
                    });
                }
            }]


        });
    }

</script>
</body>
</html>

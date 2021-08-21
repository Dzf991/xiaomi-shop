<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@ page import="com.xiaomi.pojo.ProductType" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<ProductType> productTypeList = (List<ProductType>) application.getAttribute("productType");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <title></title>
</head>
<script type="text/javascript">

    $().ready(function () {
        if ("${param.get("pageNo")}" === ""){
            pageList(1);
        }else {
            pageList(${param.get("pageNo")});
        }



    })
    function allClick() {
        //取得全选复选框的选中未选 中状态
        var ischeck=$("#all").prop("checked");
        //将此状态赋值给每个商品列表里的复选框
        $("input[name=ck]").each(function () {
            this.checked=ischeck;
        });
    }

    function ckClick() {
        //取得所有name=ck的被选中的复选框
        var length=$("input[name=ck]:checked").length;
//取得所有name=ck的复选框
        var len=$("input[name=ck]").length;
        //比较
        if(len == length){
            $("#all").prop("checked",true);
        }else
        {
            $("#all").prop("checked",false);
        }
    }

    /**
     * 分页查询
     * @param pageNo 第几页
     * @param pageSzie 页面显示多少数据
     */
    function pageList(pageNo) {
        
        $.ajax({

            url: "product/pageList",
            type: "get",
            data: {
                "pageNo":pageNo,
                "pName":$("#pname").val().trim(),
                "typeId":$("#typeid").val().trim(),
                "lprice":$("#lprice").val().trim(),
                "hprice":$("#hprice").val().trim(),
            },
            dataType: "json",
            success:function (resp) {
                $("#productList").empty();
                $("#productList").append(
                    "<tr>"+
                    "<th></th>"+
                    "<th>商品名</th>"+
                    "<th>商品介绍</th>"+
                    "<th>定价（元）</th>"+
                    "<th>商品图片</th>"+
                    "<th>商品数量</th>"+
                    "<th>操作</th>"+
                    "</tr>")
                if (resp.pageCount === 0){
                    $("#productList").append(
                        "<div>"+
                        "<h2 style='width:1200px; text-align: center;color: orangered;margin-top: 100px'>暂时没有符合条件的商品！</h2>"+
                        "</div>"
                    )
                }else {
                    $.each(resp.pageList,function (i,p) {
                          if (resp.total !== 0){
                          $("#productList").append(
                              "<tr>"+
                              "<td valign='center' align='center'><input type='checkbox' name='ck' id='ck' value='"+p.pId+"' onclick='ckClick()'></td>"+
                              "<td>"+p.pName+"</td>"+
                              "<td>"+p.pContent+"</td>"+
                              "<td>"+p.pPrice+"</td>"+
                              "<td><img width='55px' height='45px'src='${pageContext.request.contextPath}/image_big/"+p.pImage+"'></td>"+
                              "<td>"+p.pNumber+"</td>"+
                              <%--<td><a href="${pageContext.request.contextPath}/admin/product?flag=delete&pid=${p.pId}" onclick="return confirm('确定删除吗？')">删除</a>--%>
                              <%--&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/product?flag=one&pid=${p.pId}">修改</a></td>--%>
                              "<td>"+
                              "<button type='button' id='updateBtn"+p.pId+"' class='btn btn-info' value='"+p.pId+"'>编辑</button>"+
                              "<button type='button' class='btn btn-warning' id='delBtn"+p.pId+"'>删除</button>"+
                              "</td>"+
                              "</tr>"
                          )
                        }
                        //绑定动态修改按钮
                        $("#updateBtn"+p.pId).on('click',function () {
                            location.href = "${pageContext.request.contextPath}/admin/product/goUpdate?pId="+p.pId+"&pageNo="+"${sessionScope.page.pageNo}";
                        })
                        //绑定动态删除按钮
                        $("#delBtn"+p.pId).on('click',function () {
                            if (confirm("是否要删除该商品？")){
                                delProduct(p.pId);
                                pageList("${sessionScope.page.pageNo}",5)
                                <%--location.href = "${pageContext.request.contextPath}/admin/product/delProduct?pId="+p.pId;--%>
                                <%--pageList(${sessionScope.page.pageNo},5);--%>
                            }
                        })
                    })
                }



                var element = $("#pageBtn");
                var options = {
                    bootstrapMajorVersion: 3,
                    currentPage: pageNo, // 当前页数
                    //numberOfPages: 5, // 显示按钮的数量
                    totalPages: resp.pageCount, // 总页数
                    itemTexts: function (type, page, current) {
                        switch (type) {
                            case "first":
                                return "首页";
                            case "prev":
                                return "上一页";
                            case "next":
                                return "下一页";
                            case "last":
                                return "末页";
                            case "page":
                                return page;
                        }
                    },
                    // 点击事件，用于通过Ajax来刷新整个list列表
                    onPageClicked: function (event, originalEvent, type, page) {
                        pageList(page,5);
                    }
                };
                if (resp.total !== 0) {
                    element.bootstrapPaginator(options);
                }
            }


        })




    }
    
    function delProduct(pid) {
        $.ajax({
            url: "product/delProduct",
            type: "post",
            data: {
              "pId": pid
            },
            dataType: "json",
            success: function (resp) {
                if (resp.code === 200){
                    alert("删除成功！");

                }else {
                    alert("删除失败！");
                }
            }
        })
    }

</script>
<body>
<div id="brall">
    <div id="nav">
        <p>商品管理>商品列表</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            商品名称：<input name="pName" id="pname">&nbsp;&nbsp;&nbsp;
            商品类型：<select name="typeId" id="typeid">
            <option value="">请选择</option>
            <c:forEach items="${applicationScope.get('productType')}" var="pt">
<%--            <%--%>
//                for (ProductType productType: productTypeList) {

<%--                    %>--%>
<%--            <option value="<%=productType.getTypeId()%>"><%=productType.getTypeName()%></option>--%>
                <option value="${pt.typeId}">${pt.typeName}</option>
                <%--                    <%--%>
                }
<%--            %>--%>
<%--&lt;%&ndash;--%>
            </c:forEach>
        </select>&nbsp;&nbsp;&nbsp;
            价格：<input name="lprice" id="lprice">-<input name="hprice" id="hprice">
            <input type="button" value="查询" onclick="pageList(1,5)">
        </form>
    </div>
    <br>
    <div id="table">



                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">

                        <input type="button" class="btn btn-warning" id="btn1"
                               value="新增商品">
                    </a>
                    <input type="button" class="btn btn-warning" id="btn1"
                           value="批量删除" onclick="deleteBatch()">
                </div>
                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tbody id="productList">
                        </tbody>
                    </table>
                    <!--分页栏-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul id="pageBtn" class="pagination">
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
    </div>
</div>
</body>

<script type="text/javascript">

    function mysubmit() {
        $("#myform").submit();
    }

    //批量删除
    function deleteBatch() {

            //取得所有被选中删除商品的pid
            var products=$("input[name=ck]:checked");
            var str="";
            var ids=[];
            if(products.length===0){
                alert("请选择将要删除的商品！");
            }else{
                // 有选中的商品，则取出每个选 中商品的ID，拼提交的ID的数据
                if(confirm("您确定删除"+products.length+"条商品吗？")){
                //拼接ID
                //     $.each(products,function (index,item) {
                //         id=$(item).val(); //22 33
                //         alert(id);
                //         if(id!=null)
                //             str += id+",";  //22,33,44
                //     });
                    for (var i = 0; i < products.length; i++) {

                        ids.push(products[i].value);



                    }
                    alert(ids);
                    //发送请求到服务器端
                    $.ajax({
                        url: "product/deleteChoice",
                        type:"post",
                        data : {
                            id:ids
                        },
                        traditional:true,
                        dataType:"json",
                        success:function (resp) {
                            if (resp.code === 200){
                                alert("删除成功！");
                                window.location="${pageContext.request.contextPath}/admin/product.jsp?pageNo=1"
                            }else {
                                alert("删除失败");
                            }
                        }
                    })

                    <%--window.location="${pageContext.request.contextPath}/admin/product/deleteChoice?id="+str;--%>

                }
        }
    }
    //单个删除
    function del(pid) {
        if (confirm("确定删除吗")) {
          //向服务器提交请求完成删除
            window.location="${pageContext.request.contextPath}/prod/delete.action?pid="+pid;
        }
    }


</script>

</html>
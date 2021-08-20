<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/js/ajaxfileupload.js"></script>
	</head>
    <script type="text/javascript">
        function fileChange(){//注意：此处不能使用jQuery中的change事件，因此仅触发一次，因此使用标签的：onchange属性

            $.ajaxFileUpload({
                url: 'product/choiceImg',//用于文件上传的服务器端请求地址
				type:"post",
                secureuri: false,//一般设置为false
				processData:false,
				contentType:false,
                fileElementId: 'pimage',//文件上传控件的id属性  <input type="file" id="pimage" name="pimage" />
                dataType: 'json',//返回值类型 一般设置为json
                success: function(resp) //服务器成功响应处理函数
                {
                    $("#imgDiv").empty();  //清空原有数据
                    //创建img 标签对象
                    var imgObj = $("<img>");
                    //给img标签对象追加属性
                    imgObj.attr("src","/xiaomishop/image_big/"+resp.imgName);
                    imgObj.attr("width","100px");
                    imgObj.attr("height","100px");
                    //将图片img标签追加到imgDiv末尾
                    $("#imgDiv").append(imgObj);
                    //将图片的名称（从服务端返回的JSON中取得）赋值给文件本框
                    $("#imgName").html(resp.imgName);
                },
                error: function (e)//服务器响应失败处理函数
                {
                    alert(e.message);
                }
            });
        }

        $().ready(function () {

        	$("#addBtn").click(function () {
				$.ajax({
					url : "product/addProduct",
					type : "post",
					data : {
						"pName" : $("#pName").val().trim(),
						"pContent" : $("#pContent").val().trim(),
						"pPrice" : $("#pPrice").val().trim(),
						"pImage" : $("#imgName").html(),
						"typeId" : $("#typeId").val(),
						"pNumber" : $("#pNumber").val().trim()
					},
					dataType: "json",
					success : function (resp) {
						if (resp.code === 200){
							alert("添加成功！");
							window.location="${pageContext.request.contextPath}/admin/product.jsp"
						}else {
							alert("添加失败");
						}
					}


				})
			})






		})

    </script>
	<body>
	<!--取出上一个页面上带来的page的值-->

		<div id="addAll">
			<div id="nav">
				<p>商品管理>新增商品</p>
			</div>

			<div id="table">
				<form enctype="multipart/form-data"
					  method="post" id="myform">
					<table>
						<tr>
							<td class="one">商品名称</td>
							<td><input id="pName" type="text" name="pName" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pnameerr"></span></td>
						</tr>
						<tr>
							<td class="one">商品介绍</td>
							<td><input id="pContent" type="text" name="pContent" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pcontenterr"></span></td>
						</tr>
						<tr>
							<td class="one">定价</td>
							<td><input id="pPrice" type="number" name="pPrice" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="priceerr"></span></td>
						</tr>
						
						<tr>
							<td class="three">图片介绍</td>
                            <td> <br><div id="imgDiv" style="display:block; width: 40px; height: 50px;"></div><br><br><br><br>
								<%--<input type="file" id="pimage" name="pimage" onchange="fileChange()">--%>
                            <input type="file" id="pimage" name="pimage" onchange="fileChange()" >
                                <span id="imgName" ></span><br>

                            </td>
						</tr>
						<tr class="three">
							<td class="four"></td>
							<td><span></span></td>
						</tr>
						
						<tr>
							<td class="one">总数量</td>
							<td><input type="number" id="pNumber" name="pNumber" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="numerr"></span></td>
						</tr>
						
						
						<tr>
							<td class="one">类别</td>
							<td>
								<select id="typeId" name="typeId">
									<c:forEach items="${applicationScope.get('productType')}" var="type">
										<option value="${type.typeId}">${type.typeName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span></span></td>
						</tr>

						<tr>
							<td>
								<input type="button" id="addBtn" value="提交" class="btn btn-success">
							</td>
							<td>
								<input type="reset" value="取消" class="btn btn-default" onclick="myclose()">
								<script type="text/javascript">
									function myclose() {
										window.location="${pageContext.request.contextPath}/admin/product.jsp;"
									}
								</script>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

	</body>

</html>
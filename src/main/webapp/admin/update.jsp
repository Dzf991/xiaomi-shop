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
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/pageList.js"></script>
	</head>

	<body>
		<div id="addAll">
			<div id="nav">
				<p>商品管理>更新商品</p>
			</div>
			<script type="text/javascript">
				function fileChange(){//注意：此处不能使用jQuery中的change事件，因此仅触发一次，因此使用标签的：onchange属性

					$.ajaxFileUpload({
						url: 'choiceImg',//用于文件上传的服务器端请求地址
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
							url : "updateProduct",
							type : "post",
							data : {
								"pId" : $("#pId").val().trim(),
								"pName" : $("#pName").val().trim(),
								"pContent" : $("#pContent").val().trim(),
								"pPrice" : $("#pPrice").val().trim(),
								"pImage" : $("#imgName").html(),
								"typeId" : $("#typeId").val(),
								"pNumber" : $("#pNumber").val().trim()
							},
							dataType : "json",
							success : function (resp) {
								if (resp.code === 200){
									alert("修改成功！");
									window.location="${pageContext.request.contextPath}/admin/product.jsp?pageNo=${sessionScope.page.pageNo}";
								}else {
									alert("修改失败！");
								}
							}
						})
					})
				})



			</script>
<script type="text/javascript">
	function myclose(ispage) {
		window.location="${pageContext.request.contextPath}/admin/product?flag=split&ispage="+ispage;
		//window.close();
	}
</script>
			<div id="table">
				<form enctype="multipart/form-data" id="myform">
					<input type="hidden" value="${product.pId}" id="pId" name="pId">
					<input type="hidden" value="${product.pImage}" name="pImage">
					<input type="hidden" value="${pageNo}" id="pageNo" name="page">
					<table>
						<tr>
							<td class="one">商品名称</td>
							<td><input type="text" id="pName" name="pName" class="two" value="${product.pName}"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pnameerr"></span></td>
						</tr>
						<tr>
							<td class="one">商品介绍</td>
							<td><input type="text" id="pContent" name="pContent" class="two" value="${product.pContent}"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pcontenterr"></span></td>
						</tr>
						<tr>
							<td class="one">定价</td>
							<td><input type="number" id="pPrice" name="pPrice" class="two" value="${product.pPrice}"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="priceerr"></span></td>
						</tr>
						
						<tr>
							<td class="one">图片介绍</td>
							<td> <br><div id="imgDiv" style="display:block; width: 40px; height: 50px;"><img src="${pageContext.request.contextPath}/image_big/${product.pImage}" width="100px" height="100px" ></div><br><br><br><br>
								<input type="file" id="pimage" name="pimage" onchange="fileChange()">
								<span id="imgName">${product.pImage}</span><br>

							</td>
						</tr>
						<tr class="three">
							<td class="four"></td>
							<td><span></span></td>
						</tr>
						
						<tr>
							<td class="one">总数量</td>
							<td><input type="number" id="pNumber" name="pNumber" class="two"  value="${product.pNumber}"></td>
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
										<option value="${type.typeId}"
												<c:if test="${type.typeId==product.typeId}">
													selected="selected"
												</c:if>
										>${type.typeName}</option>

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
								<input type="reset" value="取消" class="btn btn-default" onclick="myclose(1)">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

	</body>

</html>
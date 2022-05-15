<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%--  
    <%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.*" %>

<%
	Product po=(Product)request.getAttribute("Product");
%>
   --%>  
     
<!DOCTYPE html>
<html>
<head>
 
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>


<script type="text/javascript">
 
function fncUpdateProduct(){
	//Form 유효성 검증
	var name =	$("input[name='prodName']").val();
	var detail=	$("input[name='prodDetail']").val();
	var manuDate=$("input[name='manuDate']").val();
	var price=	$("input[name='price']").val();
	
	 console.log( "name  " +name + " , detail: "+detail + " ,manuDate: "+ manuDate +" , price : "+ price   );		      


	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
	
	
	$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit() ;
	
	 
}


$(function() {
	 $( "button:contains('취소')" ).on("click" , function() {
			
		 history.go(-1); 
	 
			 
	 });
	  
	 
});
	 $(function() {
		 
		 $( "button:contains('수정')" ).on("click" , function() {
			 
			 fncUpdateProduct();
		});
	});	
	 


</script>
</head>

<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/layout/toolbar.jsp" />
	<jsp:include page="/common/Q&A.jsp" />
	
	
	
<div class="container">
	 	<div class="page-header text-info">
	       <h3>상품 수정</h3>
	    </div>
			<form name="detailForm" class="form-horizontal" >
			
			<input type="hidden" name="prodNo" value="${Product.prodNo }"/>

			
			
			<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 상품명 </label>
		 	   <div class="col-sm-4">
		    	  <input type="text" class="form-control" id="prodName" name="prodName"  value= "${Product.prodName}"   >
	    		</div>
	    	</div>
	    	
	    	
			<div class="form-group">
	   		 <label for="text" class="col-sm-offset-1 col-sm-3 control-label"> 상품상세정보  </label>
		 	   <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail"  value= "${Product.prodDetail}">
	    		</div>
	    	</div>
			
			
	 		 <div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 제조일자  </label>
		 	   <div class="col-sm-4">
		 	     <input type="date" class="form-control" id="manuDate" name="manuDate" >
	    		</div>
	    	</div>
	    	
	    	
			<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 가격   </label>
		 	   <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price"    value= "${Product.price}">
	    		</div>
	    	
	    	
	    	
	    	</div> 
	    	
	    	<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 수량    </label>
		 	   <div class="col-sm-4">
		      <input type="text" class="form-control" id="quantity" name="quantity"   value= "${Product.quantity}" >
	    		</div>
	    	
		     </div> 
	    	
	    	<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 상품 파일    </label>
		 	   <div class="col-sm-4">
		      <input type="file" class="form-control" id="quantity" multiple="multiple" name="fileInfo"  value=   "${ Product.fileName }">
	    		</div>
	    	
		     </div> 	    	
	    	




			  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" > 수정 </button>
		      <button type="button" class="btn btn-primary" > 취소 </button>
 			  
		    </div>
		  </div>




	</form>
	
	
	
	
	
	
	
	
	
	
	
</div>











<!--  

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						<!--    <a href="javascript:fncAddProduct();">수정</a> 
						수정
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif"width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!--  <a href="javascript:history.go(-1)">취소</a>  
						취소
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
 
-->
</body>
</html>
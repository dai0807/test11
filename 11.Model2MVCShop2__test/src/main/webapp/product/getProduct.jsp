<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




    
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

	$(function(){
//		$(".ct_purchase:contains('구매')").on("click", function(){
		$("button:contains('구매')").on("click", function(){

			self.location ="/purchase/addPurchaseView?prodNo=${Product.prodNo}" ; 
		});
		
//		$(".ct_btn01:contains('이전')").on("click", function(){
		$("button:contains('이전')").on("click", function(){
	
			history.go(-1); 
		});
		
//		$(".ct_btn01:contains('목록')").on("click", function(){
		$("button:contains('목록')").on("click", function(){
	
			self.location ="/product/listProduct?menu="+$("#menu").val() ; 
		});
		
 		
 	}) ;
	
	
</script>

<meta charset="EUC-KR">
<title> 상품 상세  </title>
</head>
<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/layout/toolbar.jsp" />
		<jsp:include page="/common/Q&A.jsp" />

	<div class ="container">
		<div class = "page-header text-info">
		<h3> 상품상세</h3>
	</div>

	<table class="table table-condensed">
	  <input type="hidden" id="menu"   value="${menu}"/>
		
		<tbody>
		
		
		    <tr>
		      <th scope="row">상품명 </th>
		      <td> ${Product.prodName}</td>
		    </tr>

		    <tr>
		      <th scope="row">상품상세정보 </th>
		      <td>${Product.prodDetail}</td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">제조일자 </th>
		      <td>${Product.manuDate} </td>
		    </tr>
		    <tr>
		      <th scope="row">등록일자 </th>
		      <td>${Product.regDate} </td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">가격</th>
		      <td>${Product.price}  </td>
		    </tr>
		    
 		    <tr>
		      <th scope="row">수량 </th>
		      <td>${Product.quantity}  </td>
		    </tr>
		    		    		    		    
	  		 <tr>
		      <th scope="row">상품이미지 </th>
		      <td> <img src="/images/uploadFiles/${Product.fileName }" >  </td>
		    </tr>
	 </tbody>
		    		  	
	
	
	
	</table>
<br>  


		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		    	 <c:if test = "${userId ne 'admin'}">
 				 <c:if test = "${userId ne ''}">
				 <c:if test = "${Product.quantity ne 0}">
		
		      <button type="button" class="btn btn-primary" > 구매 </button>
		      
 				</c:if>		
 				</c:if>		
 				</c:if>
 	
 			  <button type="button" class="btn btn-primary" >이전</button>
 			  <button type="button" class="btn btn-primary" >목록</button>
			  
		    </div>
		  </div>


 
	
	</div> <!-- 화면구성  -->
 
<br> <br> <br> 

</body>
</html>
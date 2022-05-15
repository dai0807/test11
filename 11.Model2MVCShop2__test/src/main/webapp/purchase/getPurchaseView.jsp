<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%-- 사랑 하는 지안아 너에게 보낸다,   		 
   {purchase.paymentOption  eq '1  ' 할때 ,,,, db에서 CHAR하서 ,, 뒤에 빈공간 채워 지거든?
   그래서 paymentOption 를 001 ,처럼 3자리로 맞추든 , DB에서 VARCHAR로 바꾸든 노력하렴 
    --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
	
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
		$("button:contains('수정')").on("click", function(){
			self.location ="/purchase/updatePurchase?tranNo=${purchase.tranNo}" ; 
		});
		
		$("button:contains('확인')").on("click", function(){
			history.go(-1); 
		});
		
	 
		
 		
 	}) ;
	
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
 		<div class ="page-header text-info">
 			<h3> 구매 상세 조회 </h3>
 		</div>
		<table class="table table-condensed">
	
		<tbody>
		
		
		    <tr>
		      <th scope="row"> 물품번호 </th>
		      <td> ${purchase.purchaseProd.prodNo}</td>
		    </tr>

		    <tr>
		      <th scope="row"> 상품이름  </th>
		      <td>${purchase.purchaseProd.prodName}  </td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">구매자아이디 </th>
		      <td> ${buyer_id} </td>
		    </tr>
		    <tr>
		      <th scope="row"> 구매방법  </th>
		      <td>
		      <c:if test="${purchase.paymentOption  eq '1  '}">
 		 				현금구매
 				</c:if>
 				<c:if test = "${ purchase.paymentOption eq '2  '}">
					신용구매
				</c:if>
			 	</td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">구매자이름</th>
		      <td>   ${purchase.receiverName}  </td>
		    </tr>
		    
 		    <tr>
		      <th scope="row">구매자연락처 </th>
		      <td>${purchase.receiverPhone}  </td>
		    </tr>
		    		    		    		    
	  		 <tr>
		      <th scope="row"> 구매자주소 </th>
		      <td> ${purchase.dlvyAddr} </td>
		    </tr>
		    
	  		 <tr>
		      <th scope="row"> 구매요청사항 </th>
		      <td>  ${purchase.dlvyRequest}  </td>
		    </tr>		    
	  		 <tr>
		      <th scope="row"> 배송희망일 </th>
		      <td> ${purchase.dlvyDate}  </td>
		    </tr>	  		 <tr>
		      <th scope="row"> 주문일 </th>
		      <td> ${purchase.orderDate}</td>
		    </tr>	  		 <tr>
		      <th scope="row">  현재 상태  </th>
		      <td>  
				<c:if test="${purchase.tranCode eq '002'}">
					 구매완료 상태입니다. 
				 </c:if>
				  <c:if test="${purchase.tranCode eq '003'}">
			      배송 중 입니다. 
				 </c:if>
			 	 <c:if test="${purchase.tranCode eq '004'}">
						배송완료 상태입니다.
			 	 </c:if>
			 	     
		      </td>
		    </tr>		    
		    
		    
	 </tbody>
	
	
	
		</table>
		<br>
		
		
		
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		     <c:if test="${purchase.tranCode eq '002'}">
		      <button type="button" class="btn btn-primary" > 수정 </button>
 			 </c:if>
 			 
 			  <button type="button" class="btn btn-primary" >확인</button>
			  
		    </div>
		  </div>
		
		
		
		
		
	</div>
 



</body>
</html>
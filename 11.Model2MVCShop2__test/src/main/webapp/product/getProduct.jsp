<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




    
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>


	<script type="text/javascript">

	$(function(){
//		$(".ct_purchase:contains('����')").on("click", function(){
		$("button:contains('����')").on("click", function(){

			self.location ="/purchase/addPurchaseView?prodNo=${Product.prodNo}" ; 
		});
		
//		$(".ct_btn01:contains('����')").on("click", function(){
		$("button:contains('����')").on("click", function(){
	
			history.go(-1); 
		});
		
//		$(".ct_btn01:contains('���')").on("click", function(){
		$("button:contains('���')").on("click", function(){
	
			self.location ="/product/listProduct?menu="+$("#menu").val() ; 
		});
		
 		
 	}) ;
	
	
</script>

<meta charset="EUC-KR">
<title> ��ǰ ��  </title>
</head>
<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/layout/toolbar.jsp" />
		<jsp:include page="/common/Q&A.jsp" />

	<div class ="container">
		<div class = "page-header text-info">
		<h3> ��ǰ��</h3>
	</div>

	<table class="table table-condensed">
	  <input type="hidden" id="menu"   value="${menu}"/>
		
		<tbody>
		
		
		    <tr>
		      <th scope="row">��ǰ�� </th>
		      <td> ${Product.prodName}</td>
		    </tr>

		    <tr>
		      <th scope="row">��ǰ������ </th>
		      <td>${Product.prodDetail}</td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">�������� </th>
		      <td>${Product.manuDate} </td>
		    </tr>
		    <tr>
		      <th scope="row">������� </th>
		      <td>${Product.regDate} </td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">����</th>
		      <td>${Product.price}  </td>
		    </tr>
		    
 		    <tr>
		      <th scope="row">���� </th>
		      <td>${Product.quantity}  </td>
		    </tr>
		    		    		    		    
	  		 <tr>
		      <th scope="row">��ǰ�̹��� </th>
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
		
		      <button type="button" class="btn btn-primary" > ���� </button>
		      
 				</c:if>		
 				</c:if>		
 				</c:if>
 	
 			  <button type="button" class="btn btn-primary" >����</button>
 			  <button type="button" class="btn btn-primary" >���</button>
			  
		    </div>
		  </div>


 
	
	</div> <!-- ȭ�鱸��  -->
 
<br> <br> <br> 

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%-- ��� �ϴ� ���Ⱦ� �ʿ��� ������,   		 
   {purchase.paymentOption  eq '1  ' �Ҷ� ,,,, db���� CHAR�ϼ� ,, �ڿ� ����� ä�� ���ŵ�?
   �׷��� paymentOption �� 001 ,ó�� 3�ڸ��� ���ߵ� , DB���� VARCHAR�� �ٲٵ� ����Ϸ� 
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
		$("button:contains('����')").on("click", function(){
			self.location ="/purchase/updatePurchase?tranNo=${purchase.tranNo}" ; 
		});
		
		$("button:contains('Ȯ��')").on("click", function(){
			history.go(-1); 
		});
		
	 
		
 		
 	}) ;
	
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
 		<div class ="page-header text-info">
 			<h3> ���� �� ��ȸ </h3>
 		</div>
		<table class="table table-condensed">
	
		<tbody>
		
		
		    <tr>
		      <th scope="row"> ��ǰ��ȣ </th>
		      <td> ${purchase.purchaseProd.prodNo}</td>
		    </tr>

		    <tr>
		      <th scope="row"> ��ǰ�̸�  </th>
		      <td>${purchase.purchaseProd.prodName}  </td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">�����ھ��̵� </th>
		      <td> ${buyer_id} </td>
		    </tr>
		    <tr>
		      <th scope="row"> ���Ź��  </th>
		      <td>
		      <c:if test="${purchase.paymentOption  eq '1  '}">
 		 				���ݱ���
 				</c:if>
 				<c:if test = "${ purchase.paymentOption eq '2  '}">
					�ſ뱸��
				</c:if>
			 	</td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">�������̸�</th>
		      <td>   ${purchase.receiverName}  </td>
		    </tr>
		    
 		    <tr>
		      <th scope="row">�����ڿ���ó </th>
		      <td>${purchase.receiverPhone}  </td>
		    </tr>
		    		    		    		    
	  		 <tr>
		      <th scope="row"> �������ּ� </th>
		      <td> ${purchase.dlvyAddr} </td>
		    </tr>
		    
	  		 <tr>
		      <th scope="row"> ���ſ�û���� </th>
		      <td>  ${purchase.dlvyRequest}  </td>
		    </tr>		    
	  		 <tr>
		      <th scope="row"> �������� </th>
		      <td> ${purchase.dlvyDate}  </td>
		    </tr>	  		 <tr>
		      <th scope="row"> �ֹ��� </th>
		      <td> ${purchase.orderDate}</td>
		    </tr>	  		 <tr>
		      <th scope="row">  ���� ����  </th>
		      <td>  
				<c:if test="${purchase.tranCode eq '002'}">
					 ���ſϷ� �����Դϴ�. 
				 </c:if>
				  <c:if test="${purchase.tranCode eq '003'}">
			      ��� �� �Դϴ�. 
				 </c:if>
			 	 <c:if test="${purchase.tranCode eq '004'}">
						��ۿϷ� �����Դϴ�.
			 	 </c:if>
			 	     
		      </td>
		    </tr>		    
		    
		    
	 </tbody>
	
	
	
		</table>
		<br>
		
		
		
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		     <c:if test="${purchase.tranCode eq '002'}">
		      <button type="button" class="btn btn-primary" > ���� </button>
 			 </c:if>
 			 
 			  <button type="button" class="btn btn-primary" >Ȯ��</button>
			  
		    </div>
		  </div>
		
		
		
		
		
	</div>
 



</body>
</html>
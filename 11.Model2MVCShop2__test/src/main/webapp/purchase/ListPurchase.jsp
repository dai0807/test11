<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
 
<!DOCTYPE html>
<html>
<head>
 
 
 

	
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

<script type="text/javascript" src="../javascript/calendar.js">
</script>
	<script type="text/javascript">
// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
<%-- 



 
function fncGetList(currentPage){
	document.getElementById("currentPage").value = currentPage;
	document.detailForm.submit();
}
  --%>
  
  function fncGetList(currentPage){
		$("#currentPage").val(currentPage) ; 
		console.log (  "currentPage ���� ��� �϶�! ���ư��� �ų��� "+ " currentPage " + $("#currentPage").val());
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase" ).submit();

	}
  
$(function(){
	
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$( ".ct_list_pop td:nth-child(7)" ).css("color" , "pink");

	//$("h7").css("color" , "red");
	
		$(".ct_list_pop:nth-child(4n+2)" ).css("background-color" , "whitesmoke");

//	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	
});

$(function(){
	$(".ct_list_pop td:nth-child(3)").on("click", function(){
		
		console.log( "d:nth-child(3) val " +  $(this).val() );
		console.log( "d:nth-child(3) attr " + $(this).attr("value")  );

		self.location ="/user/getUser?userId="+ $(this).val() ; 
		 
		
	});
});

$(function(){	
	$(".ct_list_pop td:nth-child(7)").on("click", function(){
		
		console.log("d:nth-child(7) val " +  $(this).val() );
		console.log("d:nth-child(7) attr" + $(this).attr("value")  );

		self.location ="/purchase/getPurchase?tranNo="+ $(this).attr("value") ; 
 
 	});
});

$(function(){	
	$(".button_arrive").on("click", function(){
	 
		console.log(" tranNo ����� ���¿�  " + $(this).attr("value")   );
		//var currendPage =  $("#currentPage").val() ;
		 var currendPage =  $("#currentPageH").attr("value") ;

		 console.log( "currentPage  ::  " +currendPage );
		 
		 var currendPage1 =  $("#currentPageH").val() ;

		 console.log( "currentPage1  ::  " +currendPage1 );

		
 
		//self.location ="/purchase/updateTranCode?currentPage="+currendPage+"&tranNo="+$(".ct_list_pop td:nth-child(7)").attr("value")+"&tranCode=004"  ; 
			self.location ="/purchase/updateTranCode?currentPage="+currendPage+"&tranNo="+$(this).attr("value")+"&tranCode=004"  ; 

		
	});
	//<a href="${ menu == 'search' ? '/product/getProduct' : '/product/updateProductView'}?prodNo=${product.prodNo }&menu=${ menu }&tranCode=${product.proTranCode}">
});

</script>
</head>

<body >
	<jsp:include page="/layout/toolbar.jsp" />
	<jsp:include page="/common/Q&A.jsp" />
 
 <div class ="container">
	<div class="page-header text-info">
	       <h3>���� ��� ��ȸ </h3>
	   </div>
	<form name="detailForm"  >
	
		<div class ="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
					 <input type="hidden" id="currentPageH"   value="${resultPage.currentPage}"/>
		    	</p>
		    </div>	
		
		
		  <table class="table table-hover table-striped" >
		
		
		
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >ȸ�� ID</th>
            <th align="left"> ȸ����</th>
            <th align="left">��ǰ�̸�</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">�����Ȳ</th>
            <th align="left"> ���� ���� </th>
            
          </tr>
        </thead>
		<tbody>
		 <c:set var="i" value="0" />
		  <c:forEach var="Puchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"   > ${buyer_id}   </td>
			  <td align="left"> ${Puchase.receiverName } </td>
			  <td align="left"  class="tranTd"  value ="${Puchase.tranNo}" >${Puchase.purchaseProd.prodName }  </td>
			  <td align="left">${Puchase.receiverPhone} </td>
 			
				<c:if test="${Puchase.tranCode eq '002'}">
					  <td align="left">
					 	 ���ſϷ�   &nbsp; &nbsp; </td>	
					 	 <td align="left">  </td>
					 
				</c:if>
				 <c:if test="${Puchase.tranCode eq '003'}">
					  <td align="left">
					 	 �����   &nbsp; &nbsp; </td>	
					 	 <td align="left" class ="button_arrive"  value ="${Puchase.tranNo}" >��ǰ����  </td>					 	
					 	 
					 	<!--   <button  class ="button_arrive"  value ="${Puchase.tranNo}" type="button" > ��ǰ���� </button> -->
 					 
				 </c:if>
		 		 <c:if test="${Puchase.tranCode eq '004'}">
								 <td align="left"> 	��ۿϷ� &nbsp; &nbsp; </td>
								 <td align="left">  </td>  
		 		 </c:if>

 				 	 	

	 
	 
 			</tr>
          </c:forEach>	
		
		
		</tbody>
		
		
		
			</table>
		</div>
		
			   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		
			<jsp:include page="../common/pageNavigator_new.jsp"/>
		
		
		
		
		
		
	</form>
 </div>
	 

</body>
</html>
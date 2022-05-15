<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
 
<title> �Ǹ� �����ȸ  </title>
 

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
 

 
function fncGetList(currentPage){
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)

	
	console.log (  "currentPage ���� ��� �϶�! ���ư��� �ų��� "+ $("#currentPage").val());

	
	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/purchase/listSale").submit();
		
	}
 
 	$(function(){
		$( "td:nth-child(4)" ).css("color" , "#FF35BC");

 		
 		
 		
		$(".ct_list_pop:nth-child(4n+2)" ).css("background-color" , "whitesmoke");

		$(".tranTd").on("click" , function(){
			 
			 var JtranCode = $(this).attr("value") ; 
 			 console.log(" attr : tran NO ���� ? " +JtranCode ) ;

 
 			self.location = "/purchase/getPurchase?tranNo="+JtranCode ; 
 		});
 		///purchase/getPurchase?tranNo=
 			
 			
 			
		$(".tran_tranNo").on("click", function(){
			
			
			console.log(" tranNo ����� ���¿�  " + $(this).attr("value")   );
			//var currendPage =  $("#currentPage").val() ;
			 var currendPage =  $("#currentPageH").attr("value") ;

			 console.log( "currentPage  ::  " +currendPage );
			 
			self.location ="/purchase/updateTranCode?currentPage="+currendPage+"&tranNo="+$(this).attr("value")+"&tranCode=003"  ; 

		//	  self.location ="/product/updateProdcutTranCodeByProd?currentPage="+currendPage+"&prodNo="+$(this).attr("value")+"&tranCode=003&menu=manage" ;
			 //���� �κ� �����ϱ� !! ������ ���ö�� ���� �� �����. �׷��� ������ �귶��. 
			 
			
			});	
 	});
 
</script>
</head>

 	<jsp:include page="/layout/toolbar.jsp" />


	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
 	<div class="page-header text-info">
	       <h3>�Ǹ� �����ȸ</h3>
	    </div>
 <form name="detailForm"  >
 
 
 	<!-- table ���� �˻� Start  -->

	<div class ="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
					 <input type="hidden" id="currentPageH"   value="${resultPage.currentPage}"/>
		    	</p>
		    </div>	
	
	
	</div>


      <table class="table table-hover table-striped" >


        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >ȸ�� ID</th>
            <th align="left">��ǰ ��ȣ </th>
            <th align="left">��ǰ �̸�</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">���� ���� </th>
            <th align="left"> ���� ���� </th>
            
          </tr>
        </thead>


<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"   >${purchase.buyer.userId} </td>
			  <td align="left">${purchase.purchaseProd.prodNo }  </td>
			  <td align="left"  class="tranTd"  value ="${purchase.tranNo}" >${purchase.purchaseProd.prodName }  </td>
			  <td align="left">${purchase.receiverPhone} </td>
 				
		 		<c:if test = "${ purchase.tranCode eq'000'}">
							<td align="left">  ���Ű��� &nbsp; &nbsp; </td>			
							<td align="left">  </td>
							
				</c:if>		 			
				<c:if test = "${ purchase.tranCode eq'002'}">
							<td align="left"> ���ſϷ� &nbsp; &nbsp;  </td>
		 					<td align="left" class="tran_tranNo" value ="${purchase.tranNo}"  > ����ϱ� </td>
		 					
				</c:if>
				<c:if test ="${ purchase.tranCode eq'003'}">
					 	<td align="left"> 	����� &nbsp; &nbsp; </td>
					 	<td align="left">  </td>
					 	
		 		</c:if>
				<c:if test ="${ purchase.tranCode eq'004'}">
					 	<td align="left"> 	��ۿϷ� &nbsp; &nbsp; </td>
						<td align="left">  </td>
					 	
		 		</c:if>  	 
	 
	 
	 
 			</tr>
          </c:forEach>
        
        </tbody>








   
	</table>
	<!-- table End -->

 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 
 

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
 					<jsp:include page="../common/pageNavigator_new.jsp"/>
  					 
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
<%@page import="java.awt.PageAttributes.OrientationRequestedType"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   <!--
   최신 상품 쿼리 
   
     select inner.*   from (
	select prod_no , prod_name ,price , REG_DATE 
	From product  order by  REG_DATE desc) inner WHERE ROWNUM<= 4 ; 

인기 상품 쿼리 

select p.prod_no  ,p.price  , p.prod_name from
 (select  * from 
    (select prod_no ,count(*) as count from transaction
           group by prod_no  order by count desc )  where ROWNUM <= 4  ) inner , product p  
where inner.prod_no = p.prod_no ;

    -->
    
    
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


     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">


	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
			
		
			
		console.log (  "메뉴 값을 출력 하라! 돌아간다 신난다 "+ $("#menu" ).val()   + " currentPage " + $("#currentPage").val());
		//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
		
	
	}
	

	
	
	//ct_list_pop
	
	$(function(){
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
			$(".ct_list_pop:nth-child(4n+1)" ).css("background-color" , "whitesmoke");

	//	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		
		
		$(".ct_btn01").on("click", function(){
			
			///console.log(  $( ".ct_btn01" ).html() );

			fncGetList(1);  // 시발 검색 
			
		});
		//<a href="${ menu == 'search' ? '/product/getProduct' : '/product/updateProductView'}?prodNo=${product.prodNo }&menu=${ menu }&tranCode=${product.proTranCode}">
		
		
		$("a:contains('보기')").on("click" , function(){
			
			
			var pageNAME =  '/product/getProduct' ;
			 console.log(  pageNAME );

			var jprodNo = $(this).attr("value") ;
			 console.log( "prodNo " +jprodNo );

			 
 			  
	        self.location = pageNAME + "?prodNo="+jprodNo+"&menu="+$("#menu").val()   ; 
 			
		});
		
		$("a:contains('구매')").on("click" , function(){
			
			
	 

				self.location ="/purchase/addPurchaseView?prodNo="+ $(this).attr("value") ; 
			 
 			  
	       // self.location = pageNAME + "?prodNo="+jprodNo+"&menu="+$("#menu").val()   ; 
 			
		});		
		
		
		
		$(".produc_no").on("click" , function(){
			
			 

			var jprodNo = $(this).attr("value1") ;
			 console.log( "prodNo " +jprodNo );

				var jproTranCode = $(this).attr("value2") ;
				 console.log( "proTranCode  " +jproTranCode );		      
			 
			//  self.location = pageNAME + "?prodNo="+ $(".ct_list_pop  td:nth-child(1)").val() + "&menu="+$("#menu").val() +"&tranCode=" + $(".ct_list_pop  td:nth-child(3)").val() 
				 $.ajax( 
							{
								url : "/product/json/getProduct/"+jprodNo ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {


									
									var displayValue = "<h3>"
																+"상품명 		: "+JSONData.prodName+"<br/>"
																+"상품ID 		: "+JSONData.prodNo+"<br/>"
																+"상품상세정보	: "+JSONData.prodDetail+"<br/>"
																+"제조일자		: "+JSONData.manuDate+"<br/>"
																+"가격 		: "+JSONData.price+"<br/>" 
																+"</h3>";
								
									 console.log( "displayValue  " +displayValue );		      

									$("h3").remove();
									$( "#"+jprodNo+"" ).html(displayValue);
								}
						});
				
		});
			
 
		
		
	$("#span_prodNo").on("click", function(){
		
		
		console.log(" tranNo 제대로 나온요  " + $(this).attr("value")   );
		//var currendPage =  $("#currentPage").val() ;
		 var currendPage =  $("#currentPageH").attr("value") ;

		 console.log( "currentPage  ::  " +currendPage );
		 


		  self.location ="/product/updateProdcutTranCodeByProd?currentPage="+currendPage+"&prodNo="+$(this).attr("value")+"&tranCode=003&menu=manage" ;
		 //여기 부분 보안하기 !! 눈물이 차올라거 고개를 쳐 들었다. 그렇게 눈물이 흘렀다. 
		 
		
		});
		
	 }); 
		
 
</script>




</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
		<jsp:include page="/common/Q&A.jsp" />

 <input type="hidden" id="menu"   value="${menu}"/>

 <!-- <form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">  -->
<!-- menu를 manage로 보냄  -->

 

<div class="container">
	 	<div class="page-header text-info">
 			 <h3> 상품 검색</h3>
						 	 
	    </div>
  	 <input type="hidden" id="menu"   value="${menu}"/>
 	<form class="form-inline" name="detailForm">
 

	
	    <div class="row">
	       <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
					 <input type="hidden" id="currentPageH"   value="${resultPage.currentPage}"/>
					 <input type="hidden" id="currentPage" name="currentPage" value=""/>
					 
		    	</p>
		    </div>	
		    <div class="col-md-6 text-right">
					  <div class="form-group">
					   
							<select name="searchCondition"    class="ct_input_g" style="width:80px">
						 
							<option value="0" ${ ! empty search.searchCondition && search.searchCondition =="0" ? "selected" : ""} > 상품번호</option>
							<option value="1" ${ ! empty search.searchCondition && search.searchCondition =="1" ? "selected" : ""} > 상품명</option>
							<option value="2" ${ ! empty search.searchCondition && search.searchCondition =="2" ? "selected" : ""} > 상품가격</option>
					 					
							</select>
						</div>
						
						  <div class="form-group">
					    <label class="sr-only" for="searchKeyword">검색어</label>
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
					    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  </div>
	 						
				 				  <button type="button" class="btn btn-default">검색</button>
 			 
	 
			</div>	
	    
	    
	    
	   	 </div>
   			 <br/>
			 


	<div> 
	
	 <c:forEach var="product" items="${list}">
 

 	<div class="col-sm-3 col-md-3 " >
      <div class="thumbnail"  style="height: 400px;"   >
       <img class="img-responsive" src="/images/uploadFiles/${product.fileName }"  onerror="this.onerror=null; this.src='https://via.placeholder.com/240X200?text=No Image';" style= "width:200; height:200px;" > 
     
      
     
          <div class="caption">
            <h3> ${ product.prodName } </h3>
            <p>가격  :${product.price}</p>
            <p>수량  :${product.quantity}</p>
            
            <p > <a href="#" class="btn btn-info" role="button" value ="${product.prodNo}"> 보기</a>
      				<c:if test = "${userId ne 'admin'}">
         			  <c:if test = "${userId ne ''}">
            	<a href="#" class="btn btn-primary" role="button" value ="${product.prodNo}"> 구매</a></p>
        	</c:if> 	</c:if>
        </div>
      </div>
    </div> 


	</c:forEach>	

</div>



 
 		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		  
		   
 
 	<jsp:include page="../common/pageNavigator_new.jsp"/>
 
 <jsp:include page="/common/Q&A.jsp" />    
</form>
 



	
	
   

 


	
	


</div>

		
 </body>


</html>
<%@page import="java.awt.PageAttributes.OrientationRequestedType"%>
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
		
		
 


		$(".btn.btn-default").on("click", function(){
			
			/// 		$(".ct_btn01").on("click", function(){


			fncGetList(1);  //   검색 
			
		});

 		
//더블클릭시 
	//	$(".produc_no").on("dblclick" , function(){
//			 $.ajax( 
//							{
//								url : "/product/json/getProduct/"+jprodNo ,
//								method : "GET" ,
//								dataType : "json" ,
//								headers : {
//									"Accept" : "application/json",
//									"Content-Type" : "application/json"
//								},
//								success : function(JSONData , status) {


									
	//								var displayValue = "<h3>"
//																+"상품명 		: "+JSONData.prodName+"<br/>"
//																+"상품ID 		: "+JSONData.prodNo+"<br/>"
//																+"상품상세정보	: "+JSONData.prodDetail+"<br/>"
//																+"제조일자		: "+JSONData.manuDate+"<br/>"
//																+"가격 		: "+JSONData.price+"<br/>" 
//																+"</h3>";
//								
//									 console.log( "displayValue  " +displayValue );		      
//
//									$("h3").remove();
//									$( "#"+jprodNo+"" ).html(displayValue);
//								}
//						});




			
//			var pageNAME = '/product/updateProductView';
//			 console.log(  pageNAME );

//			var jprodNo = $(this).attr("value1") ;
//			 console.log( "prodNo " +jprodNo );

 			 
			//  self.location = pageNAME + "?prodNo="+ $(".ct_list_pop  td:nth-child(1)").val() + "&menu="+$("#menu").val() +"&tranCode=" + $(".ct_list_pop  td:nth-child(3)").val() 
			  
//	        self.location = pageNAME + "?prodNo="+jprodNo+"&menu="+$("#menu").val()   ; 
 			
//		});
		
		$("td:nth-child(6) > i").on("click" , function(){
			
			
			var pageNAME = '/product/updateProductView';
			 console.log(  pageNAME );

			var jprodNo = $(this).attr("value") ;
			 console.log( "prodNo " +jprodNo );

 			 
			//  self.location = pageNAME + "?prodNo="+ $(".ct_list_pop  td:nth-child(1)").val() + "&menu="+$("#menu").val() +"&tranCode=" + $(".ct_list_pop  td:nth-child(3)").val() 
			  
	        self.location = pageNAME + "?prodNo="+jprodNo+"&menu="+$("#menu").val()   ; 
 			
		});
		
		
		
		$(".produc_no").on("click" , function(){
			var pageNAME = '/product/getProduct' ;
			var jprodNo = $(this).attr("value") ;
			 console.log( "prodNo " +jprodNo );
 			self.location = pageNAME + "?prodNo="+jprodNo  ; 
				
		});
			
	});
		
		

		
 
</script>




</head>
	<jsp:include page="/layout/toolbar.jsp" />
		<jsp:include page="/common/Q&A.jsp" />

<div class ="container">
	<div class="page-header text-info">
	       <h3>상품 관리</h3>
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
      <table class="table table-hover table-striped" >
	 
	    <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격 </th>
            <th align="left">등록일</th>
            <th align="left">수량</th>
            <th align="left">상품 수정</th>
 
            
          </tr>
        </thead>
	 <tbody>
	 	
		  <c:set var="i" value="0" />
			  <c:forEach var="product" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="center">${ i }</td>
				  <td align="left"    class = "produc_no" value="${product.prodNo}"  > ${ product.prodName }	 </td>
				  <td align="left">${product.price }  </td>
				  <td align="left"  >${product.regDate }  </td>
				  <td align="left">${product.quantity} </td>
					<td align="left" > 
					<i class="glyphicon glyphicon-ok"   value="${product.prodNo}"  ></i>
					
					</td>
				
		 
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
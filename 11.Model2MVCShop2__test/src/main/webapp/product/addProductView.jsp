<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%-- 상품 등록하는 페이지  --%>
<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title> 상품등록 </title>
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

<script type="text/javascript" src="../javascript/calendar.js">
</script>
	<script type="text/javascript">
 
		function fncAddProduct(){
			//Form 유효성 검증
		// 	var name = document.detailForm.prodName.value;
		//	var detail = document.detailForm.prodDetail.value;
		//	var manuDate = document.detailForm.manuDate.value;
		//	var price = document.detailForm.price.value;
		
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
		
		//	document.detailForm.action='/product/addProduct';
		//	document.detailForm.submit();
		//			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
			
			$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit() ;
		}


		$(function() {
				 $( "a:contains('지우기')" ).on("click" , function() {
						
						$("form")[0].reset();
				 
						 
				 });
				  
				 
			});
		
		 $(function() {
			 
			 $("#manuDate" ).on("click" , function() {
				 
				 show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value) ;
			});
		});	
		 
 
		 $(function() {
			 
			 $("button.btn.btn-primary" ).on("click" , function() {
				 
				fncAddProduct();
			});
		});	
		 
 
 
 
 // 왜그러니
 
 
 
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/layout/toolbar.jsp" />
		<jsp:include page="/common/Q&A.jsp" />

	<div class="container">
	 	<div class="page-header text-info">
	       <h3>상품등록</h3>
	    </div>

		<form name="detailForm"  class="form-horizontal" encType="multipart/form-data" >
		
			<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 상품명 </label>
		 	   <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품이름">
	    		</div>
	    	</div>
	    	
			<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 상품상세정보  </label>
		 	   <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail">
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
		      <input type="text" class="form-control" id="price" name="price">
	    		</div>
	    	
	    	
	    	
	    	</div> 
	    	
	    	<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 수량    </label>
		 	   <div class="col-sm-4">
		      <input type="text" class="form-control" id="quantity" name="quantity">
	    		</div>
	    	
		     </div> 
	    	
	    	<div class="form-group">
	   		 <label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label"> 상품 파일    </label>
		 	   <div class="col-sm-4">
		      <input type="file" class="form-control" id="fileInfo" multiple="multiple" name="fileInfo">
	    		</div>
	    	
		     </div> 	    	
	    	


		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" > 등록 </button>
			  <a class="btn btn-primary btn" href="#" role="button">지우기</a>
			  <button type="button" class="btn btn-primary" >취소</button>
			  
		    </div>
		  </div>



	    	
	    	
		
		</form>






	</div>


 
 

 </body>
</html>

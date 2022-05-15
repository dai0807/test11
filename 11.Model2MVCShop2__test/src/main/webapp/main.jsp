<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
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
	<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Song+Myung&family=Source+Serif+Pro:wght@600&display=swap" rel="stylesheet">
	
	

     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	$("a:contains('보기')").on("click" , function(){
		
		
		var pageNAME =  '/product/getProduct' ;
		 console.log(  pageNAME );

		var jprodNo = $(this).attr("value") ;
		 console.log( "prodNo " +jprodNo );

		 
			  
        self.location = pageNAME + "?prodNo="+jprodNo+"&menu=search"   ; 
			
	});

	
	</script> 	

	<style>
        body {
            padding-top : 10px;
        }
               h2 {font-family: 'Black Han Sans', sans-serif;}
        
        
    
        
   	</style>
   	<title>Fait Main</title>
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
		<jsp:include page="/common/Q&A.jsp" />
	
   	<!-- ToolBar End /////////////////////////////////////-->



	<!--  아래의 내용은 http://getbootstrap.com/getting-started/  참조 -->	
   	<div class="container ">
  

      <!-- Main jumbotron for a primary marketing message or call to action -->




    <div >


 		     <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
		  <!-- Indicators -->
		  <ol class="carousel-indicators">
		  <!-- li는 이미지 개수만큼 추가하고 data-target은 carousel id를 가르킨다. -->
			<!-- data-slide-to는 순서대로 0부터 올라가고 0은 active를 설정한다. -->
			<!-- 딱히 이 부분은 옵션별로 설정하게 없다. -->

		<!-- 실제 이미지 아이템 -->
		<!-- class는 carousel-inner로 설정하고 role은 listbox에서 설정한다. -->
		

  		    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
		    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
		  </ol>

	  <!-- 실제 이미지 아이템  Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
	    <div class="item active"  >
	      <img src="/images/fait_main.jpg" alt="..."    >
	      <div class="carousel-caption">
	        ...
	      </div>
	    </div>
	    <div class="item"  >
	      <img src="/images/fait_main2.jpg" alt="..."    >
	      <div class="carousel-caption">
	         
	      </div>
	    </div>
	  	    <div class="item"   >
	      <img src="/images/fait_main3.jpg"  >
	      <div class="carousel-caption">
	         ..
	      </div>
	    </div>
	  </div>
	
	  <!-- Controls -->
	  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
	    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
	    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
	</div>
   </div>  
     
     
     
     
  
    </div>

	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
	<h2> 최신 상품 </h2>
			<div> 
				
				 <c:forEach var="product" items="${list}">
			 
			
			 	<div class="col-sm-4 col-md-4 " >
			      <div class="thumbnail"  style="height: 400px;"   >
			       <img class="img-responsive" src="/images/uploadFiles/${product.fileName }"  onerror="this.onerror=null; this.src='https://via.placeholder.com/240X200?text=No Image';" style= "width:200; height:200px;" > 
			     
			      
			     
			          <div class="caption">
			            <h3> ${ product.prodName } </h3>
			            <p>가격  :${product.price}</p>
			            <p>수량  :${product.quantity}</p>
			            
			            <p > <a href="/product/getProduct?prodNo=${product.prodNo}&menu=search" class="btn btn-info" role="button" value ="${product.prodNo}">보기</a>
			      		 
			        </div>
			      </div>
			    </div> 
			
			
				</c:forEach>	
			
			</div>

 
  	 </div>
<br/><br/>
</body>

	




</html>
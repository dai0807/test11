<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Fait main</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         </c:if>
	                         
	                         <li class="divider"></li>
	                         <li><a href="#">etc...</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                         <li><a href="#">판매상품목록</a></li>
		                         
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a class ="search" href="#">상 품 검 색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">최근본상품</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">etc...</a></li>
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
		//============= logout Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
		 		if( ${sessionScope.user.check_K =='K' }   ){
		 			
		 			 console.log(" 카카오 로그아웃 !! " ) ;

					$(self.location).attr("href","https://kauth.kakao.com/oauth/logout?client_id=f0b36852932e865ae00c9ff2fcd19874&logout_redirect_uri=http://localhost:8080/user/logout");
 					
					
		 			///oauth/logout?client_id=${REST_API_KEY}&logout_redirect_uri=${LOGOUT_REDIRECT_URI}
		 		}else{
		 			
		 			
					$(self.location).attr("href","/user/logout");

		 		}
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회회 Event  처리 =============	
	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});

		
	//	 $(function() {
	//			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//	 	$("a:contains('판매상품등록')").on("click" , function() {
			//		$(self.location).attr("href","/user/logout");
					//self.location = "/user/logout"
	//			}); 
		//	 });	
		
		
			//============= 상품 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('판매상품등록')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				$(self.location).attr("href","/product/addProduct") ;
			}); 
		 });
			
		 $(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 	$("a:contains('판매상품관리')").on("click" , function() {
					//$(self.location).attr("href","/user/logout");
					$(self.location).attr("href","/product/listProduct?menu=manage") ;
				}); 
			 });
						
			
		 $(function() {
 			 	$("a:contains('판매상품목록')").on("click" , function() {
					//$(self.location).attr("href","/user/logout");
					$(self.location).attr("href","/purchase/listSale") ;
				}); 
			 });
						 
	
		 $(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 	$(".search").on("click" , function() {
					//$(self.location).attr("href","/user/logout");
					$(self.location).attr("href","/product/listProduct?menu=search") ;
				}); 
			 });						
		 
			
		 $(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 	$("a:contains('구매이력조회')").on("click" , function() {
					//$(self.location).attr("href","/user/logout");
					$(self.location).attr("href","/purchase/listPurchase") ;
				}); 
			 });						
	

		
		
	</script>  
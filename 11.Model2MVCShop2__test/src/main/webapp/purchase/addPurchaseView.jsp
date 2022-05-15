<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%-- -- 
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.service.domain.*" %>

<%@ page import="com.model2.mvc.common.*" %>

<%
	Product po=(Product)request.getAttribute("Product");
	User user=(User)request.getAttribute("User");

%>
--%>
 
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

	
	 
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
 
	function fncAddPurchase(){
		var receiverName =	$("input[name='receiverName']").val();
		var receiverPhone=	$("input[name='receiverPhone']").val();
		var dlvyAddr=		$("input[name='dlvyAddr']").val();
 		
		 console.log( "receiverName  " +receiverName + " , receiverPhone: "+receiverPhone + " ,dlvyAddr: "+ dlvyAddr       );		      
	
	
		if(receiverName == null || receiverName.length<1){
			alert("구매자이름은 반드시 입력하여야 합니다.");
			return;
		}
		if(receiverPhone == null || receiverPhone.length<1){
			alert("전화번호 는 반드시 입력하여야 합니다.");
			return;
		}
		if(dlvyAddr == null || dlvyAddr.length<1){
			alert("배송 주소는 반드시 입력하셔야 합니다.");
			return;
		}
		 
		
		
		
 		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase?tranCode=002" ).submit();

	}
	
	$(function(){
		$("button:contains('구매')").on("click", function(){
			
			fncAddPurchase();
		});
		
		$("button:contains('취소')").on("click", function(){
			history.go(-1); 
		});
		
	}); 
	 $(function() {
		 
		 $("#dlvyDate" ).on("click" , function() {
			 
			 show_calendar('document.detailForm.dlvyDate', document.detailForm.dlvyDate.value) ;
		});
	});			 
	
</script>

</head>

<body>
 <jsp:include page="/layout/toolbar.jsp" />

<form name="detailForm"   class="form-horizontal"  >


	<div class="container">
		 	<div class="page-header text-info">
	 						  	     <h3> 구매하기 </h3>
							 	 
		    </div>
		    <table class="table table-condensed">
	
		<tbody>
		
		
		    <tr>
		    <input type="hidden" name="prodNo" value= "${product.prodNo}"/>
		    
		      <th scope="row"> 상품번호  </th>
		      
		      <td>  ${product.prodNo } </td>
		    </tr>

		    <tr>
		      <th scope="row"> 상품명   </th>
		      <td>${product.prodName} </td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">제조일자 </th>
		      <td>  ${product.manuDate } </td>
		    </tr>
		    <tr>
		      <th scope="row">가격 </th>
		      <td> ${product.price } </td>
		    </tr>		    <tr>
		      <th scope="row">등록일자 </th>
		      <td>  ${product.regDate} </td>
		    </tr>		    <tr>
		      <th scope="row">구매자아이디 </th>
		      <td>${buyer_id} </td>
 	<input type="hidden" name="userId" value="${buyer_id}" />
		      
		    </tr>
		    
		    <tr>
		      <th scope="row"> 구매방법  </th>
		      <td>
			 <select 	name="paymentOption">
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>

			 	</td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">구매자이름</th>
		      <td>  <input type="text" class="form-control" name="receiverName"   value="${User.userName }" />
			 </td>
		    </tr>
		    
 		    <tr>
		      <th scope="row">구매자연락처 </th>
		      <td> <input 	type="text" name="receiverPhone"  class="form-control" value="${User.phone}" />
		        </td>
		    </tr>
		    		    		    		    
	  		 <tr>
		      <th scope="row"> 구매자주소 </th>
		      <td><input 	type="text" name="dlvyAddr"  class="form-control"	value="${User.addr }" />
		
		<!-- 	 <input type="text" id="sample6_postcode" placeholder="우편번호">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample6_address" placeholder="주소"><br>
			<input type="text" id="sample6_detailAddress" placeholder="상세주소">
			<input type="text" id="sample6_extraAddress" placeholder="참고항목">
	 -->	
		
		
		
			</td>
		    </tr>
		    
	  		 <tr>
		      <th scope="row"> 배송희망일 </th>
		     
			<td>
		      <input type="date" class="form-control" id="dlvyDate" name="dlvyDate" >

			  </td>
		    </tr>		    
	  		 <tr>
		      <th scope="row"> 구매요청사항 </th>
		      <td> <input		type="text" name="dlvyRequest" 	 />
			 </td>
		    </tr>	  		 
		        
		    
		    
	 </tbody>
	
	
	
		</table>
		    
	</div>

		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-info" >구매 </button>
 			  <button type="button" class="btn btn-primary" >취소</button>
			  
		    </div>
		  </div>



</form>
 

</body>
</html>
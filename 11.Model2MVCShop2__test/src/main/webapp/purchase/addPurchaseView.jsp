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


     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	
	 
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                var addr = ''; // �ּ� ����
                var extraAddr = ''; // �����׸� ����

                //����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
                    addr = data.roadAddress;
                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
                    addr = data.jibunAddress;
                }

                // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����׸��� �����Ѵ�.
                if(data.userSelectedType === 'R'){
                    // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
                    // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
                    if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // ���յ� �����׸��� �ش� �ʵ忡 �ִ´�.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
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
			alert("�������̸��� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(receiverPhone == null || receiverPhone.length<1){
			alert("��ȭ��ȣ �� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(dlvyAddr == null || dlvyAddr.length<1){
			alert("��� �ּҴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		 
		
		
		
 		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase?tranCode=002" ).submit();

	}
	
	$(function(){
		$("button:contains('����')").on("click", function(){
			
			fncAddPurchase();
		});
		
		$("button:contains('���')").on("click", function(){
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
	 						  	     <h3> �����ϱ� </h3>
							 	 
		    </div>
		    <table class="table table-condensed">
	
		<tbody>
		
		
		    <tr>
		    <input type="hidden" name="prodNo" value= "${product.prodNo}"/>
		    
		      <th scope="row"> ��ǰ��ȣ  </th>
		      
		      <td>  ${product.prodNo } </td>
		    </tr>

		    <tr>
		      <th scope="row"> ��ǰ��   </th>
		      <td>${product.prodName} </td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">�������� </th>
		      <td>  ${product.manuDate } </td>
		    </tr>
		    <tr>
		      <th scope="row">���� </th>
		      <td> ${product.price } </td>
		    </tr>		    <tr>
		      <th scope="row">������� </th>
		      <td>  ${product.regDate} </td>
		    </tr>		    <tr>
		      <th scope="row">�����ھ��̵� </th>
		      <td>${buyer_id} </td>
 	<input type="hidden" name="userId" value="${buyer_id}" />
		      
		    </tr>
		    
		    <tr>
		      <th scope="row"> ���Ź��  </th>
		      <td>
			 <select 	name="paymentOption">
				<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
			</select>

			 	</td>
		    </tr>
		    		    
		    <tr>
		      <th scope="row">�������̸�</th>
		      <td>  <input type="text" class="form-control" name="receiverName"   value="${User.userName }" />
			 </td>
		    </tr>
		    
 		    <tr>
		      <th scope="row">�����ڿ���ó </th>
		      <td> <input 	type="text" name="receiverPhone"  class="form-control" value="${User.phone}" />
		        </td>
		    </tr>
		    		    		    		    
	  		 <tr>
		      <th scope="row"> �������ּ� </th>
		      <td><input 	type="text" name="dlvyAddr"  class="form-control"	value="${User.addr }" />
		
		<!-- 	 <input type="text" id="sample6_postcode" placeholder="�����ȣ">
			<input type="button" onclick="sample6_execDaumPostcode()" value="�����ȣ ã��"><br>
			<input type="text" id="sample6_address" placeholder="�ּ�"><br>
			<input type="text" id="sample6_detailAddress" placeholder="���ּ�">
			<input type="text" id="sample6_extraAddress" placeholder="�����׸�">
	 -->	
		
		
		
			</td>
		    </tr>
		    
	  		 <tr>
		      <th scope="row"> �������� </th>
		     
			<td>
		      <input type="date" class="form-control" id="dlvyDate" name="dlvyDate" >

			  </td>
		    </tr>		    
	  		 <tr>
		      <th scope="row"> ���ſ�û���� </th>
		      <td> <input		type="text" name="dlvyRequest" 	 />
			 </td>
		    </tr>	  		 
		        
		    
		    
	 </tbody>
	
	
	
		</table>
		    
	</div>

		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-info" >���� </button>
 			  <button type="button" class="btn btn-primary" >���</button>
			  
		    </div>
		  </div>



</form>
 

</body>
</html>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!-- 
spring ��� ����� 
https://unknown-coding.tistory.com/16

���� :
https://1-7171771.tistory.com/141
 -->
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		
		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
		
		function fncAddUser() {
			
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(name == null || name.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if( pw != pw_confirm ) {				
				alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				$("input:text[name='password2']").focus();
				return;
			}
				
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}

			$("input:hidden[name='phone']").val( value );
			
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
		

		//==>"�̸���" ��ȿ��Check  Event ó�� �� ����
		 $(function() {
			 
			 $("input[name='email']").on("change" , function() {
				
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("�̸��� ������ �ƴմϴ�.");
			     }
			});
			 
		});	
		
		
	   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	   //==> �ֹι�ȣ ��ȿ�� check �� ����������....
		function checkSsn() {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
	
			ssn = document.detailForm.ssn.value;
			// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
			if(!PortalJuminCheck(ssn)) {
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
				return false;
			}
		}
	
		function PortalJuminCheck(fieldValue){
		    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
			var num = fieldValue;
		    if (!pattern.test(num)) return false; 
		    num = RegExp.$1 + RegExp.$2;
	
			var sum = 0;
			var last = num.charCodeAt(12) - 0x30;
			var bases = "234567892345";
			for (var i=0; i<12; i++) {
				if (isNaN(num.substring(i,i+1))) return false;
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}
			var mod = sum % 11;
			return ((11 - mod) % 10 == last) ? true : false;
		}
		 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		 
		//==>"ID�ߺ�Ȯ��" Event ó�� �� ����
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $("button.btn.btn-info").on("click" , function() {
				popWin 
				= window.open("/user/checkDuplication.jsp",
											"popWin", 
											"left=300,top=200,width=780,height=130,marginwidth=0,marginheight=0,"+
											"scrollbars=no,scrolling=no,menubar=no,resizable=no");
			});
			
			 var code2 = "";

			 $("#phoneChk").on("click" , function() {


				 console.log("phoneChe �� ") ;
				 alert("������ȣ �߼��� �Ϸ�Ǿ����ϴ�.\n�޴������� ������ȣ Ȯ���� ���ֽʽÿ�."); 
					var phone = $("#phone").val();
					 $.ajax({ 
						 type:"GET", url:"/user/uphoneCheck?phone=" + phone,  
								 success:function(data){ 
									 if(data == "error"){

							 alert("�޴��� ��ȣ�� �ùٸ��� �ʽ��ϴ�.") 
							 $(".successPhoneChk").text("��ȿ�� ��ȣ�� �Է����ּ���.");
					
							 $(".successPhoneChk").css("color","red"); 
					
							$("#phone").attr("autofocus",true);
					
							 }else{
								 
								 
							 $("#phone2").attr("disabled",false); $("#phoneChk2").css("display","inline-block"); 
							$(".successPhoneChk").text("������ȣ�� �Է��� �� ���������� �����ֽʽÿ�.");
							 $(".successPhoneChk").css("color","green"); 
							$("#phone").attr("readonly",true); 
							console.log(" ������ȣ  data "  + data)
							code2 = data;
					 } 
					} 
					});

				 
				 
			});
			
			});		
		 $(function() {	
			 
	  $("#phoneChk2.doubleChk3").on("click" , function() {
		  
		  var phone = $("#phone").val()
		  var phone2 = $("#phone2").val()
		  		  console.log("phone :"  +phone)
		  		  console.log("phone2 :"  +phone2)

		  console.log("üũüũ��Ӥ� �� ")
		  
			 $.ajax({ 
				 type:"GET", url:"/user/smsCertificationRequest?phone="+phone+"&phone2="+phone2 ,
						 success:function(data){ 
							 if(data == "error"){
								 alert("��ȿ���� �ʽ��ϴ�. .")  
								 }else if(data == "F"){
										console.log("   data "  + data) 

									 $(".successPhoneChk").text("������ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ�����ֽñ� �ٶ��ϴ�."); 
									 $("#phoneDoubleChk").val("false");
									 $(this).attr("autofocus",true); 

					
					
					
										
								 } else{
										console.log("   data "  + data) 
									 $(".successPhoneChk").text("������ȣ�� ��ġ�մϴ�.!!1");
									 $(".successPhoneChk").css("color","green");
									 $("#phoneDoubleChk").val("true"); 
									 $("#phone2").attr("disabled",true);
									 
									 
									 
									 
									 
								 }
							 
											 
							} 
						});
			 
			 
			 
		
			 
			 
				});	

		
	 });	
	
		
	

		 
	
 		
	</script>		
    
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">ȸ �� �� ��</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�� �� ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="�ߺ�Ȯ���ϼ���"  readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">�Է��� �ߺ�Ȯ�� ����..</strong>
		      </span>
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-info">�ߺ�Ȯ��</button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ Ȯ��</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="��й�ȣ Ȯ��">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="userName" name="userName" placeholder="ȸ���̸�">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ֹι�ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="�ֹι�ȣ">
		      <span id="helpBlock" class="help-block">
		      	 <strong class="text-danger">" -  " ���� 13�ڸ��Է��ϼ���</strong>
		      </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="addr" name="addr" placeholder="�ּ�">
		    </div>
		  </div>
		  
		  <div class="form-group">
		   <!--  
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�޴���ȭ��ȣ</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="��ȣ">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="��ȣ">
		    </div>
		  <input type="hidden" name="phone"  /> -->
		  </div>
		  
		  <div>
		  <table class="mobileNo"> 
		  <th> 
		  <label for="phone">�޴��� ��ȣ</label> 
		  </th>
		   <td> <p> <input id="phone" type="text" name="phone" title="��ȭ��ȣ �Է�" required/> 
		   
		   
		  <!--  <button id="phoneChk" class="doubleChk"  > ������ȣ ����    </button> <br/>--> 
		 <span id="phoneChk" class="doubleChk">������ȣ ������</span><br/>   
		   <input id="phone2" type="text" name="CertificationNumber" title="������ȣ �Է�" disabled required/> 
		   
		   
		 <!--  <button id="phoneChk2" class="doubleChk"  > ��������   </button> <br/> -->
		   
		   <span id="phoneChk2" class="doubleChk3">��������</span>  <br/>  
		   <span class="point successPhoneChk">�޴��� ��ȣ �Է��� ������ȣ �����⸦ ���ֽʽÿ�.</span>  
		   <input type="hidden" id="phoneDoubleChk"/> </p> <p class="tip"> ���� ���� �ÿ��� ����ϰ� �ֽ��ϴ�. ���� ������� �ʽ��ϴ�.(��ȣ�� �Է����ּ���.)
		    </p> 
		    </td> 
		  
		  
		  
		  		  <div class="form-group">
				    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>
				    <div class="col-sm-4">
				      <input type="text" id="member_post" class="form-control"   placeholder="�����ּ�"  readonly>
				       <input type="text" id="member_addr" class="form-control"  placeholder="�ּ�"  readonly>
				       <input type="text" id="member_addr1" class="form-control"  placeholder="�߰��Է�" >
				       
 				    </div>
				    <div class="col-sm-3">
				      <button type="addrBut" class="btn btn-info"  onclick="findAddr()">�ּ�ã��</button>
				    </div>
		  </div>
		  
		  
 		    </table>

 		  
		  </div>

			 
			<script>

			function findAddr(){
				new daum.Postcode({
			        oncomplete: function(data) {
			        	
			        	console.log(data);
			        	
			            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
			            // ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� ǥ���Ѵ�.
			            // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
			            var roadAddr = data.roadAddress; // ���θ� �ּ� ����
			            var jibunAddr = data.jibunAddress; // ���� �ּ� ����
			            // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
			            $("#member_post").val(data.zonecode) ;
			            
//			            document.getElementById('member_post').value = data.zonecode;
			            if(roadAddr !== ''){
 				            $("#member_addr").val(roadAddr) ;

			              //  document.getElementById("member_addr").value = roadAddr;
			            } 
			            else if(jibunAddr !== ''){
 				            $("#member_addr").val(jibunAddr) ;

			               // document.getElementById("member_addr").value = jibunAddr;
			            }
			        }
			    }).open();
			}
			</script>
			
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			

		  
		  
		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�̸���</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="email" name="email" placeholder="�̸���">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>

</html>
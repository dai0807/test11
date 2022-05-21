<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!-- 
spring 양식 만들기 
https://unknown-coding.tistory.com/16

세션 :
https://1-7171771.tistory.com/141
 -->
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
	
		//============= "가입"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
				return;
			}
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}
			
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
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
		

		//==>"이메일" 유효성Check  Event 처리 및 연결
		 $(function() {
			 
			 $("input[name='email']").on("change" , function() {
				
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		});	
		
		
	   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	   //==> 주민번호 유효성 check 는 이해정도로....
		function checkSsn() {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
	
			ssn = document.detailForm.ssn.value;
			// 유효한 주민번호 형식인 경우만 나이 계산 진행, PortalJuminCheck 함수는 CommonScript.js 의 공통 주민번호 체크 함수임 
			if(!PortalJuminCheck(ssn)) {
				alert("잘못된 주민번호입니다.");
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
	
		 
		//==>"ID중복확인" Event 처리 및 연결
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $("button.btn.btn-info").on("click" , function() {
				popWin 
				= window.open("/user/checkDuplication.jsp",
											"popWin", 
											"left=300,top=200,width=780,height=130,marginwidth=0,marginheight=0,"+
											"scrollbars=no,scrolling=no,menubar=no,resizable=no");
			});
			
			 var code2 = "";

			 $("#phoneChk").on("click" , function() {


				 console.log("phoneChe 옴 ") ;
				 alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오."); 
					var phone = $("#phone").val();
					 $.ajax({ 
						 type:"GET", url:"/user/uphoneCheck?phone=" + phone,  
								 success:function(data){ 
									 if(data == "error"){

							 alert("휴대폰 번호가 올바르지 않습니다.") 
							 $(".successPhoneChk").text("유효한 번호를 입력해주세요.");
					
							 $(".successPhoneChk").css("color","red"); 
					
							$("#phone").attr("autofocus",true);
					
							 }else{
								 
								 
							 $("#phone2").attr("disabled",false); $("#phoneChk2").css("display","inline-block"); 
							$(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
							 $(".successPhoneChk").css("color","green"); 
							$("#phone").attr("readonly",true); 
							console.log(" 인증번호  data "  + data)
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

		  console.log("체크체크까ㅣㅈ 옴 ")
		  
			 $.ajax({ 
				 type:"GET", url:"/user/smsCertificationRequest?phone="+phone+"&phone2="+phone2 ,
						 success:function(data){ 
							 if(data == "error"){
								 alert("유효하지 않습니다. .")  
								 }else if(data == "F"){
										console.log("   data "  + data) 

									 $(".successPhoneChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다."); 
									 $("#phoneDoubleChk").val("false");
									 $(this).attr("autofocus",true); 

					
					
					
										
								 } else{
										console.log("   data "  + data) 
									 $(".successPhoneChk").text("인증번호가 일치합니다.!!1");
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

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">회 원 가 입</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="중복확인하세요"  readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">입력전 중복확인 부터..</strong>
		      </span>
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-info">중복확인</button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="userName" name="userName" placeholder="회원이름">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주민번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="주민번호">
		      <span id="helpBlock" class="help-block">
		      	 <strong class="text-danger">" -  " 제외 13자리입력하세요</strong>
		      </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="addr" name="addr" placeholder="주소">
		    </div>
		  </div>
		  
		  <div class="form-group">
		   <!--  
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
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
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
		    </div>
		  <input type="hidden" name="phone"  /> -->
		  </div>
		  
		  <div>
		  <table class="mobileNo"> 
		  <th> 
		  <label for="phone">휴대폰 번호</label> 
		  </th>
		   <td> <p> <input id="phone" type="text" name="phone" title="전화번호 입력" required/> 
		   
		   
		  <!--  <button id="phoneChk" class="doubleChk"  > 인증번호 보내    </button> <br/>--> 
		 <span id="phoneChk" class="doubleChk">인증번호 보내기</span><br/>   
		   <input id="phone2" type="text" name="CertificationNumber" title="인증번호 입력" disabled required/> 
		   
		   
		 <!--  <button id="phoneChk2" class="doubleChk"  > 본인인증   </button> <br/> -->
		   
		   <span id="phoneChk2" class="doubleChk3">본인인증</span>  <br/>  
		   <span class="point successPhoneChk">휴대폰 번호 입력후 인증번호 보내기를 해주십시오.</span>  
		   <input type="hidden" id="phoneDoubleChk"/> </p> <p class="tip"> 최초 가입 시에만 사용하고 있습니다. 따로 저장되지 않습니다.(번호만 입력해주세요.)
		    </p> 
		    </td> 
		  
		  
		  
		  		  <div class="form-group">
				    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
				    <div class="col-sm-4">
				      <input type="text" id="member_post" class="form-control"   placeholder="우편주소"  readonly>
				       <input type="text" id="member_addr" class="form-control"  placeholder="주소"  readonly>
				       <input type="text" id="member_addr1" class="form-control"  placeholder="추가입력" >
				       
 				    </div>
				    <div class="col-sm-3">
				      <button type="addrBut" class="btn btn-info"  onclick="findAddr()">주소찾기</button>
				    </div>
		  </div>
		  
		  
 		    </table>

 		  
		  </div>

			 
			<script>

			function findAddr(){
				new daum.Postcode({
			        oncomplete: function(data) {
			        	
			        	console.log(data);
			        	
			            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			            var roadAddr = data.roadAddress; // 도로명 주소 변수
			            var jibunAddr = data.jibunAddress; // 지번 주소 변수
			            // 우편번호와 주소 정보를 해당 필드에 넣는다.
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
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="email" name="email" placeholder="이메일">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >가 &nbsp;입</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>

</html>
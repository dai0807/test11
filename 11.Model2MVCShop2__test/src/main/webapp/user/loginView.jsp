<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


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
	
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	
	
	
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Song+Myung&family=Source+Serif+Pro:wght@600&display=swap" rel="stylesheet">
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
        
       .text-center{font-family: 'Source Serif Pro', serif;}
        
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});	
		
		
		//============= 회원원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		
		

		KaKao.init('1168879765a4d95dba3517e139b1ea14');  //발급중 자바스크립스 키
		console.log(Kakao.isInitialized()); // sdk초기화여부판단


		function kakaoLogin() {
		    Kakao.Auth.login({
		  		scope:'profile,account_email',
		  		success: function(authObj){
		  			console.log(authObj);
		  		   Kakao.API.request({   ///v1/user/me 로그인한 사용자 정보 가져옴
		  		        url: '/v1/user/me',
		  		      success: function (res) {
		   	        	  const kakao_account = res.kakao_account ;
		   	        	  console.log(kakao_account) ;
		  	          } 
		  				
		  			}); // 리퀘스트 요청
		  		}
		    	
		    });
		  }	
		
		
		
	</script>		
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Fait Main</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
			 	 	<br/>
					<img src="/images/faitMain2.PNG" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					    </div>
					  </div>
						
						
						<!--  카카오 로그인  -->
							<a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=f0b36852932e865ae00c9ff2fcd19874&redirect_uri=http://localhost:8080/user/kakaoLogin&response_type=code">
							<!-- REST_API키 및 REDIRECT_URi는 본인걸로 수정하세요 -->
							<!-- 저는 redirect_uri을 http://localhost:8080/member/kakaoLogin로 했습니다. -->
							<!-- 본인걸로 수정 시 띄어쓰기 절대 하지 마세요. 오류납니다. -->
							
								<img src="/images/kakao_login_medium_narrow.png" style="height:60px">
						      		<!-- 이미지는 카카오 개발자센터에서 제공하는 login 이미지를 사용했습니다. -->
						
							</a>
						
			
					</form>
			   	 </div>
			 
			
			</div>
			
  	 	</div>
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>
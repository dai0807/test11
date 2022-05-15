<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


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

		//============= "�α���"  Event ���� =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID �� �Է����� �����̽��ϴ�.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});	
		
		
		//============= ȸ��������ȭ���̵� =============
		$( function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		
		

		KaKao.init('1168879765a4d95dba3517e139b1ea14');  //�߱��� �ڹٽ�ũ���� Ű
		console.log(Kakao.isInitialized()); // sdk�ʱ�ȭ�����Ǵ�


		function kakaoLogin() {
		    Kakao.Auth.login({
		  		scope:'profile,account_email',
		  		success: function(authObj){
		  			console.log(authObj);
		  		   Kakao.API.request({   ///v1/user/me �α����� ����� ���� ������
		  		        url: '/v1/user/me',
		  		      success: function (res) {
		   	        	  const kakao_account = res.kakao_account ;
		   	        	  console.log(kakao_account) ;
		  	          } 
		  				
		  			}); // ������Ʈ ��û
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
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
		 	 		<h1 class="text-center">�� &nbsp;&nbsp;�� &nbsp;&nbsp;��</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">�� �� ��</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="���̵�" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">�� �� �� ��</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="�н�����" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >�� &nbsp;�� &nbsp;��</button>
					      <a class="btn btn-primary btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>
					    </div>
					  </div>
						
						
						<!--  īī�� �α���  -->
							<a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=f0b36852932e865ae00c9ff2fcd19874&redirect_uri=http://localhost:8080/user/kakaoLogin&response_type=code">
							<!-- REST_APIŰ �� REDIRECT_URi�� ���ΰɷ� �����ϼ��� -->
							<!-- ���� redirect_uri�� http://localhost:8080/member/kakaoLogin�� �߽��ϴ�. -->
							<!-- ���ΰɷ� ���� �� ���� ���� ���� ������. �������ϴ�. -->
							
								<img src="/images/kakao_login_medium_narrow.png" style="height:60px">
						      		<!-- �̹����� īī�� �����ڼ��Ϳ��� �����ϴ� login �̹����� ����߽��ϴ�. -->
						
							</a>
						
			
					</form>
			   	 </div>
			 
			
			</div>
			
  	 	</div>
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>
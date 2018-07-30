<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 추가하기</title>
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript">
	$(function(){
		$("#container > form ").submit(function(){
			var bool=true;
			$("tr>td").each(function(){  //[td,td,tdtd,td...] 길이만큼 each가 function 실행
				if($(this).children("input").val()==""){
					alert($(this).children("input").attr("name")+"을 입력하세요.")
					$(this).children("input").focus(); //바로 입력할 수 있게 커서 준다.
					bool=false; //submit이벤트 취소 위해 값 저장
					return false; //each에 구현된 함수 종료
				}
				
			});
			return bool;
		});
		
	});

</script>
</head>
<body>
<div id="container">
<h1>새글 추가하기</h1>
	<form action="insertboard.do" method="post">
		<table class="table table-striped"> 
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" class="form-control"/></td>		
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" class="form-control"/></td>		
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="60" name="content" class="form-control"></textarea></td>		
		</tr>
		<tr>
			<td colspan="2">
				<input class="btn btn-primary btn-sm" type="submit" value="글추가"/>
				<input class="btn btn-default btn-sm" type="button" value="목록" onclick="boardList()"/>
			</td>		
		</tr>
		
		</table>
	
	</form>


</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
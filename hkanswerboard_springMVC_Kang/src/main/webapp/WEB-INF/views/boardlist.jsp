<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글목록보기</title>
<jsp:include page="header.jsp"/>
<!-- <script type="text/javascript" src="js/paging.js"></script> -->
<script type="text/javascript">

	//여러글 삭제시 체크박스 유효값처리 (체크가 하나라도 되어 있어야 삭제 실행)
	$(function(){		
		
		//ajax처리
		$("table td>a").hover(function(){
			// a->td->td->td
			var seq=$(this).parent().prev().prev().text();
			$.ajax({
				url:"contentAjax.do",
				data:"seq="+seq,
				dataType:"json",
				type:"post",
				success:function(obj){
					var dto=obj["dto"];
					$("textarea[name=testAjax]").val(dto["content"]);
				},
				error:function(){
					alert("서버통신 실패!!");
				}				
			});
		},function(){
			$("textarea[name=testAjax]").val("");
			
		});
		
		
		
		$("#container > form").submit(function(){
			var bool=false;
			
			$("input[name=chk]").each(function(){
				if($(this).prop("checked")){
					bool=true;
					return;
				}
			});//each : chk인 체크박스가 모두 체크 안되어 있는지 여부 
			
			if(!bool){
				alert("최소하나이상 체크하세요");
			}
			return bool;
		});//submit
		
		//삭제된 글에 해당하는 체크박스 비활성화 
		$(".delboard").each(function(){
		 	//핵심 탐색 기법: tree탐색 --> 부모의 자식에 형제에 자식에 엘리먼를 구하는 ...
              $(this).parent("tr").children().eq(0)
              .find("input").attr("disabled","disabled");			
		});
		
		//답변형을 위한 속성 refer,step,depth,delflag를 감추는 기능
		//slice()
		$("#container > h1 > small").click(function(){
			$("th").slice(6,10).toggle();
			$("tr").each(function(){
				$(this).children("td").slice(6,10).toggle();
			});
		});
// 		pageview();
	
	
	
	});
	
	//새글작성 폼으로 이동
	function insertForm(){
		location.href="insertForm.do";
	}
	//전체선택 체크박스 기능
	function allSel(bool){
		$("input[name=chk]").prop("checked",bool);
	}
	
</script>
<style type="text/css">
	input[type=checkbox]{width: 15px; height: 15px;}
</style>
</head>
<body>
<jsp:useBean id="util" class="com.hk.utils.Util" />
<div id="container">
<h1>게시글 목록 <small style="cursor: pointer;" title="게시판속성보기">답변형게시판</small></h1>

<textarea rows="2" cols="60" name="testAjax"></textarea>

<form action="muldel.do" method="post">
	<input type="hidden" name="command" value="muldel"/>	
	<table class="table table-striped">
		<col width="50px"/><col width="50px"/><col width="100px"/>
		<col width="300px"/><col width="100px"/><col width="100px"/>
		<col width="50px"/><col width="50px"/><col width="50px"/><col width="50px"/>
		<tr>
			<th><input class="form-control" type="checkbox" name="all" onclick="allSel(this.checked)"/></th>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>refer</th>
			<th>step</th>
			<th>depth</th>
			<th>삭제</th>
		</tr>
		<c:choose>
			<c:when test="${empty lists}">
				<tr><td colspan="10">---작성된 글이 없습니다.---</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${lists}">
					<tr>
						<td><input class="form-control" type="checkbox" name="chk" value="${dto.seq}"/></td>
						<td>${dto.seq}</td>
						<td>${dto.id}</td>
						<c:choose>
							<c:when test="${dto.delflag=='Y'}">
								<td class="delboard">---삭제된 글입니다.---</td>
							</c:when>
							<c:otherwise>
								<td>
									<jsp:setProperty value="${dto.depth}" property="arrowNbsp" name="util"/>
									<jsp:getProperty property="arrowNbsp" name="util"/>
									<a href="boarddetail.do?count=count&seq=${dto.seq}">
								    	${dto.title}
								    </a>
								</td>								
							</c:otherwise>
						</c:choose>
						<td>${dto.regdate}</td>
						<td>${dto.readcount}</td>
						<td>${dto.refer}</td>
						<td>${dto.step}</td>
						<td>${dto.depth}</td>
						<td>${dto.delflag}</td>
					</tr>
				</c:forEach>			
			</c:otherwise>
		</c:choose>
		<tr>
			<td colspan="10">
				<input type="button" class="btn btn-primary" value="글추가" onclick='insertForm()'/>
				<input type="submit" class="btn btn-danger" value="삭제" />
			</td>
		</tr>
	</table>
</form>
</div>
<jsp:include page="footer.jsp"/>

</body>
</html>
<%-- <a href="anscontroller.jsp?command=boardlist&pnum=${papEndnum-5==0?1:papEndnum-5}">◀</a>			 		 --%>
<%-- 			 	<c:forEach begin="${papEndnum-4}" end="${papEndnum>pcount?pcount:papEndnum}" step="1" var="i"> --%>
<%-- 			 		<a class="p" href="anscontroller.jsp?command=boardlist&pnum=${i}">${i}</a>			 	 --%>
<%-- 			 	</c:forEach> --%>
<%-- 				<a href="anscontroller.jsp?command=boardlist&pnum=${papEndnum>pcount?pcount:papEndnum+1}">▶</a>	 --%>





<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section id="main">
  <img src="${pageContext.request.contextPath }/resources/img/comm.gif">
  <h2 id="board_title">공동구매 상품게시판 </h2>
  <div id="write_title"><h2>글수정</h2></div>
  <!-- 파일업로드시 .. method랑 enctype지정 -->
  <form action="${pageContext.request.contextPath }/fleemarket/updateFleeMarketProcess.do" method="post" enctype="multipart/form-data">
  <table>
    <tr id="name">
      <td class="col1">판매자</td>
      <td class="col2">${data.sellerVO.seller_name}</td>
    </tr>
    <tr id="subject">
      <td class="col1">상품명</td>
      <td class="col2"><input type="text" name="fleemarket_title" id="fleemarket_title" value="${data.fleeMarketVO.fleemarket_title}"></td>
    </tr>		
    <tr id="content">
      <td class="col1">내용</td>
      <td class="col2"><textarea name="fleemarket_content" id="fleemarket_content">${data.fleeMarketVO.fleemarket_content}</textarea></td>
    </tr>		
    <tr id="upload">
      <td class="col1">파일 업로드</td>
      <td class="col2"><input type="file" accept="image/*" name="upload_files" multiple>${data.fleeMarketImageList}</td>
    </tr>
    <input type="hidden" name="fleemarket_no" value="${data.fleeMarketVO.fleemarket_no }">
    <input type="hidden" name="fleemarket_readcount" value="${data.fleeMarketVO.fleemarket_readcount }">	
    <input type="hidden" name="flfeemarket_writedate" value="${data.fleeMarketVO.fleemarket_writedate }">
  </table>
  <div id="buttons">
    <input type="submit" value="수정하기">
    <a href="./sellerMainPage.do"><img src="${pageContext.request.contextPath }/resources/img/list.png">목록으로</a>
  </div>
  </form>
</section>
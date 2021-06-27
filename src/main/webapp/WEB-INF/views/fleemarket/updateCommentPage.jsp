<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   <!--댓글수정 -->
   <form id="updateComment" method="get" action="${pageContext.request.contextPath}/fleemarket/updateCommentProcess.do">
   
      
      
             <select name="lecture_score" value="">
             <option value='' selected>Select your rating</option>
             <option value='5'>★★★★★</option>
             <option value='4'>★★★★☆</option>
             <option value='3'>★★★☆☆</option>
             <option value='2'>★★☆☆☆</option>
             <option value='1' selected="selected">★☆☆☆☆</option>
          </select> 
          
             <input type="hidden" name="fleemarket_no" value=<%=request.getAttribute("fleemarket_no") %>>
            <input type="hidden" name="comment_no" value=<%=request.getAttribute("comment_no") %>>
            <input type="text" name="comment_content" value=<%=request.getAttribute("comment_content") %>>
            <fmt:formatDate value="${reply.replyVO.reply_writedate}" pattern="yyyy.MM.dd HH:mm"/>
            <input type="submit" value="수정하기"> <!-- submit하면 action으로 간다는거! -->
   
      
            <a href="${pageContext.request.contextPath }/commons/loginPage.do">댓글 수정을 위해 로그인이 필요합니다.</a>
      
         
      
   </form>   
  

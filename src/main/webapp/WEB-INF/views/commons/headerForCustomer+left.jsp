<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-3" style="padding-left: 60px;">
			<!-- 마이쇼핑 -->
			<div class="row mb-2" style="color: #5b5b5b; font-size: 22px; font-weight: bold; text-align: left;">MY SHOPPING</div>
			<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
				<a href="${pageContext.request.contextPath }/customer/myPageMain.do" style="color: #6b6b6b;">주문내역조회/배송조회</a>
			</div>
			<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
				<a href="${pageContext.request.contextPath }/customer/myExchangePage.do" style="color: #6b6b6b;">취소/반품/교환</a>
			</div>
				
			<!-- 마이쇼핑 -->
			<div class="row mt-5" style="color: #5b5b5b; font-size: 22px; font-weight: bold; text-align: left;">MY BENEFITS</div>
				<div class="col pt-2 mb-5">
					<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
						<a href="${pageContext.request.contextPath }/customer/myCoupon.do" style="color: #6b6b6b;">마이쿠폰</a>
					</div>
					<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
						<a href="${pageContext.request.contextPath }/customer/myJellyPage.do" style="color: #6b6b6b;">로얄젤리</a>
					</div>
				</div>
			<!-- 마이쇼핑 -->
			<div class="row mt-5" style="color: #5b5b5b; font-size: 22px; font-weight: bold; text-align: left;">MY ACTIVITIES</div>
				<div class="col pt-2 mb-5">
					<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
						<a href="${pageContext.request.contextPath }/customer/writeQnAPage.do" style="color: #6b6b6b;">문의하기</a>
					</div>
					<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
						<a href="${pageContext.request.contextPath }/customer/myCommentPage.do" style="color: #6b6b6b;">구매후기</a>
					</div>
				</div>
			<!-- 마이쇼핑 -->
			<div class="row mt-5" style="color: #5b5b5b; font-size: 22px; font-weight: bold; text-align: left;">MY INFORMATION</div>
				<div class="col pt-2 mb-5">
					<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
						<a href="${pageContext.request.contextPath }/customer/confirmCustomerInformation.do" style="color: #6b6b6b;">개인정보확인/수정</a>
					</div>
					<div class="row" style="color: #BDB76B; font-size: 15px; font-weight: bold; text-align: left;">
						<a href="${pageContext.request.contextPath }/customer/myDeliveryPage.do" style="color: #6b6b6b;">배송지 관리</a>
					</div>
				</div>
		</div>
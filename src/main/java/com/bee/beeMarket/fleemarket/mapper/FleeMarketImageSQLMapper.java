package com.bee.beeMarket.fleemarket.mapper;

import java.util.ArrayList;

import com.bee.beeMarket.vo.FleeMarketImageVO;

public interface FleeMarketImageSQLMapper {
	
	//이미지 삽입
	public void insertImage(FleeMarketImageVO fleeMarketImageVO);
		
	//이미지 가져오기
	public ArrayList<FleeMarketImageVO> selectByFleeMarketNo(int fleemarket_no);
	//공구 장바구니 이미지 가져오기
	public FleeMarketImageVO getFleeMarketImageByNo(int fleemarket_no);
	
}

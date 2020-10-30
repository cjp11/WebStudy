package com.bc.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

public class ShopDAO {
	
	public ShopDAO() {
		System.out.println(">> ShopDAO 생성자로 객체 생성");
	}
	// 제품 카테고리 값으로 제품목록 조회
	public List<ShopVO> list(String category) {
		SqlSession ss = DBService.getFactory().openSession();
		List<ShopVO> list = ss.selectList("list", category);	//"list" : mapper에서 써줄 id명 
		ss.close();												// mapper에서 #{?} -> ?에 들어갈 category값
		return list;
		
	}
	
	public ShopVO selectOne(String pNum) {
		SqlSession ss = DBService.getFactory().openSession();
		ShopVO vo = ss.selectOne("one",pNum);	//shop.one -> namespace 명시해도 됨
		ss.close();
		
		return vo;
	}
}

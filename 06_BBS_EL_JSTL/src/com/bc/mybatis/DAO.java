package com.bc.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class DAO {
	// 게시글(BBS_T)의 전체 건수 조회
	public static int getTotalCount() {
		SqlSession ss = DBService.getFactory().openSession();
		int totalCount = ss.selectOne("BBS.totalCount");
		//System.out.println(DAO.getTotalCount());
		ss.close();
		return totalCount;
	}
	
	// 페이지에 해당하는 글목록(게시글) 가져오기
	public static List<BBSVO> getList(Map<String, Integer> map) {
		SqlSession ss = DBService.getFactory().openSession();
		List<BBSVO> list = ss.selectList("BBS.list",map);
		ss.close();
		return list;
	}
}

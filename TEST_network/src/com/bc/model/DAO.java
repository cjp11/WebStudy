package com.bc.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.bc.model.vo.MemberVO;
import com.bc.mybatis.DBService;

public class DAO {

	//직원 전체 목록 조회
	public static List<MemberVO> getList() {
		SqlSession ss = DBService.getFactory().openSession();
		List<MemberVO> list = ss.selectList("member.selectAllMember");
		ss.close();
		return list;
	}
	
	//직원 정보 조회
	public static MemberVO selectMember(String id) {
		SqlSession ss = DBService.getFactory().openSession();
		MemberVO member = ss.selectOne("member.selectOneMember", id);
		ss.close();
		return member;
	}

	//아이디, 패스워드 값으로 등록 회원 정보 확인
	public static MemberVO checkIdPassword(String id, String password) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);
		SqlSession ss = DBService.getFactory().openSession();
		MemberVO member = ss.selectOne("member.checkIdPassword", map);
		ss.close();
		return member;
	}

	//직원 정보 입력
	public static int insertMember(MemberVO member) {
		SqlSession ss = DBService.getFactory().openSession();
		
		//List<MemberVO> list = getList();
		//System.out.println(list);
		// 등록된 회원이 아니며 모든 값들이 not null인 경우, 회원가입 성공 -> return 1
		
		if(member.getId() != null && member.getPassword() != null 
				&& member.getName() != null && member.getEmail() != null) {
			ss.insert("member.insertMember",member);
			//System.out.println(member.getId());
			//list.add(member);
			ss.commit();
			ss.close();
			return 1;
			
		// member 값들이 null이 있는지 확인 있으면 회원가입 실패 -> return 0
		// 회원 아이디가 같은 경우 회원가입 실패 -> return 0
		} else {
			System.out.println("값을 넣지 않은 값들이 있음");
			ss.close();
			return 0;
		}
		
		
		
	}


}













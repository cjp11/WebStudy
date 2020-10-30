package com.bc.mybatis;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {
	private List<ShopVO> list; //카트에 담긴 제품 목록
	private int total; //카트에 담긴 전체 품목의 가격 합계 금액
	
	public Cart() {
		list = new ArrayList<ShopVO>();
	}
	
	public List<ShopVO> getList() {
		return list;
	}

	public int getTotal() {
		return total;
	}
	/* 장바구니에 담기 요청 처리(카트에 제품 추가)
	 * list에 없으면 제품 추가
	 * list에 동일한 제품이 있으면 수량 1개 증가 처리
	 */
	public void addProduct(String pNum, ShopDAO dao) {
		//카트에 동일 제품 있는지 확인
		ShopVO vo = findProduct(pNum);
		if(vo == null) {	// 카트에 없음 -> 제품을 카트에 등록, total 다시 처리
			vo = dao.selectOne(pNum);	//1. db 데이터 조회
			vo.setQuant(1);				//2, VO 객체 수량 설정
			list.add(vo);				//3. 카트 목록(list)에 추가
			total += vo.getP_saleprice();	// 4. 카트 총합에 제품 하나 가격 추가
			
		} else {	// 카트에 있늠 -> 수량 1 증가 처리, total 다시 처리
			vo.setQuant(vo.getQuant()+1);
			total += vo.getP_saleprice();
		}
	}
	// 카트에 제품이 있으면 VO리턴, 없으면: null 리턴
	public ShopVO findProduct(String pNum) {
		ShopVO vo = null;
		Iterator<ShopVO> ite = list.iterator();
		while(ite.hasNext()) {
			ShopVO listVO = ite.next();
			if(listVO.getP_num().equals(pNum)) {
				vo = listVO;
				break;
			}
		}
		
		return vo;
	}
	
	public void editQuant(String pNum, int su) {
		ShopVO vo = findProduct(pNum);
		// 변경 전 카트 금액 - 수량 변경 전 수정할 제품 합계 금액
		total -= vo.getTotalprice();
		if(vo != null) {
			vo.setQuant(su);
			total += vo.getTotalprice();
			//vo.setTotalprice(total); -> 게시물에 총 합계가 반영이 안됨
			// 수량 변경 후 총 금액
			System.out.println(vo.getTotalprice());
		}
		
	}
	
	public void delProduct(String pNum) {
		ShopVO vo = findProduct(pNum);
		if(vo != null) {
			total -= vo.getTotalprice();	
			list.remove(vo);		// 객체 연결만 끊어지므로 이 라인을 위에 써도 상관없음
		}
	}
}


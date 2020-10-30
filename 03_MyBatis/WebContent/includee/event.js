	function sel_all(frm) {	// 전체 데이터 조회
		frm.action = "selectAll.jsp";
		frm.submit();
	}
	function sel_one(frm) {	// 전체 데이터 조회
		frm.action = "selectOneID.jsp";
		frm.submit();
	}
	function add_go(frm) {	// 전체 데이터 조회
		if(frm.id.value.trim() == "") {	// 값이 들어오지 않으면
			alert("아이디(ID)는 필수 입력항목입니다.\n 입력하세요!");
			frm.id.value = "";	// 스페이스가 들어올 수도 있으므로 초기화
			frm.id.focus();
			return false;		// 요청처리 취소
		}
	
		frm.action = "insertMember.jsp";
		frm.submit();
	}
	function del_go(frm) {	
		if(frm.id.value.trim() == "") {	// 값이 들어오지 않으면
			alert("삭제할 아이디(ID)는 필수 입력항목입니다.\n 입력하세요!");
			frm.id.value = "";	// 스페이스가 들어올 수도 있으므로 초기화
			frm.id.focus();
			return false;		// 요청처리 취소
		}
		frm.action = "deleteMember.jsp";
		frm.submit();
	}
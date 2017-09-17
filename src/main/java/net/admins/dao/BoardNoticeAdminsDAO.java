package net.admins.dao;

import java.util.List;
import java.util.Map;

import net.common.dao.AbstractDAO;

import org.springframework.stereotype.Repository;

@Repository("boardNoticeAdminsDAO")
public class BoardNoticeAdminsDAO extends AbstractDAO {

	// Abstrat로 변경

	// ///////////////////////////////////BoardNews/////////////////////////////////////

	/*
	 * ========================================등록================================
	 * ========
	 */

	public void insertNtmForm(Map<String, Object> map) {
		// TODO Auto-generated method stub

		insert("boardNoticeAdminsDAO.insertNtmForm", map);
	}

	/*
	 * ========================================보기================================
	 * ========
	 */

	// updateHitCnt 연관
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectOneNtmView(Map<String, Object> map) {
		// TODO Auto-generated method stub

		return (Map<String, Object>) selectOne(
				"boardNoticeAdminsDAO.selectOneNtmView", map);
	}

	/*
	 * ========================================수정================================
	 * ========
	 */

	public Map<String, Object> updateNtmform(Map<String, Object> map) {
		// TODO Auto-generated method stub
	
		return (Map<String, Object>) selectOne("boardNoticeAdminsDAO.updateNtmform", map);
	}
	
	public void updateProNtmform(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("boardNoticeAdminsDAO.updateProNtmform", map);
	}
	// 조회수 증가
	public void updateNtmHitCnt(Map<String, Object> map) throws Exception {
		update("boardNoticeAdminsDAO.updateNtmHitCnt", map);
	}

	/*
	 * ========================================리스트(SelectOne, SelectList
	 * 순)========================================
	 */

	public int selectOneGetNtmTotalCount() {
		// TODO Auto-generated method stub
		return (int) selectOne("boardNoticeAdminsDAO.selectOneGetNtmTotalCount");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectListNtmFrontList(
			Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList(
				"boardNoticeAdminsDAO.selectListNtmFrontList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectListNtmList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) selectList(
				"boardNoticeAdminsDAO.selectListNtmList", map);

	}

	/*
	 * ========================================삭제================================
	 * ========
	 */

	public void deleteNtmDelete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("boardNoticeAdminsDAO.deleteNtmDelete", map);
	}

}

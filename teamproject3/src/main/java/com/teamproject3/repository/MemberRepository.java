package com.teamproject3.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.teamproject3.vo.Member;

@Repository
public class MemberRepository implements CommonRepository<Member> {
	
	private static final String MEMBER_NAMESPACE = "com.teamproject3.mapper.MemberMapper";
	
	@Inject
	SqlSession sqlSession;

	/*
	 * 모든 사용자 정보를 가져옵니다
	 * 관리자만 접근 가능한 메서드
	 */
	@Override
	public List<Member> selectAll() {
		return sqlSession.selectList(MEMBER_NAMESPACE.concat(".selectAll"));
	}

	/*
	 * 파라미터를 가지고 사용자들을 가져옵니다
	 */
	@Override
	public List<Member> selectAll(Object... objects) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", objects[0]);
		params.put("end", objects[1]);
		params.put("searchOption", objects[2]);
		params.put("searchValue", objects[3]);
		return sqlSession.selectList(MEMBER_NAMESPACE.concat(".selectAll"), params);
	}

	/*
	 * 이메일(기본키)을 가지고 회원 정보를 가져옵니다
	 * deleted 칼럼이 true일 경우(탈퇴 처리된 사용자), null을 반환합니다.
	 */
	@Override
	public Member selectById(Object email) {
		return sqlSession.selectOne(MEMBER_NAMESPACE.concat(".selectById"), email);
	}

	/*
	 * 회원가입 메서드입니다
	 */
	@Override
	public void insert(Member member) {
		sqlSession.insert(MEMBER_NAMESPACE.concat(".insert"), member);
	}

	/*
	 * 회원 정보를 수정하는 메서드입니다
	 */
	@Override
	public void update(Member member) {
		sqlSession.update((MEMBER_NAMESPACE).concat(".update"), member);
	}

	/*
	 * 회원 탈퇴 메서드입니다 실제 튜플을 삭제하지 않으며, deleted 칼럼은 true로 바꿉니다.
	 */
	@Override
	public void delete(Object email) {
		sqlSession.update(MEMBER_NAMESPACE.concat(".delete"), email);
	}

	/*
	 * 사용자 수를 가져옵니다.
	 */
	public int count(String searchOption, String searchValue) {
		Map<String, Object> params = new HashMap<>();
		params.put("searchOption", searchOption);
		params.put("searchValue", searchValue);
		return sqlSession.selectOne(MEMBER_NAMESPACE.concat(".count"), params);
	}
	
	// 프로필 이미지를 변경합니다.
	public void saveProfileImage(Member member) {
		sqlSession.update(MEMBER_NAMESPACE.concat(".saveProfileImage"), member);
	}
	
	// 이메일로 프로필 이미지를 불러옵니다.
	public String selectProfileImageById(String email) {
		return sqlSession.selectOne(MEMBER_NAMESPACE.concat(".selectProfileImageById"), email);
	}
	
	// 사용자를 삭제합니다.
	public void delete(String email) {
		sqlSession.update(MEMBER_NAMESPACE.concat(".delete"), email);
	}
	
	// 사용자 계정을 비활성 상태로 만듭니다.
	public void inactivate(String email) {
		sqlSession.update(MEMBER_NAMESPACE.concat(".inactivate"), email);
	}
	
	// 사용자 계정을 복구합니다
	public void recover(String email) {
		sqlSession.update(MEMBER_NAMESPACE.concat(".recover"), email);
	}
	
	// 사용자 계정을 활성 상태로 만듭니다.
	public void activate(String email) {
		sqlSession.update(MEMBER_NAMESPACE.concat(".activate"), email);
	}

	public int countQuestionById(String email) {
		return sqlSession.selectOne(MEMBER_NAMESPACE.concat(".countQuestionById"), email);
	}

	@Override
	public int count(Object... objects) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}

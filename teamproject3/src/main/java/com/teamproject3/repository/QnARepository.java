package com.teamproject3.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.teamproject3.vo.QnA;

@Repository
public class QnARepository implements CommonRepository<QnA> {
	
	private static final String NAMESPACE = "com.teamproject3.mapper.QuestionMapper";
	
	@Inject
	SqlSession sqlSession;

	/*
	 * 아무 조건 없는 select는 사용하지 않음.
	 */
	@Deprecated
	@Override
	public List<QnA> selectAll() {
		return null;
	}
	
	/*
	 * 관리자용
	 */
	@Override
	public List<QnA> selectAll(Object... objects) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", objects[0]);
		params.put("end", objects[1]);
		params.put("searchOption", objects[2]);
		params.put("searchValue", objects[3]);
		params.put("completed", objects[4]);
		return sqlSession.selectList(NAMESPACE.concat(".selectAll"), params);
	}

	@Override
	public QnA selectById(Object pk) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(QnA qna) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(QnA qna) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Object qnaNo) {
		// TODO Auto-generated method stub
		
	}
	
	public int count(String searchOption, String searchValue, String completed) {
		Map<String, Object> params = new HashMap<>();
		params.put("searchOption", searchOption);
		params.put("searchValue", searchValue);
		params.put("completed", completed);
		return sqlSession.selectOne(NAMESPACE.concat(".count"), params);
	}

	public int insertQnA(QnA qnA) {
		sqlSession.insert(NAMESPACE.concat(".insert"), qnA);
		return qnA.getQnaNo();
	}

	public void answerQuestion(int qnaNo, String answerText) {
		Map<String, Object> params = new HashMap<>();
		params.put("qnaNo", qnaNo);
		params.put("answerText", answerText);
		sqlSession.update(NAMESPACE.concat(".answer"), params);
	}
	
	public void setCompleted(int qnaNo) {
		sqlSession.update(NAMESPACE.concat(".setCompleted"), qnaNo);
	}

	@Override
	public int count(Object... objects) {
		// TODO Auto-generated method stub
		return 0;
	}

}

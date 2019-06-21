package com.teamproject3.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject3.repository.QnARepository;
import com.teamproject3.vo.QnA;

@Service
public class QnAService {
	
	@Inject
	QnARepository qnARepository;
	
	private static final String SUCCESS = "success";
	private static final String FAILED = "failed";
	
	public List<QnA> findAll(int start, int end, String searchOption, String searchValue, String completed) {
		return qnARepository.selectAll(start, end, searchOption, searchValue, completed);
	}
	
	public int count(String searchOption, String searchValue, String completed) {
		return qnARepository.count(searchOption, searchValue, completed);
	}
	
	public int registerQnA(QnA qnA) {
		int newQnaNo = qnARepository.insertQnA(qnA);
		return newQnaNo;
	}

	
	public String answerQuestion(String json) {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> params = new HashMap<>();
		
		try {
			params = mapper.readValue(json, new TypeReference<Map<String, Object>>(){});
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		
		int qnaNo = Integer.parseInt((String)params.get("qnaNo"));
		String answerText = (String)params.get("answerText");
		
		try {
			qnARepository.answerQuestion(qnaNo, answerText);
			qnARepository.setCompleted(qnaNo);
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}

		return SUCCESS;
	}
}

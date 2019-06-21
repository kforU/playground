package com.teamproject3.util;

import java.util.LinkedHashMap;
import java.util.Map;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Pagination {
	
	private int pageSize; // 페이지 사이즈, 한 페이지에서 글의 갯수
	private int blockSize; // 블럭 사이즈, pagination 칸에 들어갈 페이지들의 수
	
	int totThread; // 총 게시글
	
	int page; // 현재 페이지
	int totPage; // 총 페이지
	int pageBegin; // 현재 페이지에서 시작 글 번호
	int pageEnd; // 현재 페이지에서 끝 글 번호
	
	int block; // 현재 블럭
	int totBlock; // 총 블럭
	int blockBegin; // 현재 블럭에서 시작 페이지 번호
	int blockEnd; // 현재 블럭에서 끝 페이지 번호
	
	int prevBlock; // 이전 블럭의 마지막 페이지
	int nextBlock; // 다음 블럭의 첫 페이지
	
	public Pagination(int page, int totThread, int pageSize, int blockSize) {
		// pageSize, blockSize, page는 0 이하의 값은 말이 안됨
		this.pageSize 	= pageSize < 1 ? 10 : pageSize;
		this.blockSize 	= blockSize < 1 ? 10 : blockSize;
		this.page 		= page < 1 ? 1 : page;
		// totThread는 0개일 수 있으나, 음수값은 말이 안됨
		this.totThread 	= totThread < 0 ? 0 : totThread;
		
		initPages();
		initBlocks();
	}

	private void initPages() {
		// 총 페이지 수 계산 (허용값 1 ~ 양수)
		totPage = (int) Math.ceil((totThread * 1.0) / pageSize);
		totPage = totPage == 0 ? 1 : totPage;
		
		// 현재 페이지의 시작 글 번호 계산 (글이 없으면 0이 될 수 있음)
		pageBegin = (page - 1) * pageSize + 1;
		pageBegin = pageBegin < 0 ? 0 : pageBegin;
		
		// 현재 페이지의 끝 글 번호 계산
		pageEnd = pageBegin + pageSize - 1;
		pageEnd = pageEnd > totThread ? totThread : pageEnd;
	}

	private void initBlocks() {
		// 현재 블럭 계산
		block = (page - 1) / blockSize + 1;
		
		// 총 블럭 수 계산
		totBlock = (int) Math.ceil(totPage * 1.0 / blockSize);
		
		// 블럭에서 시작 페이지 번호 계산(0 이하는 허용할 수 없음)
		blockBegin = ((page - 1) / blockSize) * blockSize + 1;
		blockBegin = blockBegin < 1 ? 1 : blockBegin;
		
		// 블럭에서 끝 페이지 번호 계산(총 블럭 수 이상은 허용할 수 없음)
		blockEnd = blockBegin + blockSize - 1;
		blockEnd = blockEnd > totPage ? totPage : blockEnd;
		
		// 이전 블럭의 마지막 페이지 계산
		prevBlock = (block - 1) * blockSize;
		prevBlock = prevBlock < 1 ? 1 : prevBlock;
		
		// 다음 블럭의 첫 페이지 계산
		nextBlock = block * blockSize + 1;
		nextBlock = nextBlock > totPage ? totPage : nextBlock;
	}
	
	// 결과를 jsp에서 쓰기 쉽게 Map객체로 반환
	public Map<String, Integer> getResultAsMap() {
		
		Map<String, Integer> resultMap = new LinkedHashMap<String, Integer>();
		resultMap.put("page", page);
		resultMap.put("totPage", totPage);
		resultMap.put("pageBegin", pageBegin);
		resultMap.put("pageEnd", pageEnd);
		resultMap.put("blockBegin", blockBegin);
		resultMap.put("blockEnd", blockEnd);
		resultMap.put("block", block);
		resultMap.put("totBlock", totBlock);
		resultMap.put("prevBlock", prevBlock);
		resultMap.put("nextBlock", nextBlock);
		return resultMap;
		
	}

}

package com.teamproject3.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.teamproject3.vo.Ticket;
import com.teamproject3.vo.TicketOrder;

@Repository
public class TicketOrderRepository implements CommonRepository<TicketOrder> {
	
	@Inject SqlSession sqlSession;
	private static final String TICKET_NAMESPACE = "com.teamproject3.mapper.TicketOrderMapper";
	
	@Deprecated
	@Override
	public List<TicketOrder> selectAll() {
		return null;
	}
	@Override
	public List<TicketOrder> selectAll(Object... objects) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", objects[0]);
		params.put("end", objects[1]);
		params.put("searchOption", objects[2]);
		params.put("searchValue", objects[3]);
		List<TicketOrder> result = sqlSession.selectList(TICKET_NAMESPACE.concat(".selectAll"), params);
		return result;
	}
	@Override
	public TicketOrder selectById(Object ticketOrderNo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void insert(TicketOrder ticketOrder) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void update(TicketOrder ticketOrder) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void delete(Object ticketOrderNo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public int count(Object... objects) {
		Map<String, Object> params = new HashMap<>();
		params.put("searchOption", objects[0]);
		params.put("searchValue", objects[1]);
		return sqlSession.selectOne(TICKET_NAMESPACE.concat(".count"), params);
	}
	
	public void approveTicket(int ticketOrderNo) {
		sqlSession.update(TICKET_NAMESPACE.concat(".approveTicket"), ticketOrderNo);
	}
	
	// 존재하는 모든 티켓을 가져옴
	public List<Ticket> selectAllTicket() {
		return sqlSession.selectList(TICKET_NAMESPACE.concat(".selectAllTicket"));
	}

	public void insertTicket(TicketOrder vo) {
		
		sqlSession.insert(TICKET_NAMESPACE.concat(".insertTicketOrder"), vo);
		
	}
	
}

package com.teamproject3.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.teamproject3.mapper.ProductOrderMapper;
import com.teamproject3.vo.ProductOrder;

@Repository
public class ProductOrderRepository implements CommonRepository<ProductOrder> {
	
	private SqlSessionTemplate sessionTemplate;
	public SqlSessionTemplate getSessionTemplate() {
		return sessionTemplate;
	}	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}
	
	private ProductOrderMapper productOrderMapper;

	public ProductOrderMapper getProductOrderMapper() {
		return productOrderMapper;
	}
	public void setProductOrderMapper(ProductOrderMapper productOrderMapper) {
		this.productOrderMapper = productOrderMapper;
	}
	
	private static final String PRODUCT_ORDER_NAMESPACE = "com.teamproject3.mapper.ProductOrderMapper";
	
	@Inject
	SqlSession sqlSession;

	@Override
	public List<ProductOrder> selectAll() {
		return null;
	}

	@Override
	public List<ProductOrder> selectAll(Object... objects) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", objects[0]);
		params.put("end", objects[1]);
		params.put("approved", objects[2]);
		params.put("email", objects[3]);
		return sqlSession.selectList(PRODUCT_ORDER_NAMESPACE.concat(".selectAll"), params);
	}

	@Override
	public ProductOrder selectById(Object pk) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(ProductOrder t) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(ProductOrder t) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Object pk) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int count(Object... objects) {
		Map<String, Object> params = new HashMap<>();
		params.put("approved", objects[0]);
		return sqlSession.selectOne(PRODUCT_ORDER_NAMESPACE.concat(".count"), params);
	}

	public int insertProductOrder(ProductOrder productOrder) {
		
		productOrderMapper.insertProductOrder(productOrder);
			
		return productOrder.getProductOrderNo();
	}
	
}

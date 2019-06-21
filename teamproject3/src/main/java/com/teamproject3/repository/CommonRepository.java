package com.teamproject3.repository;

import java.util.List;

public interface CommonRepository<T>{
	
	List<T> selectAll(); 
	List<T> selectAll(Object...objects);
	T selectById(Object pk);
	void insert(T t);
	void update(T t);
	void delete(Object pk);
	int count(Object...objects);
	
}

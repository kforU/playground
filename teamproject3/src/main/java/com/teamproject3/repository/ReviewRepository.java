package com.teamproject3.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.teamproject3.vo.Comment;
import com.teamproject3.vo.Review;

public class ReviewRepository {
	private static final String Review_namespace = "com.teamproject3.mapper.ReviewMapper";
	
	private SqlSessionTemplate sqlSessionTemplate;
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	/*
	 * review 제어
	 * */
	public List<Review> selectReview() {
		List<Review> reviews = sqlSessionTemplate.selectList(Review_namespace.concat(".selectAll"));
		return reviews;
	}
	public void insertReview(Review review) {
		sqlSessionTemplate.insert(Review_namespace.concat(".insert"), review);
		
	}
	public void updateReviewHit(int reviewNo) {
		sqlSessionTemplate.update(Review_namespace.concat(".updateHit"), reviewNo);
		
	}
	
	public Review selectReviewByNo(int reviewNo) {
		Review review = sqlSessionTemplate.selectOne(Review_namespace.concat(".selectOne"),reviewNo);
		return review;
	}
	public void updateReview(Review review) {
		sqlSessionTemplate.update(Review_namespace.concat(".update"), review);
		
	}
	public void deleteReview(int reviewNo) {
		sqlSessionTemplate.delete(Review_namespace.concat(".delete"), reviewNo);
		
	}
	
	
	/*
	 * comment 제어
	 * */
	public void insertComment(Comment comment) {
		sqlSessionTemplate.insert(Review_namespace.concat(".insertComment"), comment);
		
	}
	public List<Comment> selectCommentByReviewNo(int reviewNo) {
		List<Comment> comments = sqlSessionTemplate.selectList(Review_namespace.concat(".selectCommentByReviewNo"), reviewNo);
		return comments;
	}
	public void deleteComment(int commentNo) {
		sqlSessionTemplate.delete(Review_namespace.concat(".deleteComment"), commentNo);
		
	}
	public void updateComment(Comment comment) {
		sqlSessionTemplate.update(Review_namespace.concat(".updateComment"), comment);
		
	}
}

package com.teamproject3.service;

import java.util.List;

import com.teamproject3.repository.ReviewRepository;
import com.teamproject3.vo.Comment;
import com.teamproject3.vo.Review;

public class ReviewServiceImpl implements ReviewService{
	
	private ReviewRepository reviewRepository;
	public ReviewRepository getReviewRepository() {
		return reviewRepository;
	}
	public void setReviewRepository(ReviewRepository reviewRepository) {
		this.reviewRepository = reviewRepository;
	}
	
	@Override
	public List<Review> findReview() {
		List<Review> reviews = reviewRepository.selectReview();
		return reviews;
	}
	@Override
	public void register(Review review) {
		reviewRepository.insertReview(review);
		
	}
	@Override
	public void updateReviewHit(int reviewNo) {
		reviewRepository.updateReviewHit(reviewNo);
		
	}
	@Override
	public Review findReviewByNo(int reviewNo) {
		Review review = reviewRepository.selectReviewByNo(reviewNo);
		
		return review;
	}
	@Override
	public void updateReview(Review review) {
		reviewRepository.updateReview(review);
		
	}
	@Override
	public void deleteReview(int reviewNo) {
		reviewRepository.deleteReview(reviewNo);
		
	}
	
	// **********comment***********
	
	@Override
	public void writeComment(Comment comment) {
		reviewRepository.insertComment(comment);
		
	}
	@Override
	public List<Comment> findCommentListByReviewNo(int reviewNo) {
		List<Comment> comments = reviewRepository.selectCommentByReviewNo(reviewNo);
		return comments;
	}
	@Override
	public void deleteComment(int commentNo) {
		reviewRepository.deleteComment(commentNo);
		
	}
	@Override
	public void updateComment(Comment comment) {
		reviewRepository.updateComment(comment);
		
	}

	 
	
	
}

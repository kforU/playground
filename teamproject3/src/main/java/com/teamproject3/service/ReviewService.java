package com.teamproject3.service;

import java.util.List;

import com.teamproject3.vo.Comment;
import com.teamproject3.vo.Review;

public interface ReviewService {

	List<Review> findReview();

	void register(Review review);

	void updateReviewHit(int reviewNo);

	Review findReviewByNo(int reviewNo);

	void updateReview(Review review);

	void deleteReview(int reviewNo);

	void writeComment(Comment comment);

	List<Comment> findCommentListByReviewNo(int reviewNo);

	void deleteComment(int commentNo);

	void updateComment(Comment comment);

	

}
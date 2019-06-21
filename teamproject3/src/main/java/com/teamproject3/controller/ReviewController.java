package com.teamproject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject3.service.ReviewService;
import com.teamproject3.vo.Comment;
import com.teamproject3.vo.Review;

@Controller
@RequestMapping("/review/")
public class ReviewController {
	
	@Autowired
	@Qualifier("reviewService")
	private ReviewService reviewService;
	
	@RequestMapping(path="review", method= RequestMethod.GET)
	public String ReviewPage(Model model) {
		
		List<Review> reviews = reviewService.findReview();
		
		model.addAttribute("reviews", reviews);
		
		return "review/review";
	}
	@RequestMapping(path="reviewWrite", method= RequestMethod.GET)
	public String writepage() {
		
		return "review/reviewWrite";
	}
	
	@RequestMapping(path="reviewWrite", method= RequestMethod.POST)
	public String ReviewWrite(Review review) {
		
		reviewService.register(review);
		
		return "review/reviewDetail";
	}
	
	@RequestMapping(path="reviewDetail/{reviewNo}", method= RequestMethod.GET)
	public String detailpage(@PathVariable int reviewNo, Model model) {
		
		reviewService.updateReviewHit(reviewNo);
		Review review = reviewService.findReviewByNo(reviewNo);
		
		List<Comment> comments = reviewService.findCommentListByReviewNo(reviewNo);
		review.setComments(comments);

		model.addAttribute("review", review);
		
		return "review/reviewDetail";
	}
	
	@RequestMapping(path="reviewUpdate/{reviewNo}", method= RequestMethod.GET)
	public String updatepage(@PathVariable int reviewNo, Model model) {
			
		Review review = reviewService.findReviewByNo(reviewNo);
	
		model.addAttribute("review", review);
		
		return "review/reviewUpdate";
	}
	
	@RequestMapping(path="update", method= RequestMethod.POST)
	public String updateReview(Review review) {
		
		reviewService.updateReview(review);
		
		return "redirect:/review/reviewDetail/" + review.getReviewNo();
	}
	
	@RequestMapping(path="reviewdelete/{reviewNo}", method= RequestMethod.GET)
	public String reviewDelete(@PathVariable int reviewNo) {
		
		reviewService.deleteReview(reviewNo);
		
		
		return "redirect:review/review";
	}
	
/* ============================COMMENT CONTROLL===================================== */
	
	@RequestMapping(path = "/write-comment", 
					method = RequestMethod.POST, 
					produces = "text/plain;charset=utf-8") //응답 컨텐츠의 종류 지정
	@ResponseBody //반환 값은 뷰이름이 아니고 응답컨텐츠입니다
	public String writeComment(Comment comment) {
		
		reviewService.writeComment(comment);
		
		
		return "success"; // WEB-INF/views/success.jsp
	}
	
	@RequestMapping(value = "/comment-list", method = RequestMethod.POST)
	public String commentList(int reviewNo, Model model) {
		
		List<Comment> comments = reviewService.findCommentListByReviewNo(reviewNo);
		model.addAttribute("comments", comments);
		
		return "review/comments"; // -> /WEB-INF/views/upload/commnets.jsp를 응답에 사용
	}
	
	@RequestMapping(value = "/delete-comment", method = RequestMethod.GET)
	@ResponseBody
	public String deleteComment(int commentNo) {
		
		reviewService.deleteComment(commentNo);
		
		return "success";
	}
	
	@RequestMapping(value = "/update-comment", method = RequestMethod.POST)
	@ResponseBody
	public String updateComment(Comment comment) {
		
		reviewService.updateComment(comment);
		
		return "success";
	}
	
	
}

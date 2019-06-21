package com.teamproject3.controller;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamproject3.service.QnAService;
import com.teamproject3.vo.QnA;

@Controller
@RequestMapping("/announcement/")
public class QnAController {
	
//	@Autowired
//	@Qualifier("QnAService")
	@Inject
	QnAService qnAService;
	
	@RequestMapping(path="/QnApage", method= RequestMethod.GET)
	public String QnApage() {
		
		return "announcement/QnApage";
	}
	
	@RequestMapping(path="/qnaWrite", method= RequestMethod.POST)
	public String QnAWrite(QnA qnA) {
		
		qnAService.registerQnA(qnA);
		
		return "home";
	}
}

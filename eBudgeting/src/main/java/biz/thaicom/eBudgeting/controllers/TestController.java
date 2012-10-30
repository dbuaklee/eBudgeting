package biz.thaicom.eBudgeting.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import biz.thaicom.eBudgeting.models.bgt.ProposalStrategy;

@Controller
public class TestController {
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@Autowired
	ObjectMapper mapper;
	
	@RequestMapping(value="/test/ProposalStratgey") 
	public @ResponseBody ProposalStrategy saveProposalStrategy(){
		
				
		logger.debug("mapper class: " + mapper.getClass());
		
		return null;
	}
	
}

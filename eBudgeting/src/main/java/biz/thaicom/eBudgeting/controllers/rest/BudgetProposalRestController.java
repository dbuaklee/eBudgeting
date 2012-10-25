package biz.thaicom.eBudgeting.controllers.rest;

import java.security.Principal;
import java.util.List;

import javax.persistence.EntityNotFoundException;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;
import biz.thaicom.eBudgeting.models.bgt.ObjectiveBudgetProposalDTO;
import biz.thaicom.eBudgeting.services.EntityService;
import biz.thaicom.security.models.Activeuser;
import biz.thaicom.security.models.ThaicomUserDetail;

@Controller
public class BudgetProposalRestController {
	private static final Logger logger = LoggerFactory.getLogger(BudgetProposalRestController.class);
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping("/BudgetProposal/{budgetProposalId}/")
	public @ResponseBody BudgetProposal findBudgetProposalById(
			@PathVariable Long budgetProposalId, 
			@Activeuser ThaicomUserDetail activeUser) {
		
		 

		return entityService.findBudgetProposalById(budgetProposalId);
	}
	
	@ExceptionHandler(value=EntityNotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public @ResponseBody Boolean handleEntityNotFoundExeption(final EntityNotFoundException e, 
			final HttpServletRequest request) {
		logger.error(e.toString());
		Boolean success = false;
		return success;
	}
	
	@ExceptionHandler(value=Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed: " + e.toString();
		
	}
	
	
}

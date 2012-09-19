package biz.thaicom.eBudgeting.controllers.rest;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.model.bgt.BudgetType;
import biz.thaicom.eBudgeting.services.EntityService;

@Controller
public class BudgetTypeRestController {
	private static final Logger logger = LoggerFactory.getLogger(BudgetTypeRestController.class);
	
	@Autowired
	private EntityService entityService;
	
	@Transactional(propagation=Propagation.MANDATORY)
	@RequestMapping(value="/BudgetType/{id}", method=RequestMethod.GET)
	public @ResponseBody BudgetType getRootFiscalYear(
			@PathVariable Long id) {
		BudgetType b = entityService.findeBudgetTyeEagerLoadById(id);
		
		return b;
	}
	
	
	@ExceptionHandler(value=Exception.class)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed" + e.toString();
		
	}
	
	

}

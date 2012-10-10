package biz.thaicom.eBudgeting.controllers.rest;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.model.bgt.BudgetType;
import biz.thaicom.eBudgeting.services.EntityService;

@Controller
public class BudgetTypeRestController {
	private static final Logger logger = LoggerFactory.getLogger(BudgetTypeRestController.class);
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping(value="/BudgetType/{id}", method=RequestMethod.GET)
	public @ResponseBody BudgetType getBudgetTypeEagerLoad(
			@PathVariable Long id, 
			@RequestParam(required=false) Boolean isEagerLoad) {
		BudgetType b;
		
		if(isEagerLoad != null && isEagerLoad == true) 
			 b = entityService.findBudgetTyeEagerLoadById(id);
		else {
			b = entityService.findBudgetTyeById(id);
		}
		
		return b;
	}
	
	@RequestMapping(value="/BudgetType/root", method=RequestMethod.GET)
	public @ResponseBody List<BudgetType> getRootBudgetType() {
		return entityService.findRootBudgetType();
	}
	
	
	@ExceptionHandler(value=Exception.class)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed" + e.toString();
		
	}
	
	

}

package biz.thaicom.eBudgeting.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import biz.thaicom.eBudgeting.model.bgt.Objective;
import biz.thaicom.eBudgeting.services.ObjectiveService;

@Controller
public class ObjectiveRestController {
	private static final Logger logger = LoggerFactory.getLogger(Objective.class);
	
	@Autowired
	private ObjectiveService objectiveService;

	@RequestMapping(value="/Objective/root", method=RequestMethod.GET)
	public @ResponseBody List<Integer> getRootFiscalYear() {
		return objectiveService.findRootFiscalYear();
	}
	
	@RequestMapping(value="/Objective/root/{fiscalYear}", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getRootObjectiveByFiscalYear(
			@PathVariable Integer fiscalYear) {
		
		return objectiveService.findRootObjectiveByFiscalyear(fiscalYear);
	};

	
	@RequestMapping(value="/Objective/{id}", method=RequestMethod.GET)
	public @ResponseBody Objective getObjectiveById(@PathVariable Long id) {
		logger.debug("id: " + id);
		return objectiveService.findOjectiveById(id); 
	}
	
	@RequestMapping(value="/Objective/{id}/children", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getOChildrenObjectiveById(@PathVariable Long id) {
		logger.debug("id: " + id);
		List<Objective> list =objectiveService.findObjectiveChildrenByObjectiveId(id);
		logger.debug("children size: " + list.size());
		for(Objective obj : list) {
			logger.debug("  -> id : " + obj.getId());
		}
		logger.debug("returning...");
		return  list;
	}
	
	@ExceptionHandler(value=Exception.class)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed";
		
	}

	
}

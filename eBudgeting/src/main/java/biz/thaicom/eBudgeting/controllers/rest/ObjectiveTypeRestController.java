package biz.thaicom.eBudgeting.controllers.rest;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.models.pln.ObjectiveType;
import biz.thaicom.eBudgeting.services.EntityService;

@Controller
public class ObjectiveTypeRestController {

	private static final Logger logger = LoggerFactory.getLogger(ObjectiveTypeRestController.class);
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping("/ObjectiveType/root")
	public @ResponseBody List<Integer> getRootFiscalYear() {
		return entityService.findObjectiveTypeRootFiscalYear();

	}
	
	@RequestMapping("/ObjectiveType/root/{fiscalYear}")
	public @ResponseBody List<ObjectiveType> getRootByFiscalYear(
			@PathVariable Integer fiscalYear) {
		return entityService.findObjectiveTypeByFiscalYearEager(fiscalYear, null);
		
	}
	
	@RequestMapping(value="/ObjectiveType/{id}", method=RequestMethod.GET)
	public @ResponseBody ObjectiveType getObjectiveTypeById(@PathVariable Long id) {
		return entityService.findObjectiveTypeById(id);
	}
	
	
	@ExceptionHandler(value=Exception.class)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed";
		
	}
	
}

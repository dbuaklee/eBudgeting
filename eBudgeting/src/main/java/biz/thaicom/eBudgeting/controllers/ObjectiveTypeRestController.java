package biz.thaicom.eBudgeting.controllers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.model.pln.ObjectiveType;
import biz.thaicom.eBudgeting.services.ObjectiveService;

@Controller
public class ObjectiveTypeRestController {

	private static final Logger logger = LoggerFactory.getLogger(ObjectiveTypeRestController.class);
	
	@Autowired
	private ObjectiveService objectiveService;
	
	@RequestMapping("/ObjectiveType/root")
	public @ResponseBody List<Integer> getRootFiscalYear() {
		return objectiveService.findObjectiveTypeRootFiscalYear();

	}
	
	@RequestMapping("/ObjectiveType/root/{fiscalYear}")
	public @ResponseBody List<ObjectiveType> getRootByFiscalYear(
			@PathVariable Integer fiscalYear) {
		return objectiveService.findObjectiveTypeByFiscalYearEager(fiscalYear, null);
		
	}
	
}

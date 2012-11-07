package biz.thaicom.eBudgeting.controllers.rest;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;

import biz.thaicom.eBudgeting.models.pln.ObjectiveTarget;
import biz.thaicom.eBudgeting.models.pln.TargetUnit;
import biz.thaicom.eBudgeting.services.EntityService;

@Controller
public class ObjectiveTargetRestController {

private static final Logger logger = LoggerFactory.getLogger(ObjectiveTargetRestController.class);
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping(value="/ObjectiveTarget/fiscalYear/{fiscalYear}", method=RequestMethod.GET)
	public @ResponseBody List<ObjectiveTarget> findAllObjectiveTargets(
			@PathVariable Integer fiscalYear) {
		return entityService.findAllObjectiveTargetsByFiscalyear(fiscalYear);
	}
	
	@RequestMapping(value="/ObjectiveTarget/{id}", method=RequestMethod.GET)
	public @ResponseBody ObjectiveTarget findOneObjectiveTarget(
			@PathVariable Long id) {
		return entityService.findOneObjectiveTarget(id);
	}
	
	@RequestMapping(value="/ObjectiveTarget/{id}", method=RequestMethod.PUT)
	public @ResponseBody ObjectiveTarget updateObjectiveTarget(
			@PathVariable Long id,
			@RequestBody JsonNode node) {
		return entityService.updateObjectiveTarget(node);
	}
	
	@RequestMapping(value="/ObjectiveTarget/", method=RequestMethod.POST)
	public @ResponseBody ObjectiveTarget saveObjectiveTarget(
			@RequestBody JsonNode node) {
		return entityService.saveObjectiveTarget(node);
	}
	
	@RequestMapping(value="/ObjectiveTarget/{id}", method=RequestMethod.DELETE)
	public @ResponseBody ObjectiveTarget deleteObjectiveTarget(
			@PathVariable Long id) {
		return entityService.deleteObjectiveTarget(id);
	}
	
	
	
	@RequestMapping(value="/TargetUnit/", method=RequestMethod.GET)
	public @ResponseBody List<TargetUnit> findAllTargetUnit() {
		return entityService.findAllTargetUnits();
	}
	
	@RequestMapping(value="/TargetUnit/{id}", method=RequestMethod.GET)
	public @ResponseBody TargetUnit findOneTargetUnit(
			@PathVariable Long id) {
		return entityService.findOneTargetUnit(id);
	}
	
	@RequestMapping(value="/TargetUnit/{id}", method=RequestMethod.PUT)
	public @ResponseBody TargetUnit updateTargetUnit(
			@PathVariable Long id,
			@RequestBody JsonNode node) {
		return entityService.updateTargetUnit(node);
	}
	
	@RequestMapping(value="/TargetUnit/", method=RequestMethod.POST)
	public @ResponseBody TargetUnit saveTargetUnit(
			@RequestBody JsonNode node) {
		return entityService.saveTargetUnit(node);
	}
	
	@RequestMapping(value="/TargetUnit/{id}", method=RequestMethod.DELETE)
	public @ResponseBody TargetUnit deleteTargetUnit(
			@PathVariable Long id) {
		return entityService.deleteTargetUnit(id);
	}
	
	
	@ExceptionHandler(value=Exception.class)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed";
		
	}
	
}

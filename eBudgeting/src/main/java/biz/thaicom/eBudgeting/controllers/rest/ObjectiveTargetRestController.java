package biz.thaicom.eBudgeting.controllers.rest;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;

import biz.thaicom.eBudgeting.models.pln.ObjectiveTarget;
import biz.thaicom.eBudgeting.models.pln.TargetUnit;
import biz.thaicom.eBudgeting.models.pln.TargetValue;
import biz.thaicom.eBudgeting.models.pln.TargetValueAllocationRecord;
import biz.thaicom.eBudgeting.models.webui.PageUI;
import biz.thaicom.eBudgeting.services.EntityService;
import biz.thaicom.security.models.Activeuser;
import biz.thaicom.security.models.ThaicomUserDetail;

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
	
	@RequestMapping(value="/TargetUnit/page/{targetPage}", method=RequestMethod.GET)
	public @ResponseBody Page<TargetUnit> findAllTargetUnit(@PathVariable Integer targetPage) {
		
		PageRequest pageRequest =
	            new PageRequest(targetPage - 1, PageUI.PAGE_SIZE , Sort.Direction.ASC, "name");
		
		return entityService.findAllTargetUnits(pageRequest);
	}

	@RequestMapping(value="/TargetUnit/page/{targetPage}", method=RequestMethod.POST)
	public @ResponseBody Page<TargetUnit> findAllTargetUnit(@PathVariable Integer targetPage, 
			@RequestParam String query) {
		
		PageRequest pageRequest =
	            new PageRequest(targetPage - 1, PageUI.PAGE_SIZE , Sort.Direction.ASC, "name");
		
		logger.debug(query);
		
		return entityService.findAllTargetUnits(pageRequest, query);
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
	
	@RequestMapping(value="/TargetValue/", method=RequestMethod.POST)
	public @ResponseBody TargetValue saveTargetValue(
			@RequestBody JsonNode node,
			@Activeuser ThaicomUserDetail currentUser) throws Exception {
		return entityService.saveTargetValue(node, currentUser.getWorkAt());
	}
	
	@RequestMapping(value="/TargetValue/{id}", method=RequestMethod.PUT)
	public @ResponseBody TargetValue updateTargetValue(
			@PathVariable Long id,
			@RequestBody JsonNode node,
			@Activeuser ThaicomUserDetail currentUser) throws Exception {
		return entityService.saveTargetValue(node, currentUser.getWorkAt());
	}
	
	@RequestMapping(value="/TargetValue/LotsUpdate", method=RequestMethod.PUT)
	public @ResponseBody void updateLotsTargetValue(
			@RequestBody JsonNode node,
			@Activeuser ThaicomUserDetail currentUser) throws Exception {
		entityService.saveLotsTargetValue(node);
	}
	
	
	@RequestMapping(value="/TargetValueAllocationRecord/{id}", method=RequestMethod.PUT)
	public @ResponseBody TargetValueAllocationRecord updateTargetValueAllocationRecord(
			@PathVariable Long id,
			@RequestBody JsonNode node,
			@Activeuser ThaicomUserDetail currentUser) throws Exception {
		return entityService.saveTargetValueAllocationRecord(node, currentUser.getWorkAt());
	}
	
	@ExceptionHandler(value=Exception.class)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed";
		
	}
	
}

package biz.thaicom.eBudgeting.controllers.rest;

import java.util.ArrayList;
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


import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveRelations;
import biz.thaicom.eBudgeting.models.pln.ObjectiveTarget;
import biz.thaicom.eBudgeting.repositories.ObjectiveRelationsRepository;
import biz.thaicom.eBudgeting.services.EntityService;
import biz.thaicom.security.models.Activeuser;
import biz.thaicom.security.models.ThaicomUserDetail;

@Controller
public class ObjectiveRestController {
	private static final Logger logger = LoggerFactory.getLogger(ObjectiveRestController.class);
	
	private static final Integer PAGE_SIZE = 5;
	
	@Autowired
	private EntityService entityService;

	@RequestMapping(value="/Objective/root", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getRootFiscalYear() {
		return entityService.findRootFiscalYear();
	}
	
	@RequestMapping(value="/Objective/root/{fiscalYear}", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getRootObjectiveByFiscalYear(
			@PathVariable Integer fiscalYear) {
		
		return entityService.findRootObjectiveByFiscalyear(fiscalYear, false);
	};
	
	@RequestMapping(value="/Objective/rootEager/{fiscalYear}", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getRootEagerObjectiveByFiscalYear(
			@PathVariable Integer fiscalYear) {
		
		return entityService.findRootObjectiveByFiscalyear(fiscalYear, true);
	};

	
	@RequestMapping(value="/Objective/{id}", method=RequestMethod.GET)
	public @ResponseBody Objective getObjectiveById(@PathVariable Long id) {
		logger.debug("id: " + id);
		return entityService.findOjectiveById(id); 
	}
	
	@RequestMapping(value="/Objective/{id}/children", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getOChildrenObjectiveById(@PathVariable Long id) {
		logger.debug("id: " + id);
		List<Objective> list =entityService.findObjectiveChildrenByObjectiveId(id);

		return  list;
	}
	
	@RequestMapping(value="/Objective/{fiscalYear}/type/{typeId}") 
	public @ResponseBody List<Objective> getObjectiveByFiscalYearAndType(
			@PathVariable Integer fiscalYear, @PathVariable Long typeId) {
		return entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, typeId);
	}
	
	@RequestMapping(value="/Objective/{fiscalYear}/type/{typeId}/page/{pageNumber}") 
	public @ResponseBody Page<Objective> getPagedObjectiveByFiscalYearAndType(
			@PathVariable Integer fiscalYear, 
			@PathVariable Long typeId,
			@PathVariable Integer pageNumber) {
		PageRequest pageRequest =
	            new PageRequest(pageNumber - 1, PAGE_SIZE, Sort.Direction.ASC, "code");
		
		return entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, typeId, pageRequest);
	}
	
	@RequestMapping(value="/Objective/{id}/addUnit", method=RequestMethod.POST) 
	public @ResponseBody ObjectiveTarget addUnit(@PathVariable Long id,
			@RequestParam Long unitId, @RequestParam Integer isSumable) {

		return entityService.addUnitToObjective(id, unitId, isSumable);
	}
	
	@RequestMapping(value="/Objective/{id}/removeUnit", method=RequestMethod.POST) 
	public @ResponseBody String removeUnit(@PathVariable Long id,
			@RequestParam Long targetId) {
		return entityService.removeUnitFromObjective(id, targetId);
	}
	
	
	@RequestMapping(value="/Objective/{id}/addTarget", method=RequestMethod.POST)
	public @ResponseBody String addTargetToObjective(@PathVariable Long id,
			@RequestParam Long targetId) {
		logger.debug("id: " + id);
		logger.debug("targetId: " + id);
		
		entityService.addTargetToObjective(id, targetId);
		
		return  "success";
	}
	
	
	@RequestMapping(value="/Objective", method=RequestMethod.POST) 
	public @ResponseBody Objective saveObjective(@RequestBody JsonNode node) {
		return entityService.saveObjective(node);
	}
	
	@RequestMapping(value="/Objective/{id}", method=RequestMethod.PUT)
	public @ResponseBody Objective updateObjective(@PathVariable Long id,
			@RequestBody JsonNode node) {
		
		// now we'll have to save this
		Objective objectiveFromJpa = entityService.saveObjective(node);
		
		
		return objectiveFromJpa;
		
	}
	
	@RequestMapping(value="/Objective/{id}/updateToParent/{parentId}", method=RequestMethod.PUT)
	public @ResponseBody Objective updateObjectiveParent(@PathVariable Long id,
			@PathVariable Long parentId) {
		
		
		
		// now we'll have to save this
		Objective objectiveFromJpa = entityService.updateObjectiveParent(id, parentId);
		
		
		return objectiveFromJpa;
		
	}
	
	@RequestMapping(value="/Objective/{id}/addReplaceUnit/{unitId}", method=RequestMethod.PUT)
	public @ResponseBody Objective updateObjectiveUnit(@PathVariable Long id, @PathVariable Long unitId) {
		// now we'll have to save this
		Objective objectiveFromJpa = entityService.objectiveAddReplaceUnit(id, unitId);
				
				
		return objectiveFromJpa;
	}
	
	@RequestMapping(value="/Objective/{id}", method=RequestMethod.DELETE) 
	public @ResponseBody Objective deleteObjective(
			@PathVariable Long id) {
		return entityService.deleteObjective(id);
	}
	

	
	@RequestMapping(value="/Objective/newObjectiveWithParam", method=RequestMethod.POST) 
	public @ResponseBody Objective saveObjectiveWithParam(
			@RequestParam String name,
			@RequestParam String code,
			@RequestParam Long parentId,
			@RequestParam String parentPath,
			@RequestParam Long typeId,
			@RequestParam Integer fiscalYear) {
		
		return entityService.newObjectiveWithParam(name,code,parentId,typeId, parentPath, fiscalYear);
	}
	
	
	@RequestMapping(value="/Objective/{id}/addBudgetType", method=RequestMethod.POST)
	public @ResponseBody Objective addBudgetType(@PathVariable Long id,
			@RequestParam Long budgetTypeId){
		return entityService.addBudgetTypeToObjective(id, budgetTypeId);
	}
	
	@RequestMapping(value="/Objective/{id}/updateFields", method=RequestMethod.POST)
	public @ResponseBody Objective updateFileds(@PathVariable Long id,
			@RequestParam(required=false) String name,
			@RequestParam(required=false) String code){
		return entityService.updateObjectiveFields(id, name, code);
	}
	
	@RequestMapping(value="/Objective/{id}/removeBudgetType", method=RequestMethod.POST)
	public @ResponseBody Objective removeBudgetType(@PathVariable Long id,
			@RequestParam Long budgetTypeId){
		return entityService.removeBudgetTypeToObjective(id, budgetTypeId);
	}
	
	
	@RequestMapping(value="/ObjectiveWithBudgetProposal/{fiscalYear}/{ownerId}/{objectiveId}/children", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getChildrenbjectiveWithBudgetPorposalByOwnerId(
			@PathVariable Integer fiscalYear,
			@PathVariable Long ownerId,
			@PathVariable Long objectiveId,
			@Activeuser ThaicomUserDetail currentUser
			) {
		List<Objective> objectives = entityService.findChildrenObjectivewithBudgetProposal(fiscalYear, ownerId, objectiveId, false);
		
		return objectives;
		
	}
	
	@RequestMapping(value="/ObjectiveWithBudgetProposal/{fiscalYear}/{objectiveId}/children", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getChildrenbjectiveWithBudgetPorposal(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			@Activeuser ThaicomUserDetail currentUser
			) {
		List<Objective> objectives = entityService.findChildrenObjectivewithBudgetProposal(fiscalYear, currentUser.getWorkAt().getId(), objectiveId, false);
		
		return objectives;
		
	}
	
	@RequestMapping(value="/ObjectiveWithBudgetProposal/{fiscalYear}/{objectiveId}/flatDescendants", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getFlatDescendantsObjectiveWithBudgetPorposalByOwnerId(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			@Activeuser ThaicomUserDetail currentUser
			) {
		
		logger.debug("current user workAt.id = {} ",currentUser.getWorkAt().getId());
		
		List<Objective> objectives = entityService.findFlatChildrenObjectivewithBudgetProposal(fiscalYear, currentUser.getWorkAt().getId(), objectiveId);
		
		return objectives;
		
	}
	
	
	@RequestMapping(value="/ObjectiveWithBudgetProposalAndAllocation/{fiscalYear}/{objectiveId}/flatDescendants", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getFlatDescendantsObjectiveWithBudgetPorposalAndAllocation(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			@Activeuser ThaicomUserDetail currentUser
			) {
		List<Objective> objectives = entityService.findFlatChildrenObjectivewithBudgetProposalAndAllocation(fiscalYear, objectiveId);
		
		return objectives;
		
	}
	
	
	@RequestMapping(value="/ObjectiveWithBudgetProposal/{fiscalYear}/{ownerId}/{objectiveId}/descendants", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getDescendantsbjectiveWithBudgetPorposalByOwnerId(
			@PathVariable Integer fiscalYear,
			@PathVariable Long ownerId,
			@PathVariable Long objectiveId,
			@Activeuser ThaicomUserDetail currentUser
			) {
		List<Objective> objectives = entityService.findChildrenObjectivewithBudgetProposal(fiscalYear, ownerId, objectiveId, true);
		
		return objectives;
		
	}
	
	@RequestMapping(value="/ObjectiveWithBudgetProposal/{fiscalYear}/{objectiveId}/descendants", method=RequestMethod.GET)
	public @ResponseBody List<Objective> getDescendantsbjectiveWithBudgetPorposal(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			@Activeuser ThaicomUserDetail currentUser
			) {
		List<Objective> objectives = entityService.findChildrenObjectivewithBudgetProposal(fiscalYear, currentUser.getWorkAt().getId(), objectiveId, true);
		
		return objectives;
		
	}
	
	
	@RequestMapping(value="/ObjectiveRelations/{fiscalYear}/relation/{parentTypeId}/all") 
	public @ResponseBody List<ObjectiveRelationsRepository> getObjectiveByFiscalYearAndparentRelation(
			@PathVariable Integer fiscalYear, @PathVariable Long parentTypeId){
		return entityService.findObjectiveRelationsByFiscalYearAndChildTypeRelation(fiscalYear, parentTypeId);
	}
	
	@RequestMapping(value="/ObjectiveRelations/{fiscalYear}/relation/{parentTypeId}", method=RequestMethod.GET) 
	public @ResponseBody List<ObjectiveRelationsRepository> getObjectiveByFiscalYearAndparentRelationWithObjectiveIds(
			@PathVariable Integer fiscalYear, @PathVariable Long parentTypeId,
			@RequestParam(required=false, value="ids[]") String[] ids){
		
		if(ids==null || ids.length == 0) {
			return null;
		}
		
		List<Long> idList = new ArrayList<Long>();
		
		for(String id: ids) {
			idList.add(Long.parseLong(id));
		}
		return entityService.findObjectiveRelationsByFiscalYearAndChildTypeRelationWithObjectiveIds
				(fiscalYear, parentTypeId, idList);
	
	}
	
	@RequestMapping(value="/Objective/mappedUnit", method=RequestMethod.GET)
	public @ResponseBody String mappedUnit() {
		return entityService.mappedUnit();
	}
	
	
	@RequestMapping(value="/ObjectiveRelations", method=RequestMethod.POST)
	public @ResponseBody ObjectiveRelations saveObjectiveRelations( @RequestBody JsonNode relation) {
		return entityService.saveObjectiveRelations(relation);
	}
	
	@RequestMapping(value="/ObjectiveRelations/{id}", method=RequestMethod.PUT)
	public @ResponseBody ObjectiveRelations updateObjectiveRelations(
			@PathVariable Long id, @RequestBody JsonNode relation) {
		return entityService.updateObjectiveRelations(id, relation);
	}
	
	@RequestMapping(value="/Objective/initFiscalYear", method=RequestMethod.POST)
	public @ResponseBody String initFiscalYear(
			@RequestParam Integer fiscalYear){
		return entityService.initFiscalYear(fiscalYear);
		
	}
	
	@ExceptionHandler(value=Exception.class)
	public @ResponseBody String handleException(final Exception e, final HttpServletRequest request) {
		logger.error(e.toString());
		e.printStackTrace();
		return "failed";
		
	}

	
}

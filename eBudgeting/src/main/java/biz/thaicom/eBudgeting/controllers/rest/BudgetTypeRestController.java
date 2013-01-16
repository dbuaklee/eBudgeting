package biz.thaicom.eBudgeting.controllers.rest;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityNotFoundException;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.fasterxml.jackson.databind.JsonNode;

import biz.thaicom.eBudgeting.models.bgt.BudgetCommonType;
import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FiscalBudgetType;
import biz.thaicom.eBudgeting.models.bgt.FormulaColumn;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;
import biz.thaicom.eBudgeting.models.pln.ObjectiveName;
import biz.thaicom.eBudgeting.models.webui.PageUI;

import biz.thaicom.eBudgeting.services.EntityService;

@Controller
public class BudgetTypeRestController {
	private static final Logger logger = LoggerFactory.getLogger(BudgetTypeRestController.class);
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping(value="/BudgetType/{id}", method=RequestMethod.GET)
	public @ResponseBody BudgetType getBudgetTypeEagerLoad(
			@PathVariable Long id, 
			@RequestParam(required=false) Boolean isEagerLoad,
			@RequestParam(required=false) Boolean isLoadParent) {
		BudgetType b;
		
		if((isEagerLoad != null && isEagerLoad == true) || 
			(isLoadParent != null && isLoadParent == true)) 
			 b = entityService.findBudgetTypeEagerLoadById(id, isLoadParent);
		else {
			b = entityService.findBudgetTypeById(id);
		}
		

		
		if(b==null) throw new EntityNotFoundException("no BudgetType row with id " + id);
		
		return b;
	}
	
	@RequestMapping(value="/BudgetType/root", method=RequestMethod.GET)
	public @ResponseBody List<BudgetType> getRootBudgetType() {
		return entityService.findRootBudgetType();
	
	}
	
	@RequestMapping(value="/BudgetType", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody BudgetType createBudgetType(
			@RequestBody JsonNode node) {
		return entityService.saveBudgetType(node);
		
	}
	
	@RequestMapping(value="/BudgetType/{id}", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody BudgetType updateBudgetType(
			@PathVariable Long id,
			@RequestBody JsonNode node) {
		return entityService.saveBudgetType(node);
		
	}
	
	
	@RequestMapping(value="/BudgetType/{id}", method=RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody String deleteBudgetType(
			@PathVariable Long id) {
		entityService.deleteBudgetType(id);
		return "OK";
	}
	
	/**
	 * @RequestMapping(value="/ObjectiveName/fiscalYear/{fiscalYear}/type/{typeId}/page/{pageNumber}", method=RequestMethod.GET)
	public @ResponseBody Page<ObjectiveName> findAllObjectiveNameByFiscalYearAndTypeId(
			@PathVariable Integer fiscalYear, 
			@PathVariable Long typeId,
			@PathVariable Integer pageNumber) {
		
		
		
	}
	 */
	
	
	
	@RequestMapping(value="/BudgetType/{fiscalYear}/listLevel/{level}/mainType/{typeId}/page/{pageNumber}", method=RequestMethod.GET)
	public @ResponseBody Page<BudgetType> findAllByMainType(
			@PathVariable Integer fiscalYear,
			@PathVariable Long typeId,
			@PathVariable Integer level,
			@PathVariable Integer pageNumber,
			@RequestParam (required=false) String query) {
		PageRequest pageRequest =
	            new PageRequest(pageNumber - 1, PageUI.PAGE_SIZE, Sort.Direction.ASC, "lineNumber");
		if(query == null || query.length() == 0) {
			query = "%";
		} else {
			query = "%" + query + "%";
		}
		return entityService.findBudgetTypeByLevelAndMainType(fiscalYear, level, typeId, query, pageRequest);
	}
	
	@RequestMapping(value="/BudgetType/{fiscalYear}/listLevel/{level}/mainType/{typeId}/page/{pageNumber}", method=RequestMethod.POST)
	public @ResponseBody Page<BudgetType> findAllByMainTypeQuery(
			@PathVariable Integer fiscalYear,
			@PathVariable Long typeId,
			@PathVariable Integer level,
			@PathVariable Integer pageNumber,
			@RequestParam (required=false) String query) {
		PageRequest pageRequest =
	            new PageRequest(pageNumber - 1, PageUI.PAGE_SIZE, Sort.Direction.ASC, "code");
		if(query == null || query.length() == 0) {
			query = "%";
		} else {
			query = "%" + query + "%";
		}
		return entityService.findBudgetTypeByLevelAndMainType(fiscalYear, level, typeId, query, pageRequest);
	}
	
	
	@RequestMapping(value="/BudgetCommonType/fiscalYear/{fiscalYear}/", method=RequestMethod.GET)
	public @ResponseBody List<BudgetCommonType> findAllBudgetCommonType(
			@PathVariable Integer fiscalYear) {
		return entityService.findAllBudgetCommonTypes(fiscalYear);
	}
	
	@RequestMapping(value="/BudgetCommonType/{id}", method=RequestMethod.GET)
	public @ResponseBody BudgetCommonType findOneBudgetCommonType(
			@PathVariable Long id) {
		return entityService.findOneBudgetCommonType(id);
	}
	
	@RequestMapping(value="/BudgetCommonType/{id}", method=RequestMethod.PUT)
	public @ResponseBody BudgetCommonType updateBudgetCommonType(
			@PathVariable Long id,
			@RequestBody JsonNode node) {
		return entityService.updateBudgetCommonType(node);
	}
	
	@RequestMapping(value="/BudgetCommonType/", method=RequestMethod.POST)
	public @ResponseBody BudgetCommonType saveBudgetCommonType(
			@RequestBody JsonNode node) {
		return entityService.saveBudgetCommonType(node);
	}
	
	@RequestMapping(value="/BudgetCommonType/{id}", method=RequestMethod.DELETE)
	public @ResponseBody BudgetCommonType deleteBudgetCommonType(
			@PathVariable Long id) {
		return entityService.deleteBudgetCommonType(id);
	}
	
	
	@RequestMapping(value="/BudgetType/fiscalYear/{fiscalYear}/mainType", method=RequestMethod.GET)
	public @ResponseBody List<BudgetType> findAllMainBudgetTypeByFiscalYear(
			@PathVariable Integer fiscalYear) {
		return entityService.findAllMainBudgetTypeByFiscalYear(fiscalYear);
		
	}
	
	@RequestMapping(value="/FiscalBudgetType/fiscalYear/{fiscalYear}", method=RequestMethod.GET)
	public @ResponseBody List<FiscalBudgetType> findAllFiscalBudgetTypeByFiscalYear(
			@PathVariable Integer fiscalYear) {
		return entityService.findAllFiscalBudgetTypeByFiscalYear(fiscalYear);
	}
	
	@RequestMapping(value="/FiscalBudgetType/fiscalYear/{fiscalYear}/upToLevel/{level}", method=RequestMethod.GET)
	public @ResponseBody List<FiscalBudgetType> findAllFiscalBudgetTypeByFiscalYearUpToLevel(
			@PathVariable Integer fiscalYear,
			@PathVariable Integer level) {
		return entityService.findAllFiscalBudgetTypeByFiscalYearUpToLevel(fiscalYear,level);
	}
	
	@RequestMapping(value="/FiscalBudgetType/setMainBudget/{fiscalYear}", method=RequestMethod.POST)
	public @ResponseBody String setFiscalBudgetTypeMainBudget(
			@PathVariable Integer fiscalYear,
			@RequestParam(required=false, value="ids[]") String[] ids) {
		
		List<Long> idList = new ArrayList<Long>();
		
		if(ids!=null) {
		
			for(String id: ids) {
				idList.add(Long.parseLong(id));
			}
		}
		
		return entityService.updateFiscalBudgetTypeIsMainBudget(fiscalYear, idList);
	}
	
	
	
	//FormulaColumn
	@RequestMapping(value="/FormulaColumn", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody FormulaColumn createBudgetTypeFormulaColumn(
			@RequestBody FormulaColumn budgetTypeFormulaColumn) {
		return entityService.saveFormulaColumn(budgetTypeFormulaColumn);
		
	}
	
	@RequestMapping(value="/FormulaColumn/{id}", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody FormulaColumn updateBudgetTypeFormulaColumn(
			@PathVariable Long id,
			@RequestBody FormulaColumn budgetTypeFormulaColumn) {
		return entityService.updateFormulaColumn(budgetTypeFormulaColumn);
		
	}
	
	
	@RequestMapping(value="/FormulaColumn/{id}", method=RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody String deleteBudgetTypeFormulaColumn(
			@PathVariable Long id) {
		entityService.deleteFormulaColumn(id);
		return "OK";
	}
	
	
	//FormulaStrategy
	
	@RequestMapping(value="/FormulaStrategy/search/{fiscalYear}/{budgetTypeId}")
	public @ResponseBody List<FormulaStrategy> getBudgetTypeFormulaStrategy(
			@PathVariable Integer fiscalYear,
			@PathVariable Long budgetTypeId) {
		
		List<FormulaStrategy> strategy = entityService.findFormulaStrategyByfiscalYearAndTypeId(fiscalYear, budgetTypeId);
		
		if(strategy == null) {
			throw new EntityNotFoundException();
			
		}
		
		return strategy;
		
	};
	
	@RequestMapping(value="/FormulaStrategy/searchAll/{fiscalYear}/rootBudgetType/{budgetTypeId}")
	public @ResponseBody List<FormulaStrategy> getBudgetTypeFormulaStrategyFromRootBudgetType(
			@PathVariable Integer fiscalYear,
			@PathVariable Long budgetTypeId) {
		
		String parentPath = "%." + budgetTypeId.toString() + ".%";
		
		List<FormulaStrategy> strategy = entityService.findAllFormulaStrategyByfiscalYearAndBudgetType_ParentPathLike(fiscalYear, parentPath);
		
		if(strategy == null) {
			throw new EntityNotFoundException();
			
		}
		
		return strategy;
		
	};
	
	@RequestMapping(value="/FormulaStrategy/searchIsStandardItem/{fiscalYear}/rootBudgetType/{budgetTypeId}")
	public @ResponseBody List<FormulaStrategy> getBudgetTypeFormulaStrategyIsStandardFromRootBudgetType(
			@PathVariable Integer fiscalYear,
			@PathVariable Long budgetTypeId) {
		
		String parentPath = "%." + budgetTypeId.toString() + ".%";
		
		List<FormulaStrategy> strategy = entityService
				.findAllFormulaStrategyByfiscalYearAndIsStandardItemAndBudgetType_ParentPathLike(fiscalYear, true, budgetTypeId, parentPath);
		
		if(strategy == null) {
			throw new EntityNotFoundException();
			
		}
		
		return strategy;
		
	};

	@RequestMapping(value="/FormulaStrategy/searchIsNotStandardItem/{fiscalYear}/rootBudgetType/{budgetTypeId}")
	public @ResponseBody List<FormulaStrategy> getBudgetTypeFormulaStrategyIsNotStandardFromRootBudgetType(
			@PathVariable Integer fiscalYear,
			@PathVariable Long budgetTypeId) {
		
		String parentPath = "%." + budgetTypeId.toString() + ".%";
		
		logger.debug("======****" +  parentPath);
		
		List<FormulaStrategy> strategy = entityService.findAllFormulaStrategyByfiscalYearAndIsStandardItemAndBudgetType_ParentPathLike(fiscalYear, false, budgetTypeId, parentPath);
		
		if(strategy == null) {
			throw new EntityNotFoundException();
			
		}
		
		return strategy;
		
	};
	
	
	@RequestMapping(value="/FormulaStrategy/{id}", method=RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody String deleteBudgetTypeFormulaStrategy(
			@PathVariable Long id) {
		entityService.deleteFormulaStrategy(id);
		return "OK";
	}
	
	
	
	@RequestMapping(value="/FormulaStrategy", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody FormulaStrategy createBudgetTypeFormulaStrategy(
			@RequestBody JsonNode strategy) {
		
		
		
		return entityService.saveFormulaStrategy(strategy);
	}
	
	@RequestMapping(value="/FormulaStrategy/{id}", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public @ResponseBody FormulaStrategy updateBudgetTypeFormulaStrategy(
			@PathVariable Long id,
			@RequestBody JsonNode strategy) {
		
		//logger.debug("id: " + strategy.getType().getId());
		
		return entityService.updateFormulaStrategy(strategy);
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

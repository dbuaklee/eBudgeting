package biz.thaicom.eBudgeting.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.Stack;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FormulaColumn;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;
import biz.thaicom.eBudgeting.models.bgt.ObjectiveBudgetProposalDTO;
import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;
import biz.thaicom.eBudgeting.models.webui.Breadcrumb;
import biz.thaicom.eBudgeting.repositories.FormulaColumnRepository;
import biz.thaicom.eBudgeting.repositories.FormulaStrategyRepository;
import biz.thaicom.eBudgeting.repositories.BudgetTypeRepository;
import biz.thaicom.eBudgeting.repositories.ObjectiveRepository;
import biz.thaicom.eBudgeting.repositories.ObjectiveTypeRepository;

@Service
@Transactional
public class EntityServiceJPA implements EntityService {
	private static final Logger logger = LoggerFactory.getLogger(EntityServiceJPA.class);
	
	@Autowired
	private ObjectiveRepository objectiveRepository;
	
	@Autowired
	private ObjectiveTypeRepository objectiveTypeRepository;
	
	@Autowired
	private BudgetTypeRepository budgetTypeRepository;
	
	@Autowired
	private FormulaStrategyRepository formulaStrategyRepository;
	
	@Autowired
	private FormulaColumnRepository formulaColumnRepository;

	@Override
	public ObjectiveType findObjectiveTypeById(Long id) {
		return objectiveTypeRepository.findOne(id);
	}

	@Override
	public Set<ObjectiveType> findChildrenObjectiveType(ObjectiveType type) {
		ObjectiveType self = objectiveTypeRepository.findOne(type.getId());
		return self.getChildren();
	}

	@Override
	public ObjectiveType findParentObjectiveType(ObjectiveType type) {
		ObjectiveType self = objectiveTypeRepository.findOne(type.getId());
		return self.getParent();
	}

	@Override
	public List<Objective> findObjectivesOf(ObjectiveType type) {
		return objectiveRepository.findByTypeId(type.getId());
	}

	@Override
	public List<Objective> findObjectiveChildren(Objective objective) {
		return findObjectiveChildrenByObjectiveId(objective.getId());
	}

	@Override
	public Objective findParentObjective(Objective objective) {
		Objective self = objectiveRepository.findOne(objective.getId());
		
		return self.getParent();
	}

	@Override
	public Objective findOjectiveById(Long id) {
		Objective objective = objectiveRepository.findOne(id);
		objective.doBasicLazyLoad();
		
		return objective;
	}

	@Override
	public List<Objective> findObjectiveChildrenByObjectiveId(Long id) {
		Objective self = objectiveRepository.findOne(id);
		if(self != null) {
			logger.debug("--id: " + self.getId());
			logger.debug("children.getSize() = " + self.getChildren().size());
			self.getChildren().size();
			for(Objective objective: self.getChildren()) {
				logger.debug(" child.id --> " + objective.getId());
				objective.doBasicLazyLoad();
			}
		}
		return self.getChildren();
	}

	@Override
	public List<Objective> findRootObjectiveByFiscalyear(Integer fiscalYear, Boolean eagerLoad) {
		
		List<Objective> list = objectiveRepository.findByParentIdAndFiscalYear(null, fiscalYear);
		if(eagerLoad == true) {
			for(Objective objective: list) {
				objective.doEagerLoad();
			}
		} else {
			for(Objective objective : list) {
				objective.doBasicLazyLoad();
			}
		}
		return list;
	}

	@Override
	public List<Objective> findRootFiscalYear() {
		return objectiveRepository.findRootFiscalYear();
	}

	@Override
	public List<Integer> findObjectiveTypeRootFiscalYear() {
		return objectiveTypeRepository.findRootFiscalYear();
	}

	@Override
	public List<ObjectiveType> findObjectiveTypeByFiscalYearEager(
			Integer fiscalYear, Long parentId) {
		List<ObjectiveType>  list = objectiveTypeRepository.findByFiscalYearAndParentId(fiscalYear, parentId);
		
		// now we'll have to just fill 'em up
		for(ObjectiveType type : list) {
			deepInitObjectiveType(type);
		}
		
		return list;
		
	}

	private void deepInitObjectiveType(ObjectiveType type) {
		if(type == null || type.getChildren() == null || type.getChildren().size() == 0) {
			return;
		} else {
			type.getChildren().size();
			for(ObjectiveType t : type.getChildren()) {
				deepInitObjectiveType(t);
			}
		}
	}

	@Override
	public List<BudgetType> findRootBudgetType() {
		return budgetTypeRepository.findRootBudgetType();
	}
	
	@Override
	public BudgetType findBudgetTypeById(Long id) {
		BudgetType b = budgetTypeRepository.findOne(id);
		if(b!=null) {
			b.doBasicLazyLoad();
		}
		return b;
	}

	@Override
	public BudgetType findBudgetTypeEagerLoadById(Long id, Boolean isLoadParent) {
		BudgetType b = findBudgetTypeById(id);
		b.doEagerLoad();
		
		if(isLoadParent) {
			b.doLoadParent();
		}
		
		return b;
	}

	@Override
	public List<Integer> findFiscalYearBudgetType() {
		List<Integer> fiscalYears = budgetTypeRepository.findFiscalYears();
		
		return fiscalYears;
	}

	@Override
	@Transactional (propagation = Propagation.REQUIRED, readOnly = true)
	public List<Breadcrumb> createBreadCrumbBudgetType(String prefix,
			Integer fiscalYear, BudgetType budgetType) {
		if(budgetType == null) {
			return null;
		}
		
		BudgetType current = budgetTypeRepository.findOne(budgetType.getId());
		
		Stack<Breadcrumb> stack = new Stack<Breadcrumb>();
		
		while(current != null) {
			Breadcrumb b = new Breadcrumb();
			if(current.getParent() == null) {
				// this is the root!
				b.setUrl(prefix + "/" + fiscalYear + "/" + current.getId() + "/");
				b.setValue("ปี " + fiscalYear);
				stack.push(b);
				
				b = new Breadcrumb();
				b.setUrl(prefix+ "/" );
				b.setValue("ROOT");
				stack.push(b);
				
			} else {
			
				
				b.setUrl(prefix + "/" + + fiscalYear + "/" + current.getId() + "/");
				b.setValue(current.getName());
				stack.push(b);
			}
			
			current = current.getParent();
		}
		
		List<Breadcrumb> list = new ArrayList<Breadcrumb>();
		
		while (stack.size() > 0) {
			list.add(stack.pop());
		}
		
		return list;
	}

	@Override
	public List<FormulaStrategy> findFormulaStrategyByfiscalYearAndTypeId(
			Integer fiscalYear, Long budgetTypeId) {
		List<FormulaStrategy> list = formulaStrategyRepository.findByfiscalYearAndType_idOrderByIndexAsc(fiscalYear, budgetTypeId);
		for(FormulaStrategy strategy : list) {
			strategy.getFormulaColumns().size();
		}
		
		return list;
	}

	@Override
	public FormulaStrategy saveFormulaStrategy(FormulaStrategy strategy) {
		return formulaStrategyRepository.save(strategy);
		
	}

	@Override
	public void deleteFormulaStrategy(Long id) {
		// we'll have to update the rest of index !
		// so get the one we want to delete first 
		FormulaStrategy strategy = formulaStrategyRepository.findOne(id);
		
		formulaStrategyRepository.delete(id);
		formulaStrategyRepository.reIndex(strategy.getIndex(), 
				strategy.getFiscalYear(), strategy.getType());
	}

	@Override
	public void deleteFormulaColumn(Long id) {
		// get this one first
		FormulaColumn column = formulaColumnRepository.findOne(id);
		formulaColumnRepository.delete(id);
		formulaColumnRepository.reIndex(column.getIndex(), column.getStrategy());
	}

	@Override
	public FormulaColumn saveFormulaColumn(
			FormulaColumn formulaColumn) {
		return formulaColumnRepository.save(formulaColumn);
	}

	@Override
	public FormulaColumn updateFormulaColumn(
			FormulaColumn formulaColumn) {
		// so we'll get FormulaColumn First
		FormulaColumn columnFromJpa = formulaColumnRepository.findOne(
				formulaColumn.getId());
		
		// now update this columnFromJpa
		columnFromJpa.setColumnName(formulaColumn.getColumnName());
		columnFromJpa.setIsFixed(formulaColumn.getIsFixed());
		columnFromJpa.setUnitName(formulaColumn.getUnitName());
		columnFromJpa.setValue(formulaColumn.getValue());
		
		
		// and we can save now
		formulaColumnRepository.save(columnFromJpa);
		
		// and happily return 
		return columnFromJpa;
	}

	@Override
	public List<Breadcrumb> createBreadCrumbObjective(String prefix,
			Integer fiscalYear, Objective objective) {
		if(objective == null) {
			return null;
		}
		
		Objective current = objectiveRepository.findOne(objective.getId());
		
		Stack<Breadcrumb> stack = new Stack<Breadcrumb>();
		
		while(current != null) {
			Breadcrumb b = new Breadcrumb();
			if(current.getParent() == null) {
				// this is the root!
				b.setUrl(prefix + "/" + fiscalYear + "/" + current.getId() + "/");
				b.setValue("ปี " + fiscalYear);
				stack.push(b);
				
				b = new Breadcrumb();
				b.setUrl(prefix+ "/" );
				b.setValue("ROOT");
				stack.push(b);
				
			} else {
				b.setUrl(prefix + "/" + + fiscalYear + "/" + current.getId() + "/");
				Integer index=current.getIndex() +1;
				b.setValue(current.getType().getName() + "ที่ "+ index + ". <br/>" + current.getName());
				stack.push(b);
			}
			
			current = current.getParent();
		}
		
		List<Breadcrumb> list = new ArrayList<Breadcrumb>();
		
		while (stack.size() > 0) {
			list.add(stack.pop());
		}
		
		return list;
	}

	@Override
	public Objective objectiveDoEagerLoad(Long objectiveId) {
		Objective objective = objectiveRepository.findOne(objectiveId);
		objective.doEagerLoad();
		
		return objective;
	}

	@Override
	public Objective updateObjective(Objective objective) {
		// now get Objective form our DB first
		Objective objectiveFromJpa = objectiveRepository.findOne(objective.getId());
		
		if(objectiveFromJpa != null) {
			// OK go through the supposed model
			objectiveFromJpa.setName(objective.getName());
			objectiveFromJpa.setFiscalYear(objective.getFiscalYear());
			
			if(objective.getBudgetType() != null && objective.getBudgetType().getId() != null) {
				objectiveFromJpa.setBudgetType(objective.getBudgetType());
			} 
			
			if(objective.getParent() != null && objective.getParent().getId() != null) {
				objectiveFromJpa.setParent(objective.getParent());
			}
			
			if(objective.getType() != null && objective.getType().getId() != null) {
				objectiveFromJpa.setType(objective.getType());
			}
			
			// we don't do anything for children
			
			objectiveRepository.save(objectiveFromJpa);
		}
		
		return objectiveFromJpa;
		
	}

	@Override
	public List<ObjectiveBudgetProposalDTO> findObjectiveBudgetProposal(Integer fiscalYear, Long ownerId, Long objectiveId) {
		return objectiveRepository.findByObjectiveBudgetProposal(fiscalYear, ownerId, objectiveId);
	}
}

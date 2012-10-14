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

import biz.thaicom.eBudgeting.model.bgt.BudgetType;
import biz.thaicom.eBudgeting.model.bgt.BudgetTypeFormulaColumn;
import biz.thaicom.eBudgeting.model.bgt.BudgetTypeFormulaStrategy;
import biz.thaicom.eBudgeting.model.pln.Objective;
import biz.thaicom.eBudgeting.model.pln.ObjectiveType;
import biz.thaicom.eBudgeting.model.webui.Breadcrumb;
import biz.thaicom.eBudgeting.repositories.BudgetTypeFormulaColumnRepository;
import biz.thaicom.eBudgeting.repositories.BudgetTypeFormulaStrategyRepository;
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
	private BudgetTypeFormulaStrategyRepository budgetTypeFormulaStrategyRepository;
	
	@Autowired
	private BudgetTypeFormulaColumnRepository budgetTypeFormulaColumnRepository;

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
	public List<Integer> findRootFiscalYear() {
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
	public BudgetType findBudgetTypeEagerLoadById(Long id) {
		BudgetType b = findBudgetTypeById(id);
		b.doEagerLoad();
		
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
			BudgetType budgetType) {
		if(budgetType == null) {
			return null;
		}
		
		
		BudgetType current = budgetTypeRepository.findOne(budgetType.getId());
		
		// now we just have to init proxy
		
		
		Stack<Breadcrumb> stack = new Stack<Breadcrumb>();
		
		
		
		while(current != null) {
			Breadcrumb b = new Breadcrumb();
			b.setUrl(prefix + "/" + current.getId() + "/");
			b.setValue(current.getName());
			
			stack.push(b);
			
			current = current.getParent();
		}
		
		List<Breadcrumb> list = new ArrayList<Breadcrumb>();
		
		while (stack.size() > 0) {
			list.add(stack.pop());
		}
		
		return list;
	}

	@Override
	public List<BudgetTypeFormulaStrategy> findBudgetTypeFormulaStrategyByfiscalYearAndBudgetTypeId(
			Integer fiscalYear, Long budgetTypeId) {
		List<BudgetTypeFormulaStrategy> list = budgetTypeFormulaStrategyRepository.findByfiscalYearAndBudgetType_id(fiscalYear, budgetTypeId);
		for(BudgetTypeFormulaStrategy strategy : list) {
			strategy.getFormulaColumns().size();
		}
		
		return list;
	}

	@Override
	public void saveBudgetTypeFormulaStrategy(BudgetTypeFormulaStrategy strategy) {
		budgetTypeFormulaStrategyRepository.save(strategy);
		
	}

	@Override
	public void deleteBudgetTypeFormulaStrategy(Long id) {
		// we'll have to update the rest of index !
		// so get the one we want to delete first 
		
		
		budgetTypeFormulaStrategyRepository.delete(id);
	}

	@Override
	public void deleteBudgetTypeFormulaColumn(Long id) {
		budgetTypeFormulaColumnRepository.delete(id);
	}

	@Override
	public void saveBudgetTypeFormulaColumn(
			BudgetTypeFormulaColumn budgetTypeFormulaColumn) {
		budgetTypeFormulaColumnRepository.save(budgetTypeFormulaColumn);
	}
}

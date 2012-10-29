package biz.thaicom.eBudgeting.services;

import java.util.List;
import java.util.Set;
import java.util.Stack;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;
import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FormulaColumn;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;
import biz.thaicom.eBudgeting.models.bgt.ObjectiveBudgetProposalDTO;
import biz.thaicom.eBudgeting.models.bgt.ProposalStrategy;
import biz.thaicom.eBudgeting.models.bgt.RequestColumn;
import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;
import biz.thaicom.eBudgeting.models.webui.Breadcrumb;

public interface EntityService {
	
	//ObjectiveType
	public ObjectiveType findObjectiveTypeById(Long id);
	public Set<ObjectiveType> findChildrenObjectiveType(ObjectiveType type);
	public ObjectiveType findParentObjectiveType(ObjectiveType type);
	public List<Integer> findObjectiveTypeRootFiscalYear();
	public List<ObjectiveType> findObjectiveTypeByFiscalYearEager(Integer fiscalYear, Long parentId);

	
	//Objective
	public List<Objective> findObjectivesOf(ObjectiveType type);
	public List<Objective> findObjectiveChildren(Objective objective);
	public Objective findParentObjective(Objective objective);
	public Objective findOjectiveById(Long id);
	public List<Objective> findObjectiveChildrenByObjectiveId(Long id);
	public List<Objective> findRootObjectiveByFiscalyear(Integer fiscalYear, Boolean eagerLoad);
	public List<Objective> findRootFiscalYear();
	public List<Breadcrumb> createBreadCrumbObjective(String string,
			Integer fiscalYear, Objective objective);
	public Objective objectiveDoEagerLoad(Long ObjectiveId);
	public Objective updateObjective(Objective objective);
	
	public List<Objective> findChildrenObjectivewithBudgetProposal(Integer fiscalYear, Long ownerId, Long objectiveId, Boolean isChildrenTraversal);
	public List<Objective> findFlatChildrenObjectivewithBudgetProposal(
			Integer fiscalYear, Long ownerId, Long objectiveId);

	public Objective addBudgetTypeToObjective(Long id, Long budgetTypeId);
	public Objective removeBudgetTypeToObjective(Long id, Long budgetTypeId);
	public Objective updateObjectiveFields(Long id, String name, String code);
	public Objective saveObjective(Objective objective);
	public Objective newObjectiveWithParam(String name, String code, Long parentId,
			Long typeId);
	public Objective deleteObjective(Long id);
	
	//BudgetType
	public List<BudgetType> findRootBudgetType();
	public BudgetType findBudgetTypeById(Long id);
	public BudgetType findBudgetTypeEagerLoadById(Long id, Boolean isLoadParent);
	public List<Integer> findFiscalYearBudgetType();
	public List<Breadcrumb> createBreadCrumbBudgetType(String prefix,
			Integer fiscalYear, BudgetType budgetType);
	
	//FormulaStrategy
	public List<FormulaStrategy> findFormulaStrategyByfiscalYearAndTypeId(
			Integer fiscalYear, Long budgetTypeId);
	public FormulaStrategy saveFormulaStrategy(FormulaStrategy strategy);
	public void deleteFormulaStrategy(Long id);
	
	
	//FormulaColumn
	public void deleteFormulaColumn(Long id);
	public FormulaColumn saveFormulaColumn(FormulaColumn formulaColumn);
	public FormulaColumn updateFormulaColumn(FormulaColumn formulaColumn);
	
	//BudgetProposal
	public BudgetProposal findBudgetProposalById(Long budgetProposalId);
	public BudgetProposal saveBudgetProposal(BudgetProposal proposal);
	
	//ProposalStrategy
	public ProposalStrategy saveProposalStrategy(ProposalStrategy strategy, Long budgetProposalId, Long formulaStrategyId);
	public List<ProposalStrategy> findProposalStrategyByBudgetProposal(
			Long budgetProposalId);
	public List<ProposalStrategy> findProposalStrategyByFiscalyearAndObjective(
			Integer fiscalYear, Long ownerId, Long objectiveId);
	public ProposalStrategy deleteProposalStrategy(Long id);
	
	//RequestColumn
	public RequestColumn saveRequestColumn(RequestColumn requestColumn);








	


	


	

	
	
}

package biz.thaicom.eBudgeting.services;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.Stack;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;

import biz.thaicom.eBudgeting.models.bgt.AllocationRecord;
import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;
import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FormulaColumn;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;
import biz.thaicom.eBudgeting.models.bgt.ObjectiveBudgetProposalDTO;
import biz.thaicom.eBudgeting.models.bgt.ProposalStrategy;
import biz.thaicom.eBudgeting.models.bgt.RequestColumn;
import biz.thaicom.eBudgeting.models.hrx.Organization;
import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveRelations;
import biz.thaicom.eBudgeting.models.pln.ObjectiveTarget;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;
import biz.thaicom.eBudgeting.models.pln.TargetUnit;
import biz.thaicom.eBudgeting.models.pln.TargetValue;
import biz.thaicom.eBudgeting.models.pln.TargetValueAllocationRecord;
import biz.thaicom.eBudgeting.models.webui.Breadcrumb;
import biz.thaicom.eBudgeting.repositories.ObjectiveRelationsRepository;

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
	public List<Objective> findFlatChildrenObjectivewithBudgetProposalAndAllocation(
			Integer fiscalYear, Long objectiveId);

	public Objective addBudgetTypeToObjective(Long id, Long budgetTypeId);
	public Objective removeBudgetTypeToObjective(Long id, Long budgetTypeId);
	public Objective updateObjectiveFields(Long id, String name, String code);
	public Objective saveObjective(JsonNode objective);
	public Objective newObjectiveWithParam(String name, String code, Long parentId,
			Long typeId, String parentPath, Integer fiscalYear);
	public Objective deleteObjective(Long id);
	public void addTargetToObjective(Long id, Long targetId);
	
	public List<Objective> findObjectivesByFiscalyearAndTypeId(
			Integer fiscalYear, Long typeId);
	public Objective updateObjectiveParent(Long id, Long parentId);
	public Objective objectiveAddReplaceUnit(Long id, Long unitId);
	
	public List<ObjectiveRelationsRepository> findObjectiveRelationsByFiscalYearAndChildTypeRelation(
			Integer fiscalYear, Long childTypeId);
	
	public String initFiscalYear(Integer fiscalYear);
	public Page<Objective> findObjectivesByFiscalyearAndTypeId(
			Integer fiscalYear, Long typeId, Pageable pageable);
	
	
	
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
	public FormulaStrategy saveFormulaStrategy(JsonNode strategy);
	public void deleteFormulaStrategy(Long id);
	public FormulaStrategy updateFormulaStrategy(JsonNode strategy);
	public List<FormulaStrategy> findAllFormulaStrategyByfiscalYearAndBudgetType_ParentPathLike(
			Integer fiscalYear, String parentPath);
	public List<FormulaStrategy> findAllFormulaStrategyByfiscalYearAndIsStandardItemAndBudgetType_ParentPathLike(
			Integer fiscalYear, Boolean isStandardItem, Long budgetTypeId, String parentPath);


	
	
	//FormulaColumn
	public void deleteFormulaColumn(Long id);
	public FormulaColumn saveFormulaColumn(FormulaColumn formulaColumn);
	public FormulaColumn updateFormulaColumn(FormulaColumn formulaColumn);
	
	//BudgetProposal
	public BudgetProposal findBudgetProposalById(Long budgetProposalId);
	public BudgetProposal saveBudgetProposal(BudgetProposal proposal);
	public List<BudgetProposal> findBudgetProposalByObjectiveIdAndBudgetTypeId(Long objectiveId, Long budgetTypeId);

	
	//ProposalStrategy
	public ProposalStrategy saveProposalStrategy(ProposalStrategy strategy, Long budgetProposalId, Long formulaStrategyId);
	public List<ProposalStrategy> findProposalStrategyByBudgetProposal(
			Long budgetProposalId);
	public List<ProposalStrategy> findProposalStrategyByFiscalyearAndObjective(
			Integer fiscalYear, Long ownerId, Long objectiveId);
	public List<ProposalStrategy> findAllProposalStrategyByFiscalyearAndObjective(
			Integer fiscalYear, Long objectiveId);
	public ProposalStrategy deleteProposalStrategy(Long id);
	public ProposalStrategy updateProposalStrategy(Long id,
			JsonNode rootNode) throws JsonParseException, JsonMappingException, IOException;

	
	//RequestColumn
	public RequestColumn saveRequestColumn(RequestColumn requestColumn);
	
	//AllocationRecord
	public String initAllocationRecord(Integer fiscalYear, Integer round);
	public AllocationRecord updateAllocationRecord(Long id, JsonNode data);
	
	//BudgetReserved
	public String initReservedBudget(Integer fiscalYear);
	
	public Boolean updateBudgetProposalAndReservedBudget(JsonNode data);
	
	
	
	//ObjectiveTarget
	public List<ObjectiveTarget> findAllObjectiveTargets();
	public List<ObjectiveTarget> findAllObjectiveTargetsByFiscalyear(Integer fiscalYear);
	public ObjectiveTarget saveObjectiveTarget(ObjectiveTarget objectiveTarget);
	public ObjectiveTarget updateObjectiveTarget(ObjectiveTarget objectiveTarget);
	public ObjectiveTarget deleteObjectiveTarget(ObjectiveTarget objectiveTarget);
	public ObjectiveTarget findOneObjectiveTarget(Long id);
	public ObjectiveTarget updateObjectiveTarget(JsonNode node);
	public ObjectiveTarget saveObjectiveTarget(JsonNode node);
	public ObjectiveTarget deleteObjectiveTarget(Long id);

	//TargetUnit
	public List<TargetUnit> findAllTargetUnits();
	public TargetUnit saveTargetUnits(TargetUnit targetUnit);
	public TargetUnit updateTargetUnit(TargetUnit targetUnit);
	public TargetUnit deleteTargetUnit(TargetUnit targetUnit);
	public TargetUnit findOneTargetUnit(Long id);
	public TargetUnit updateTargetUnit(JsonNode node);
	public TargetUnit saveTargetUnit(JsonNode node);
	public TargetUnit deleteTargetUnit(Long id);
	
	//TargetValue
	public TargetValue saveTargetValue(JsonNode node, Organization workAt) throws 	Exception;
	public void saveLotsTargetValue(JsonNode node);
	
	//TargetValueAllocationRecord
	public TargetValueAllocationRecord saveTargetValueAllocationRecord(JsonNode node,
			Organization workAt);
	
	//ObjectiveRelations
	public ObjectiveRelations saveObjectiveRelations(JsonNode relation);
	public ObjectiveRelations updateObjectiveRelations(Long id,
			JsonNode relation);
	public List<ObjectiveRelationsRepository> findObjectiveRelationsByFiscalYearAndChildTypeRelationWithObjectiveIds(
			Integer fiscalYear, Long parentTypeId, List<Long> ids);










	









	


	


	

	
	
}

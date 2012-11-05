package biz.thaicom.eBudgeting.services;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;
import java.util.StringTokenizer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import biz.thaicom.eBudgeting.models.bgt.AllocationRecord;
import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;
import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FormulaColumn;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;
import biz.thaicom.eBudgeting.models.bgt.ProposalStrategy;
import biz.thaicom.eBudgeting.models.bgt.RequestColumn;
import biz.thaicom.eBudgeting.models.bgt.ReservedBudget;
import biz.thaicom.eBudgeting.models.hrx.Organization;
import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;
import biz.thaicom.eBudgeting.models.webui.Breadcrumb;
import biz.thaicom.eBudgeting.repositories.AllocationRecordRepository;
import biz.thaicom.eBudgeting.repositories.BudgetProposalRepository;
import biz.thaicom.eBudgeting.repositories.FormulaColumnRepository;
import biz.thaicom.eBudgeting.repositories.FormulaStrategyRepository;
import biz.thaicom.eBudgeting.repositories.BudgetTypeRepository;
import biz.thaicom.eBudgeting.repositories.ObjectiveRepository;
import biz.thaicom.eBudgeting.repositories.ObjectiveTypeRepository;
import biz.thaicom.eBudgeting.repositories.ProposalStrategyRepository;
import biz.thaicom.eBudgeting.repositories.RequestColumnRepositories;
import biz.thaicom.eBudgeting.repositories.ReservedBudgetRepository;

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
	
	@Autowired
	private BudgetProposalRepository budgetProposalRepository;
	
	@Autowired
	private RequestColumnRepositories requestColumnRepositories;
	
	@Autowired 
	private ProposalStrategyRepository proposalStrategyRepository;
	
	@Autowired 
	private AllocationRecordRepository allocationRecordRepository;
	
	@Autowired
	private ReservedBudgetRepository reservedBudgetRepository;
	
	@Autowired
	private ObjectMapper mapper;
	


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
//		Objective self = objectiveRepository.findOne(id);
//		if(self != null) {
//			logger.debug("--id: " + self.getId());
//			logger.debug("children.getSize() = " + self.getChildren().size());
//			self.getChildren().size();
//			for(Objective objective: self.getChildren()) {
//				if(objective != null) {
//					logger.debug(" child.id --> " + objective.getId());
//					objective.doBasicLazyLoad();
//				}
//			}
//		}
//		return self.getChildren();
		
		return objectiveRepository.findChildrenWithParentAndTypeAndBudgetType(id);
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
			
//			if(objective.getBudgetType() != null && objective.getBudgetType().getId() != null) {
//				objectiveFromJpa.setBudgetType(objective.getBudgetType());
//			} 
			
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
	public List<Objective> findChildrenObjectivewithBudgetProposal(
			Integer fiscalYear, Long ownerId, Long objectiveId, Boolean isChildrenTraversal) {
		List<Objective> objectives = objectiveRepository.findByObjectiveBudgetProposal(fiscalYear, ownerId, objectiveId);
		
		for(Objective objective : objectives) {
//			logger.debug("** " + objective.getBudgetType().getName());
			objective.doEagerLoadWithBudgetProposal(isChildrenTraversal);
		}
		return objectives;
	}

	@Override
	public BudgetProposal findBudgetProposalById(Long budgetProposalId) {
		return budgetProposalRepository.findOne(budgetProposalId);
	}

	@Override
	public String initReservedBudget(Integer fiscalYear) {
		Objective root = objectiveRepository.findRootOfFiscalYear(fiscalYear);
		String parentPathLikeString = "%."+root.getId()+"%";		
		List<Objective> list = objectiveRepository.findFlatByObjectiveBudgetProposal(fiscalYear,parentPathLikeString);
		
		// we will copy from the last round (index = 2)
					List<AllocationRecord> allocationRecordList = allocationRecordRepository
							.findAllByForObjective_fiscalYearAndIndex(fiscalYear, 2);
					
		// go through this one
		for(AllocationRecord record: allocationRecordList) {
			ReservedBudget reservedBudget = reservedBudgetRepository.findOneByBudgetTypeAndObjective(record.getBudgetType(), record.getForObjective());
			
			if(reservedBudget == null) {
				reservedBudget = new ReservedBudget();
			}
			reservedBudget.setAmountReserved(0L);
			reservedBudget.setBudgetType(record.getBudgetType());
			reservedBudget.setForObjective(record.getForObjective());

			
			reservedBudgetRepository.save(reservedBudget);
		}
		
//		List<RequestColumn> requestColumns = requestColumnRepositories.findAllByFiscalYear(fiscalYear);
//		for(RequestColumn rc : requestColumns) {
//			rc.setAllocatedAmount(rc.getAmount());
//			requestColumnRepositories.save(rc);
//		}
//	
//		List<FormulaColumn> formulaColumns = formulaColumnRepository.findAllByFiscalYear(fiscalYear);
//		for(FormulaColumn fc : formulaColumns) {
//			fc.setAllocatedValue(fc.getValue());
//			formulaColumnRepository.save(fc);
//		}
		

		return "success";
	

	}

	
	@Override
	public String initAllocationRecord(Integer fiscalYear, Integer round) {
		Objective root = objectiveRepository.findRootOfFiscalYear(fiscalYear);
		String parentPathLikeString = "%."+root.getId()+"%";		
		List<Objective> list = objectiveRepository.findFlatByObjectiveBudgetProposal(fiscalYear,parentPathLikeString);
		
		List<BudgetProposal> proposalList = budgetProposalRepository
				.findBudgetProposalByFiscalYearAndParentPath(fiscalYear, parentPathLikeString);
		
		if(round == 1) {
			//loop through proposalList
			for(BudgetProposal proposal : proposalList) {
				Integer index = list.indexOf(proposal.getForObjective());
				Objective o = list.get(index);
				o.getProposals().size();
				
				o.addToSumBudgetTypeProposals(proposal);
				
				logger.debug("AAding proposal {} to objective: {}", proposal.getId(), o.getId());
				
				
				//o.getProposals().add(proposal);
				logger.debug("proposal size is " + o.getProposals().size());
				
			}
			
			// now loop through the Objective
			for(Objective o : list) {
				if(o.getSumBudgetTypeProposals() != null) {
					for(BudgetProposal b : o.getSumBudgetTypeProposals()) {
						// now get this on
						AllocationRecord allocationRecord = allocationRecordRepository.findOneByBudgetTypeAndObjectiveAndIndex(b.getBudgetType(), o ,round-1);  
						if(allocationRecord != null) {
							allocationRecord.setAmountAllocated(b.getAmountRequest());
						} else {
							
							
							allocationRecord = new AllocationRecord();
							allocationRecord.setAmountAllocated(b.getAmountRequest());
							allocationRecord.setBudgetType(b.getBudgetType());
							allocationRecord.setForObjective(o);
							allocationRecord.setIndex(round-1);
							
							allocationRecordRepository.save(allocationRecord);
						}
					}
				}
			}
		} else {
			// we will copy from the previous round...
			List<AllocationRecord> allocationRecordList = allocationRecordRepository
					.findAllByForObjective_fiscalYearAndIndex(fiscalYear, round-2);
			
			// go through this one
			for(AllocationRecord record: allocationRecordList) {
				AllocationRecord dbRecord = allocationRecordRepository.findOneByBudgetTypeAndObjectiveAndIndex(record.getBudgetType(), record.getForObjective(), round-1);
				
				if(dbRecord == null) {
					dbRecord = new AllocationRecord();
				}
				dbRecord.setAmountAllocated(record.getAmountAllocated());
				dbRecord.setBudgetType(record.getBudgetType());
				dbRecord.setForObjective(record.getForObjective());
				dbRecord.setIndex(round-1);
				
				allocationRecordRepository.save(dbRecord);
			}
		}
		return "success";
		
	}

	
	@Override
	public List<Objective> findFlatChildrenObjectivewithBudgetProposalAndAllocation(
			Integer fiscalYear, Long objectiveId) {
		String parentPathLikeString = "%."+objectiveId.toString()+"%";
		List<Objective> list = objectiveRepository.findFlatByObjectiveBudgetProposal(fiscalYear, parentPathLikeString);
		
		List<BudgetProposal> proposalList = budgetProposalRepository
				.findBudgetProposalByFiscalYearAndParentPath(fiscalYear, parentPathLikeString);
		
		//loop through proposalList
		for(BudgetProposal proposal : proposalList) {
			Integer index = list.indexOf(proposal.getForObjective());
			Objective o = list.get(index);
			o.getProposals().size();
			
			o.addToSumBudgetTypeProposals(proposal);
			
			logger.debug("AAding proposal {} to objective: {}", proposal.getId(), o.getId());
			
			
			//o.getProposals().add(proposal);
			logger.debug("proposal size is " + o.getProposals().size());
		}
		
		//now loop through allocationRecord
		List<AllocationRecord> recordList = allocationRecordRepository
				.findBudgetProposalByFiscalYearAndOwnerAndParentPath(fiscalYear, parentPathLikeString);
		for(AllocationRecord record : recordList) {
			Integer index = list.indexOf(record.getForObjective());
			Objective o = list.get(index);
			logger.debug("AAding Allocation {} to objective: {}", record.getId(), o.getId());
			
			if(o.getAllocationRecords()==null) {
				o.setAllocationRecords(new ArrayList<AllocationRecord>());
			}
			
			//o.getProposals().add(record);
			logger.debug("proposal size is " + o.getAllocationRecords().size());
		}
		
		// And lastly loop through reservedBudget
		List<ReservedBudget> reservedBudgets = reservedBudgetRepository.findAllByFiscalYearAndParentPathLike(fiscalYear, parentPathLikeString);
		for(ReservedBudget rb : reservedBudgets) {
			logger.debug("reservedBuget: {} ", rb.getForObjective().getId());
			Integer index = list.indexOf(rb.getForObjective());
			Objective o = list.get(index);
			
			o.getReservedBudgets().size();
			
			
		}
		
		return list;
	}
	
	@Override
	public List<Objective> findFlatChildrenObjectivewithBudgetProposal(
			Integer fiscalYear, Long ownerId, Long objectiveId) {
		String parentPathLikeString = "%."+objectiveId.toString()+"%";
		List<Objective> list = objectiveRepository.findFlatByObjectiveBudgetProposal(fiscalYear, ownerId, parentPathLikeString);
		
		List<BudgetProposal> proposalList = budgetProposalRepository
				.findBudgetProposalByFiscalYearAndOwnerAndParentPath(fiscalYear, ownerId, parentPathLikeString);
		
		//loop through proposalList
		for(BudgetProposal proposal : proposalList) {
			Integer index = list.indexOf(proposal.getForObjective());
			Objective o = list.get(index);
			logger.debug("AAding proposal {} to objective: {}", proposal.getId(), o.getId());
			
			o.addfilterProposal(proposal);
			//logger.debug("proposal size is " + o.getProposals().size());
		}
		
		
		return list;
	}

	@Override
	public ProposalStrategy deleteProposalStrategy(Long id) {
		ProposalStrategy proposalStrategy = proposalStrategyRepository.findOne(id);
		
		Long amountToBeReduced = proposalStrategy.getTotalCalculatedAmount();
		
		BudgetProposal b = proposalStrategy.getProposal();
		b.addAmountRequest(-amountToBeReduced);
		budgetProposalRepository.save(b);
		
		Organization owner = b.getOwner();
		
		// now walk up ward
		BudgetProposal temp = b;
		// OK we'll go through the amount of this one and it's parent!?
		while (temp.getForObjective().getParent() != null) {
			// now we'll get all proposal
			Objective parent = temp.getForObjective().getParent();
			temp = budgetProposalRepository.findByForObjectiveAndOwner(parent,owner);
			
			if(temp!=null) {
				temp.addAmountRequest(-amountToBeReduced);
			} 
			budgetProposalRepository.save(temp);
		}
		
		proposalStrategyRepository.delete(proposalStrategy);
		
		return proposalStrategy;
	}
	
	@Override
	public ProposalStrategy saveProposalStrategy(ProposalStrategy strategy, Long budgetProposalId, Long formulaStrategyId) {
		
		FormulaStrategy formulaStrategy= formulaStrategyRepository.findOne(formulaStrategyId);
		
		strategy.setFormulaStrategy(formulaStrategy);
		
		// 
		BudgetProposal b = budgetProposalRepository.findOne(budgetProposalId);
		b.addAmountRequest(strategy.getTotalCalculatedAmount());
		b.addAmountRequestNext1Year(strategy.getAmountRequestNext1Year());
		b.addAmountRequestNext2Year(strategy.getAmountRequestNext2Year());
		b.addAmountRequestNext3Year(strategy.getAmountRequestNext3Year());
		budgetProposalRepository.save(b);
		
		strategy.setProposal(b);
		
		Organization owner = b.getOwner();
		BudgetType budgetType = b.getBudgetType();
		
		BudgetProposal temp = b;
		// OK we'll go through the amount of this one and it's parent!?
		while (temp.getForObjective().getParent() != null) {
			// now we'll get all proposal
			Objective parent = temp.getForObjective().getParent();
			temp = budgetProposalRepository.findByForObjectiveAndOwnerAndBudgetType(parent,owner, budgetType);
			
			if(temp!=null) {
				temp.addAmountRequest(strategy.getTotalCalculatedAmount());
				temp.setBudgetType(budgetType);
				temp.addAmountRequestNext1Year(strategy.getAmountRequestNext1Year());
				temp.addAmountRequestNext2Year(strategy.getAmountRequestNext2Year());
				temp.addAmountRequestNext3Year(strategy.getAmountRequestNext3Year());
			} else {
				logger.debug("--------------------------------");
				temp = new BudgetProposal();
				temp.setForObjective(parent);
				temp.setOwner(owner);
				temp.setBudgetType(budgetType);
				temp.setAmountRequest(strategy.getTotalCalculatedAmount());
				temp.setAmountRequestNext1Year(strategy.getAmountRequestNext1Year());
				temp.setAmountRequestNext2Year(strategy.getAmountRequestNext2Year());
				temp.setAmountRequestNext3Year(strategy.getAmountRequestNext3Year());
			}
			logger.debug("================================temp.getBudgetType() {}", temp.getBudgetType());
			budgetProposalRepository.save(temp);
		}
		
		
		ProposalStrategy strategyJpa =  proposalStrategyRepository.save(strategy);
		
		if(strategy.getRequestColumns() != null) {
			// we have to save these columns first
			
			for(RequestColumn rc : strategy.getRequestColumns()) {
				rc.setProposalStrategy(strategyJpa);
				requestColumnRepositories.save(rc);
			}
		}
		
		return strategyJpa;
	}

	@Override
	public BudgetProposal saveBudgetProposal(BudgetProposal proposal) {
		logger.debug("budgetType id: " + proposal.getBudgetType().getId());
		// make sure we have budgetType
		BudgetType b = budgetTypeRepository.findOne(proposal.getBudgetType().getId());
		proposal.setBudgetType(b);
		
		return budgetProposalRepository.save(proposal);
	}

	@Override
	public RequestColumn saveRequestColumn(RequestColumn requestColumn) {
		return requestColumnRepositories.save(requestColumn);
	}

	@Override
	public Objective addBudgetTypeToObjective(Long id, Long budgetTypeId) {
		// Ok so we get one objective
		Objective obj = objectiveRepository.findOne(id);
		
		if(obj!= null) {
			//now find the budgetType
			BudgetType b = budgetTypeRepository.findOne(budgetTypeId);
			
			//now we're just ready to add to obj
			obj.getBudgetTypes().add(b);
			objectiveRepository.save(obj);
			
			return obj;
		} else {
			return null;
		}
	}

	@Override
	public Objective removeBudgetTypeToObjective(Long id, Long budgetTypeId) {
		// Ok so we get one objective
		Objective obj = objectiveRepository.findOne(id);
		
		if(obj!= null) {
			//now find the budgetType
			BudgetType b = budgetTypeRepository.findOne(budgetTypeId);
			
			//now we're just ready to add to obj
			obj.getBudgetTypes().remove(b);
			objectiveRepository.save(obj);
			
			return obj;
		} else {
			return null;
		}
	}

	@Override
	public Objective updateObjectiveFields(Long id, String name, String code) {
		/// Ok so we get one objective
		Objective obj = objectiveRepository.findOne(id);
		
		obj.setName(name);
		obj.setCode(code);
		
		objectiveRepository.save(obj);
		return obj;
	}

	@Override
	public Objective saveObjective(Objective objective) {
		
		
		return objectiveRepository.save(objective);
	}

	@Override
	public Objective newObjectiveWithParam(String name, String code, Long parentId,
			Long typeId) {
		Objective obj = new Objective();
		obj.setName(name);
		obj.setCode(code);
		
		Objective parent = objectiveRepository.findOne(parentId);
		ObjectiveType type = objectiveTypeRepository.findOne(typeId);
		
		obj.setParent(parent);
		obj.setType(type);
		
		obj.setIsLeaf(true);
		obj.setIndex(parent.getChildren().size());
		
		// now the parent will not be leaf node anymore
		parent.setIsLeaf(false);
		objectiveRepository.save(parent);
		
		return objectiveRepository.save(obj);
	}

	@Override
	public Objective deleteObjective(Long id) {
		// ok we'll have to get this one first
		Objective obj = objectiveRepository.findOne(id);
		
		//then get its parent
		Objective parent = obj.getParent();
		
		parent.getChildren().remove(obj);
		
		if(parent.getChildren().size() == 0) {
			parent.setIsLeaf(true);
			objectiveRepository.save(parent);
		} else {
			objectiveRepository.reIndex(obj.getIndex(), parent);
		}
		objectiveRepository.delete(obj);
		
		return obj;
	}

	@Override
	public List<ProposalStrategy> findProposalStrategyByBudgetProposal(
			Long budgetProposalId) {
		BudgetProposal budgetProposal = budgetProposalRepository.findOne(budgetProposalId);
		return proposalStrategyRepository.findByProposal(budgetProposal);
	}

	@Override
	public List<ProposalStrategy> findProposalStrategyByFiscalyearAndObjective(
			Integer fiscalYear, Long ownerId, Long objectiveId) {
		return proposalStrategyRepository.findByObjectiveIdAndfiscalYearAndOwnerId(fiscalYear, ownerId, objectiveId);
	}
	
	@Override
	public List<ProposalStrategy> findAllProposalStrategyByFiscalyearAndObjective(
			Integer fiscalYear, Long objectiveId) {
		return proposalStrategyRepository.findAllByObjectiveIdAndfiscalYearAndOwnerId(fiscalYear, objectiveId);
	}

	@Override
	public ProposalStrategy updateProposalStrategy(Long id,
			JsonNode rootNode) throws JsonParseException, JsonMappingException, IOException {

		ProposalStrategy strategy = proposalStrategyRepository.findOne(id);
		
		if(strategy != null) {
			// now get information from JSON string?
			
			strategy.setName(rootNode.get("name").asText());
			
			Long adjustedAmount = strategy.getTotalCalculatedAmount() - rootNode.get("totalCalculatedAmount").asLong();
			Long adjustedAmountRequestNext1Year = strategy.getAmountRequestNext1Year()==null?0:strategy.getAmountRequestNext1Year() - rootNode.get("amountRequestNext1Year").asLong();
			Long adjustedAmountRequestNext2Year = strategy.getAmountRequestNext2Year()==null?0:strategy.getAmountRequestNext2Year() - rootNode.get("amountRequestNext2Year").asLong();
			Long adjustedAmountRequestNext3Year = strategy.getAmountRequestNext3Year()==null?0:strategy.getAmountRequestNext3Year() - rootNode.get("amountRequestNext3Year").asLong();
			
			
			strategy.adjustTotalCalculatedAmount(adjustedAmount);
			
			strategy.adjustAmountRequestNext1Year(adjustedAmountRequestNext1Year);
			strategy.adjustAmountRequestNext2Year(adjustedAmountRequestNext2Year);
			strategy.adjustAmountRequestNext3Year(adjustedAmountRequestNext3Year);
			
			// now looping through the RequestColumns
			JsonNode requestColumnsArray = rootNode.get("requestColumns");
			
			List<RequestColumn> rcList = strategy.getRequestColumns();
			for(RequestColumn rc : rcList) {
				Long rcId = rc.getId();
				// now find this in
				for(JsonNode rcNode : requestColumnsArray) {
					if( rcId == rcNode.get("id").asLong()) {
						//we can just update this one ?
						rc.setAmount(rcNode.get("amount").asInt());
						break;
					}
				}
				
			}
			
			proposalStrategyRepository.save(strategy);
			
			// now save this budgetProposal
			BudgetProposal b = strategy.getProposal();
			b.adjustAmountRequest(adjustedAmount);
			b.adjustAmountRequestNext1Year(adjustedAmountRequestNext1Year);
			b.adjustAmountRequestNext2Year(adjustedAmountRequestNext2Year);
			b.adjustAmountRequestNext3Year(adjustedAmountRequestNext3Year);
			
			budgetProposalRepository.save(b);
			
			
			
			Organization owner = strategy.getProposal().getOwner();
			
			BudgetProposal temp = b;
			// OK we'll go through the amount of this one and it's parent!?
			while (temp.getForObjective().getParent() != null) {
				// now we'll get all proposal
				Objective parent = temp.getForObjective().getParent();
				temp = budgetProposalRepository.findByForObjectiveAndOwner(parent,owner);
				
				if(temp!=null) {
					temp.adjustAmountRequest(adjustedAmount);
					temp.adjustAmountRequestNext1Year(adjustedAmountRequestNext1Year);
					temp.adjustAmountRequestNext2Year(adjustedAmountRequestNext2Year);
					temp.adjustAmountRequestNext3Year(adjustedAmountRequestNext3Year);
				} else {
					temp = new BudgetProposal();
					temp.setForObjective(parent);
					temp.setOwner(owner);
//					temp.setBudgetType(parent.getBudgetType());
					temp.setAmountRequest(strategy.getTotalCalculatedAmount());
					temp.setAmountRequestNext1Year(strategy.getAmountRequestNext1Year());
					temp.setAmountRequestNext2Year(strategy.getAmountRequestNext2Year());
					temp.setAmountRequestNext3Year(strategy.getAmountRequestNext3Year());
				}
				budgetProposalRepository.save(temp);
			}
			
			return strategy;
		} else {
			return null;
		}
		
		
	}

	@Override
	public FormulaStrategy updateFormulaStrategy(JsonNode strategy) {
		Long formulaStrategyId=strategy.get("id").asLong();
		
		FormulaStrategy formulaStrategy = formulaStrategyRepository.findOne(formulaStrategyId);
		
		if(formulaStrategy != null) {
			String name = strategy.get("name").asText();
			formulaStrategy.setName(name);
			
			formulaStrategyRepository.save(formulaStrategy);
		}
		
		return formulaStrategy;
	}

	@Override
	public AllocationRecord updateAllocationRecord(Long id, JsonNode data) {
		AllocationRecord record = allocationRecordRepository.findOne(id);
		
		// now update the value
		Long amountUpdate = data.get("amountAllocated").asLong();
		Long oldAmount = record.getAmountAllocated();
		Long adjustedAmount = oldAmount - amountUpdate;
		
		Integer index = record.getIndex();
		BudgetType budgetType = record.getBudgetType();
		Objective objective = record.getForObjective();
		
		record.setAmountAllocated(amountUpdate);
		allocationRecordRepository.save(record);
		
		
		// now looking back
		Objective parent = objective.getParent();
		while(parent.getParent() != null) {
			logger.debug("parent.id: {}", parent.getId());
			AllocationRecord temp = allocationRecordRepository.findOneByBudgetTypeAndObjectiveAndIndex(budgetType, parent, index);
			
			temp.adjustAmountAllocated(adjustedAmount);
			
			allocationRecordRepository.save(temp);
			
			parent = parent.getParent();
			logger.debug("parent.id--: {}", parent.getId());
		}
		
		return record;
	}

	@Override
	public List<BudgetProposal> findBudgetProposalByObjectiveIdAndBudgetTypeId(Long objectiveId, Long budgetTypeId) {
		
		return budgetProposalRepository.findByForObjective_idAndBudgetType_id(objectiveId, budgetTypeId);
	}

	@Override
	public Boolean updateBudgetProposalAndReservedBudget(JsonNode data) {
		//deal with BudgetReseved first
		JsonNode reservedBudgetJson =  data.get("reservedBudget");
		
		Long rbId = reservedBudgetJson.get("id").asLong();
		Long objectiveId = reservedBudgetJson.get("forObjective").get("id").asLong();
		Long budgetTypeId = reservedBudgetJson.get("budgetType").get("id").asLong();
		
		//get Objective first
		Objective currentObj = objectiveRepository.findOne(objectiveId);
		//then BudgetType
		BudgetType currentBudgetType = budgetTypeRepository.findOne(budgetTypeId);
		
		//now find the one
		ReservedBudget rb = reservedBudgetRepository.findOne(rbId);
		
		//get Old value 
		Long oldAmountReserved = rb.getAmountReserved();
		if(oldAmountReserved == null) {
			oldAmountReserved = 0L;
		}
		Long newAmountReserved = reservedBudgetJson.get("amountReserved").asLong();
		Long adjustedAmountReserved = oldAmountReserved - newAmountReserved;
		
		rb.setAmountReserved(newAmountReserved);
		
		//should be OK to save here
		reservedBudgetRepository.save(rb);
		
		// OK will have to travesre back up .. we can get the parent path
		String parentPath = currentObj.getParentPath();
		//we will tokenize and put it in List<Long>
		List<Long> parentIds = new ArrayList<Long>();
		
		StringTokenizer tokens = new StringTokenizer(parentPath, ".");
		
		while(tokens.hasMoreTokens()) {
			String token = tokens.nextToken();
			//convert to Long
			Long parentId = Long.parseLong(token);
			
			parentIds.add(parentId);
		}
		
		// We are ready to update the parent...
		
		List<ReservedBudget> parentReservedBudgets = reservedBudgetRepository.findAllByObjetiveIds(parentIds, currentBudgetType);
		for(ReservedBudget parentRB : parentReservedBudgets) {
			Long parentOldAmountReserved = parentRB.getAmountReserved();
			
			parentRB.setAmountReserved(parentOldAmountReserved - adjustedAmountReserved);
			// and we can save 'em
			reservedBudgetRepository.save(parentRB);
		}
		
		// now we're updating proposals
		// first get the budgetProposal into Hash
		Map<Long, JsonNode> budgetProposalMap = new HashMap<Long, JsonNode>();
		Map<Long, Long> ownerBudgetProposalAdjustedAllocationMap = new HashMap<Long, Long>();
		Map<Long, JsonNode> requestColumnMap = new HashMap<Long, JsonNode>();
		Map<Long, JsonNode> formulaColumnMap = new HashMap<Long, JsonNode>();
		Map<Long, JsonNode> proposalStrategyMap = new HashMap<Long, JsonNode>();
		for(JsonNode node : data.get("proposals")){
			budgetProposalMap.put(node.get("id").asLong(), node);
			
			for(JsonNode proposalStrategyNode : node.get("proposalStrategies")) {
				proposalStrategyMap.put(proposalStrategyNode.get("id").asLong(), proposalStrategyNode);
				
				for(JsonNode reqeustColumnNode : proposalStrategyNode.get("requestColumns")) {
					requestColumnMap.put(reqeustColumnNode.get("id").asLong(), reqeustColumnNode);
				}
				
				for(JsonNode formulaColumnNode : proposalStrategyNode.get("formulaStrategy").get("formulaColumns")) {
					
					if(!formulaColumnMap.containsKey(formulaColumnNode.get("id").asLong())) {
						formulaColumnMap.put(formulaColumnNode.get("id").asLong(), formulaColumnNode);
					}
				}
			}
			
		}
		
		List<BudgetProposal> proposals = budgetProposalRepository.findAllByForObjectiveAndBudgetType(currentObj, currentBudgetType);
		// ready to loop through and set the owner..
		for(BudgetProposal proposal : proposals) {
			JsonNode node = budgetProposalMap.get(proposal.getId());
			Long oldAmount = proposal.getAmountAllocated() == null ? 0L : proposal.getAmountAllocated();
			Long newAmount = node.get("amountAllocated").asLong();
			proposal.setAmountAllocated(newAmount);
			
			ownerBudgetProposalAdjustedAllocationMap.put(proposal.getOwner().getId(), oldAmount-newAmount);
			logger.debug("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++adjusted BudgetProposal: {} " , oldAmount - newAmount);
			budgetProposalRepository.save(proposal);
			
		}
		
		//now update the parents
		List<BudgetProposal> parentProposals = budgetProposalRepository.findAllByForObjectiveIdsAndBudgetType(parentIds, currentBudgetType);
		for(BudgetProposal parentProposal:  parentProposals) {
			Long adjustedAmount = ownerBudgetProposalAdjustedAllocationMap.get(parentProposal.getOwner().getId());
			
			if(parentProposal.getAmountAllocated() != null ) {
				parentProposal.setAmountAllocated(parentProposal.getAmountAllocated() - adjustedAmount);
			} else {
				parentProposal.setAmountAllocated(adjustedAmount);
			}
			
			budgetProposalRepository.save(parentProposal);
		}
		
		//last thing is to update formularStrategy & RequestColumns!
		
		// let's get the easy one first, request columns
		
		for(JsonNode rcNode : requestColumnMap.values()) {
			Long rcid = rcNode.get("id").asLong();
			RequestColumn rc = requestColumnRepositories.findOne(rcid);
			rc.setAllocatedAmount(rcNode.get("allocatedAmount").asInt());
			
			
			logger.debug("saving... rc.id {} with allocatedAmount {}", rc.getId(), rcNode.get("allocatedAmount").asInt());
			requestColumnRepositories.save(rc);
		}
		
		for(JsonNode fcNode : formulaColumnMap.values()) {
			Long fcid = fcNode.get("id").asLong();
			FormulaColumn fc = formulaColumnRepository.findOne(fcid);
			fc.setAllocatedValue(fcNode.get("allocatedValue").asLong());
			
			formulaColumnRepository.save(fc);
		}
		
		for(JsonNode psNode : proposalStrategyMap.values()) {
			Long psid = psNode.get("id").asLong();
			ProposalStrategy ps = proposalStrategyRepository.findOne(psid);
			ps.setTotalCalculatedAllocatedAmount(psNode.get("totalCalculatedAllocatedAmount").asLong());
			
			proposalStrategyRepository.save(ps);					
		}
		
		return true;
	}


}

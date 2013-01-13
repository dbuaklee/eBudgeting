package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;
import biz.thaicom.eBudgeting.models.bgt.ProposalStrategy;

public interface ProposalStrategyRepository extends
		PagingAndSortingRepository<ProposalStrategy, Long>, JpaSpecificationExecutor<ProposalStrategy> {

	public List<ProposalStrategy> findByProposal(BudgetProposal budgetProposal);
	
	@Query("" +
			"select distinct proposalStrategy " +
			"from ProposalStrategy proposalStrategy " +
			"	LEFT OUTER JOIN FETCH proposalStrategy.formulaStrategy formulaStrategy " +
			"	INNER JOIN FETCH proposalStrategy.proposal proposal " +
			"	INNER JOIN FETCH proposal.budgetType type " +
			"where proposal.owner.id=?2 and proposal.forObjective.fiscalYear=?1 " +
			"	and proposal.forObjective.id=?3 ")
	public List<ProposalStrategy> findByObjectiveIdAndfiscalYearAndOwnerId(Integer fiscalYear, Long ownerId, Long objectiveId);
	
	
	@Query("" +
			"select distinct proposalStrategy " +
			"from ProposalStrategy proposalStrategy " +
			"	INNER JOIN FETCH proposalStrategy.formulaStrategy formulaStrategy " +
			"	INNER JOIN FETCH formulaStrategy.formulaColumns formulaColumns " +
			"	INNER JOIN FETCH proposalStrategy.requestColumns requestColumns " +
			"	INNER JOIN FETCH proposalStrategy.proposal proposal " +
			"	INNER JOIN FETCH proposal.owner owner " +
			"where proposal.forObjective.fiscalYear=?1 " +
			"	and proposal.forObjective.id=?2 ")
	public List<ProposalStrategy> findAllByObjectiveIdAndfiscalYearAndOwnerId(Integer fiscalYear, Long objectiveId);

	
}

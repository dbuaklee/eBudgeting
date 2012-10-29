package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;
import biz.thaicom.eBudgeting.models.hrx.Organization;
import biz.thaicom.eBudgeting.models.pln.Objective;

public interface BudgetProposalRepository extends
		JpaSpecificationExecutor<BudgetProposal>, PagingAndSortingRepository<BudgetProposal, Long> {
	
	public BudgetProposal findById(Long budgetProposalId);

	
	
	
	@Query("" +
			"SELECT distinct proposal " +
			"FROM BudgetProposal proposal " +
			"	INNER JOIN FETCH proposal.forObjective objective " +
			"WHERE objective.fiscalYear =?1 and proposal.owner.id = ?2 and objective.parentPath like ?3 ")
	public List<BudgetProposal> findBudgetProposalByFiscalYearAndOwnerAndParentPath(
			Integer fiscalYear, Long ownerId, String parentPathLikeString);


	public BudgetProposal findByForObjectiveAndOwner(Objective parent,
			Organization owner);
}

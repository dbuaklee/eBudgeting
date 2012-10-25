package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;

public interface BudgetProposalRepository extends
		JpaSpecificationExecutor<BudgetProposal>, PagingAndSortingRepository<BudgetProposal, Long> {
	
	public BudgetProposal findById(Long budgetProposalId);

}

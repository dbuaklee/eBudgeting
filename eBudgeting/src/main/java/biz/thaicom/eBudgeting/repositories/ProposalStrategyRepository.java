package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;
import biz.thaicom.eBudgeting.models.bgt.ProposalStrategy;

public interface ProposalStrategyRepository extends
		PagingAndSortingRepository<ProposalStrategy, Long>, JpaSpecificationExecutor<ProposalStrategy> {

	public List<ProposalStrategy> findByProposal(BudgetProposal budgetProposal);
}

package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.AllocationRecord;
import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;

public interface AllocationRecordRepository extends
		JpaSpecificationExecutor<AllocationRecord>, PagingAndSortingRepository<AllocationRecord, Long> {
	
	@Query("" +
			"SELECT distinct record " +
			"FROM AllocationRecord record " +
			"	INNER JOIN FETCH record.budgetType budgetType " +
			"	INNER JOIN FETCH record.forObjective objective " +
			"WHERE objective.fiscalYear =?1 and objective.parentPath like ?2 ")
	public List<AllocationRecord> findBudgetProposalByFiscalYearAndOwnerAndParentPath(
			Integer fiscalYear,  String parentPathLikeString);
	
	

}

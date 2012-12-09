package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.AllocationRecord;
import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.pln.Objective;

public interface AllocationRecordRepository extends
		JpaSpecificationExecutor<AllocationRecord>, PagingAndSortingRepository<AllocationRecord, Long> {
	
	@Query("" +
			"SELECT distinct record " +
			"FROM AllocationRecord record " +
			"	LEFT JOIN FETCH record.budgetType budgetType " +
			"	INNER JOIN FETCH record.forObjective objective " +
			" " +
			"WHERE objective.fiscalYear =?1 and objective.parentPath like ?2 ")
	public List<AllocationRecord> findBudgetProposalByFiscalYearAndOwnerAndParentPath(
			Integer fiscalYear,  String parentPathLikeString);

	@Query("" +
			"SELECT record " +
			"FROM AllocationRecord record " +
			"WHERE record.budgetType = ?1 and record.forObjective = ?2 and record.index =?3 ")
	public AllocationRecord findOneByBudgetTypeAndObjectiveAndIndex(
			BudgetType budgetType, Objective o, Integer index);
	
	@Query("" +
			"SELECT record " +
			"FROM AllocationRecord record " +
			"WHERE record.budgetType is null and record.forObjective = ?1 and record.index =?2 ")
	public AllocationRecord findOneByObjectiveAndIndex(Objective o, Integer index);

	
	public List<AllocationRecord> findAllByForObjective_fiscalYearAndIndex(
			Integer fiscalYear, int i);
	

}

package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveTarget;
import biz.thaicom.eBudgeting.models.pln.TargetValueAllocationRecord;

public interface TargetValueAllocationRecordRepository extends
		JpaSpecificationExecutor<TargetValueAllocationRecord>, PagingAndSortingRepository<TargetValueAllocationRecord, Long> {
	
	public TargetValueAllocationRecord findOneByIndexAndForObjective(Integer index, Objective objective);

	
	public List<TargetValueAllocationRecord> findAllByForObjective_FiscalYearAndIndex(
			Integer fiscalYear, int index);


	public TargetValueAllocationRecord findOneByTargetAndForObjectiveAndIndex(
			ObjectiveTarget target, Objective forObjective, int index);


	public TargetValueAllocationRecord findOneByIndexAndForObjectiveAndTarget(
			int i, Objective o, ObjectiveTarget target);

}

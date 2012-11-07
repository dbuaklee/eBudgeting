package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.TargetUnit;

public interface TargetUnitRepository extends JpaSpecificationExecutor<TargetUnit>,
		PagingAndSortingRepository<TargetUnit, Long> {

}

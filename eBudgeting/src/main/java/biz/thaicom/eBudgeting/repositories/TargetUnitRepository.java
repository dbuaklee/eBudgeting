package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.TargetUnit;

public interface TargetUnitRepository extends JpaSpecificationExecutor<TargetUnit>,
		PagingAndSortingRepository<TargetUnit, Long> {

	@Query("" +
			"FROM TargetUnit " +
			"ORDER BY name asc ")
	List<TargetUnit> findAllSortedByName();

}

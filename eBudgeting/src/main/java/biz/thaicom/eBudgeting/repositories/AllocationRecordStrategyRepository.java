package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import biz.thaicom.eBudgeting.models.bgt.AllocationRecordStrategy;

public interface AllocationRecordStrategyRepository extends
		JpaRepository<AllocationRecordStrategy, Long> {

	@Query("" +
			"SELECT strategy " +
			"FROM AllocationRecordStrategy strategy " +
			"WHERE strategy.allocationRecord.index = ?1 " +
			"	and strategy.strategy.fiscalYear = ?2 ")
	List<AllocationRecordStrategy> findAllByIndexAndFiscalYear(Integer index,
			Integer fiscalYear);

}

package biz.thaicom.eBudgeting.repositories;



import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.ObjectiveName;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;

public interface ObjectiveNameRepository extends JpaSpecificationExecutor<ObjectiveName>,
		PagingAndSortingRepository<ObjectiveName, Long> {
	
	@Query("" +
			"SELECT max(o.index) " +
			"FROM ObjectiveName o " +
			"WHERE o.type=?1 AND o.fiscalYear=?2 ")
	public Integer findMaxIndexOfTypeAndFiscalYear(ObjectiveType type,
			Integer fiscalYear);

	@Query("" +
			"SELECT o " +
			"FROM ObjectiveName o " +
			"WHERE o.fiscalYear=?1 AND o.type.id = ?2 ")
	public Page<ObjectiveName> findAllObjectiveNameByFiscalYearAndTypeId(
			Integer fiscalYear, Long typeId, Pageable pageable);

	
	@Query("" +
			"SELECT max(o.code) " +
			"FROM Objective o " +
			"WHERE o.type=? AND o.fiscalYear=?2 ")
	public String findMaxCodeOfTypeAndFiscalYear(ObjectiveType type,
			Integer fiscalYear);

}

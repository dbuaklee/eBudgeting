package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;

public interface ObjectiveTypeRepository extends
		PagingAndSortingRepository<ObjectiveType, Long>, JpaSpecificationExecutor<ObjectiveType> {
	
	@Query("" +
			"SELECT distinct objectiveType.fiscalYear " +
			"FROM ObjectiveType objectiveType " +
			"")
	List<Integer> findRootFiscalYear();

	List<ObjectiveType> findByFiscalYearAndParentId(Integer fiscalYear, Long parentId);

	@Query("" +
			"SELECT objectiveType " +
			"FROM ObjectiveType objectiveType " +
			"WHERE objectiveType.parent.id=?1 " +
			"")
	public List<ObjectiveType> findByParentId(Long parentId);
}

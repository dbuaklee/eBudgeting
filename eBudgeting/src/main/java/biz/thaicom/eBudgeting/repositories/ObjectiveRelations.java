package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;

public interface ObjectiveRelations extends JpaSpecificationExecutor<ObjectiveRelations>,
		PagingAndSortingRepository<ObjectiveRelations, Long> {

	
	@Query("" +
			"SELECT relation.objective " +
			"FROM ObjectiveRelations relation " +
			"WHERE relation.fiscalYear=?1 AND relation.parent=?2 " +
			"	AND relation.childType=?3 ")
	public List<Objective> findChildrenByFiscalYearAndParentAndChildType(Integer fiscalYear, Objective parent, ObjectiveType childType);
	
	@Query("" +
			"SELECT relation " +
			"FROM ObjectiveRelation relation " +
			"WHERE relation.fiscalYear=?1 AND relation.parentType=?2 AND relation.childType=?3 ")
	public List<ObjectiveRelations> findAllByFiscalYearAndParentType(Integer fiscalYear, ObjectiveType parentType, ObjectiveType childType);
}

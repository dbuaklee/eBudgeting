package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveRelations;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;

public interface ObjectiveRelationsRepository extends JpaSpecificationExecutor<ObjectiveRelations>,
		PagingAndSortingRepository<ObjectiveRelations, Long> {

	
	@Query("" +
			"SELECT relation.objective " +
			"FROM ObjectiveRelations relation " +
			"WHERE relation.fiscalYear=?1 AND relation.parent=?2 " +
			"	AND relation.childType=?3 ")
	public List<Objective> findChildrenByFiscalYearAndParentAndChildType(Integer fiscalYear, Objective parent, ObjectiveType childType);
	
	@Query("" +
			"SELECT relation " +
			"FROM ObjectiveRelations relation " +
			"WHERE relation.fiscalYear=?1 AND relation.parentType=?2 AND relation.childType=?3 ")
	public List<ObjectiveRelationsRepository> findAllByFiscalYearAndParentTypeAndChildType(Integer fiscalYear, ObjectiveType parentType, ObjectiveType childType);
	
	@Query("" +
			"SELECT relation " +
			"FROM ObjectiveRelations relation " +
			"WHERE relation.fiscalYear=?1 AND relation.parentType=?2 ")
	public List<ObjectiveRelationsRepository> findAllByFiscalYearAndParentType(Integer fiscalYear, ObjectiveType parentType);
	
	@Query("" +
			"SELECT relation " +
			"FROM ObjectiveRelations relation " +
			"	INNER JOIN FETCH relation.objective objective " +
			"	LEFT OUTER JOIN FETCH objective.parent parent " +
			"	LEFT OUTER JOIN FETCH objective.units unit " +
			"WHERE relation.fiscalYear=?1 AND relation.childType=?2 ")
	public List<ObjectiveRelationsRepository> findAllByFiscalYearAndChildType(Integer fiscalYear, ObjectiveType childType);
	
	@Query("" +
			"SELECT relation " +
			"FROM ObjectiveRelations relation " +
			"	INNER JOIN FETCH relation.objective objective " +
			"	LEFT OUTER JOIN FETCH objective.parent parent " +
			"	LEFT OUTER JOIN FETCH objective.targets targets " +
			"WHERE relation.fiscalYear=?1 AND relation.childType=?2 AND objective.id in (?3) ")
	public List<ObjectiveRelationsRepository> findAllByFiscalYearAndChildTypeWithIds(Integer fiscalYear, ObjectiveType childType, List<Long> ids);

	@Modifying
	@Query("" +
			"DELETE ObjectiveRelations r where r.objective = ?1 OR r.parent = ?1 ")
	public void deleteAllObjective(Objective o);
	
}

package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveTarget;
import biz.thaicom.eBudgeting.models.pln.TargetUnit;

public interface ObjectiveTargetRepository extends
		JpaSpecificationExecutor<ObjectiveTarget>, PagingAndSortingRepository<ObjectiveTarget, Long> {

	public List<ObjectiveTarget> findAllByFiscalYear(Integer fiscalYear);

	@Query("" +
			"SELECT targets " +
			"FROM Objective o " +
			"	INNER JOIN o.targets targets " +
			"WHERE o.parentPath like ?2 " +
			"	AND targets.id = ?1 ")
	public List<ObjectiveTarget> findAllByIdAndChildrenOfObjectiveId(
			Long targetId, String string);
	
	@Query("" +
			"SELECT distinct target " +
			"FROM ObjectiveTarget target " +
			"	INNER JOIN FETCH target.forObjectives objective " +
			"WHERE objective.parentPath like ?1 ")
	public List<ObjectiveTarget> findAllByObjectiveParentPathLike(
			String parentPathLikeString);

	public ObjectiveTarget findOneByForObjectivesAndUnit(Objective obj,
			TargetUnit targetUnit);
}

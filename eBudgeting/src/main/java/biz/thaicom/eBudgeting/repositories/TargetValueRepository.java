package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.pln.TargetValue;

public interface TargetValueRepository extends JpaSpecificationExecutor<TargetValue>,
		PagingAndSortingRepository<TargetValue, Long> {

	@Query("" +
			"SELECT distinct targetValue " +
			"FROM TargetValue targetValue " +
			"	INNER JOIN targetValue.forObjective objective " +
			"	INNER JOIN targetValue.owner owner " +
			"WHERE owner.id =?1 and objective.parentPath like ?2 ")
	public List<TargetValue> findAllByOnwerIdAndObjectiveParentPathLike(Long ownerId, String parentPath);

	
	@Query("" +
			"SELECT distinct targetValue " +
			"FROM TargetValue targetValue" +
			"	INNER JOIN targetValue.target target " +
			"	INNER JOIN targetValue.forObjective objective " +
			"	INNER JOIN targetValue.owner owner " +
			"WHERE owner.id =?1 and target.id=?2 and objective.parentPath like ?3 ")
	public List<TargetValue> findAllByOnwerIdAndTargetIdAndObjectiveParentPathLike(
			Long onwerId, Long targetId, String parentPath);
	
	@Query("" +
			"SELECT distinct targetValue " +
			"FROM TargetValue targetValue" +
			"	INNER JOIN targetValue.target target " +
			"	INNER JOIN targetValue.forObjective objective " +
			"	INNER JOIN targetValue.owner owner " +
			"WHERE owner.id =?1 and target.id=?2 and objective.id = ?3 ")
	public List<TargetValue> findAllByOnwerIdAndTargetIdAndObjectiveId(
			Long onwerId, Long targetId, Long objectiveId);

	@Query("" +
			"SELECT distinct targetValue " +
			"FROM TargetValue targetValue" +
			"	INNER JOIN targetValue.target target " +
			"	INNER JOIN target.unit unit " +
			"	INNER JOIN targetValue.forObjective objective " +
			"	INNER JOIN targetValue.owner owner " +
			"WHERE owner.id =?1 and unit.id=?2 and objective.id = ?3 ")
	public List<TargetValue> findAllByOnwerIdAndTargetUnitIdAndObjectiveId(
			Long onwerId, Long targetUnitId, Long objectiveId);
	
	@Query("" +
			"SELECT distinct targetValue " +
			"FROM TargetValue targetValue" +
			"	INNER JOIN targetValue.target target " +
			"	INNER JOIN targetValue.forObjective objective " +
			"WHERE target.id=?1 and objective.id = ?2 ")
	public List<TargetValue> findAllByTargetIdAndObjectiveId(Long targetId, Long objectiveId);

	@Query("" +
			"SELECT distinct targetValue " +
			"FROM TargetValue targetValue " +
			"	INNER JOIN targetValue.forObjective objective " +
			"	INNER JOIN targetValue.target target " +
			"	INNER JOIN targetValue.owner owner " +
			"WHERE owner.id =?1 and objective.id in (?3) and target.id = ?2 ")
	public List<TargetValue> findAllByOnwerIdAndObjectiveIdIn(Long ownerId, Long targetId, List<Long> parentIds);


	
}

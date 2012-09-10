package biz.thaicom.eBudgeting.services;

import java.util.List;
import java.util.Set;

import biz.thaicom.eBudgeting.model.bgt.Objective;
import biz.thaicom.eBudgeting.model.bgt.ObjectiveType;

public interface ObjectiveService {
	
	public ObjectiveType findObjectiveTypeById(Long id);
	public Set<ObjectiveType> findChildrenObjectiveType(ObjectiveType type);
	public ObjectiveType findParentObjectiveType(ObjectiveType type);
	
	public List<Objective> findObjectivesOf(ObjectiveType type);
	public List<Objective> findObjectiveChildren(Objective objective);
	public Objective findParentObjective(Objective objective);
	public Objective findOjectiveById(Long id);
	public List<Objective> findObjectiveChildrenByObjectiveId(Long id);
	public List<Objective> findRootObjectiveByFiscalyear(Integer fiscalYear);
	public List<Integer> findRootFiscalYear();
	
	
}

package biz.thaicom.eBudgeting.models.pln;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="PLN_OBJECTIVERELATIONS")
@SequenceGenerator(name="PLN_OBJECTIVERELATIONS_SEQ", sequenceName="PLN_OBJECTIVERELATIONS_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class ObjectiveRelations implements Serializable{

	private static final long serialVersionUID = 5327046941515367599L;
	/**
	 * SerialUID 
	 */

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_OBJECTIVERELATIONS_SEQ")
	private Long id;
	
	@ManyToOne
	@JoinColumn(name="OBJECTIVE_ID")
	private Objective objective;
	
	@Basic
	private Integer fiscalYear;
	
	@Transient
	private List<Objective> childrenObjective;
	
	@ManyToOne
	@JoinColumn(name="PARENT_OBJECTIVE_ID")
	private Objective parent;
	
	@ManyToOne
	@JoinColumn(name="PARENT_OBJECTIVETYPE_ID")
	private ObjectiveType parentType;
	
	@ManyToOne
	@JoinColumn(name="CHILD_OBJECTIVETYPE_ID")
	private ObjectiveType childType;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Objective getObjective() {
		return objective;
	}

	public void setObjective(Objective objective) {
		this.objective = objective;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	public List<Objective> getChildrenObjective() {
		return childrenObjective;
	}

	public void setChildrenObjective(List<Objective> childrenObjective) {
		this.childrenObjective = childrenObjective;
	}

	public Objective getParent() {
		return parent;
	}

	public void setParent(Objective parent) {
		this.parent = parent;
	}

	public ObjectiveType getParentType() {
		return parentType;
	}

	public void setParentType(ObjectiveType parentType) {
		this.parentType = parentType;
	}

	public ObjectiveType getChildType() {
		return childType;
	}

	public void setChildType(ObjectiveType childType) {
		this.childType = childType;
	}
	
	
}

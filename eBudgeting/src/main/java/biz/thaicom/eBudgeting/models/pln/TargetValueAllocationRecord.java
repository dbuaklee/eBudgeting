package biz.thaicom.eBudgeting.models.pln;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="PLN_TARGETVALUEALLOCRECORD")
@SequenceGenerator(name="PLN_TARGETVALUEALLOCRECORD_SEQ", sequenceName="PLN_TARGETVALUEALLOCRECORD_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class TargetValueAllocationRecord implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7077074717822508582L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_TARGETVALUEALLOCRECORD_SEQ")
	private Long id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="OBJECTIVE_PLN_OBJECTIVE_ID")
	private Objective forObjective;
	
	@Basic
	private Long amountAllocated;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="OBJECTIVETARGET_ID")
	private ObjectiveTarget target;
	
	@Basic
	@Column(name="IDX")
	private Integer index;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Objective getForObjective() {
		return forObjective;
	}

	public void setForObjective(Objective forObjective) {
		this.forObjective = forObjective;
	}

	public Long getAmountAllocated() {
		return amountAllocated;
	}

	public void setAmountAllocated(Long amountAllocated) {
		this.amountAllocated = amountAllocated;
	}

	public ObjectiveTarget getTarget() {
		return target;
	}

	public void setTarget(ObjectiveTarget target) {
		this.target = target;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public void adjustAmountAllocated(Long adjustedRequestedValue) {
		this.amountAllocated -= adjustedRequestedValue;
		
	}
	
	
}

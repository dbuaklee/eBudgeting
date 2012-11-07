package biz.thaicom.eBudgeting.models.pln;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import biz.thaicom.eBudgeting.models.hrx.Organization;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="PLN_TARGETVALUE")
@SequenceGenerator(name="PLN_TARGETVALUE_SEQ", sequenceName="PLN_TARGETVALUE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class TargetValue implements Serializable{


	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6113798618441927601L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_TARGETVALUE_SEQ")
	private Long id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="OBJECTIVETARGET_ID")
	private ObjectiveTarget target;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="OWNER_ORAGANIZATION_ID")
	private Organization owner;
	
	@Basic
	private Long requestedValue;
		
	@Basic
	private Long allocatedValue;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ObjectiveTarget getTarget() {
		return target;
	}

	public void setTarget(ObjectiveTarget target) {
		this.target = target;
	}

	public Organization getOwner() {
		return owner;
	}

	public void setOwner(Organization owner) {
		this.owner = owner;
	}

	public Long getRequestedValue() {
		return requestedValue;
	}

	public void setRequestedValue(Long requestedValue) {
		this.requestedValue = requestedValue;
	}

	public Long getAllocatedValue() {
		return allocatedValue;
	}

	public void setAllocatedValue(Long allocatedValue) {
		this.allocatedValue = allocatedValue;
	}

	
	
	
}

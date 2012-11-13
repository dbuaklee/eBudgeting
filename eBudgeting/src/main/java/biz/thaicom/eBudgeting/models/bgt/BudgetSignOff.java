package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import biz.thaicom.eBudgeting.models.hrx.Organization;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_BUDGETSIGNOFF")
@SequenceGenerator(name="BGT_BUDGETSIGNOFF_SEQ", sequenceName="BGT_BUDGETSIGNOFF_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BudgetSignOff implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7415591062325503458L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_BUDGETSIGNOFF_SEQ")
	private Long id;
	
	@ManyToOne
	@JoinColumn(name="ORGANIZATION_ID")
	private Organization owner;
	
	@Basic
	private Integer round;
	
	@Basic
	private Integer fiscalYear;
	
	@Enumerated(EnumType.STRING)
	private SignOffStatus status;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Organization getOwner() {
		return owner;
	}

	public void setOwner(Organization owner) {
		this.owner = owner;
	}

	public Integer getRound() {
		return round;
	}

	public void setRound(Integer round) {
		this.round = round;
	}

	public SignOffStatus getStatus() {
		return status;
	}

	public void setStatus(SignOffStatus status) {
		this.status = status;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}
	
	
}

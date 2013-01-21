package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;
import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import biz.thaicom.eBudgeting.models.hrx.Organization;
import biz.thaicom.eBudgeting.models.hrx.Person;

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
	
	@ManyToOne
	@JoinColumn(name="HRX_LOCK1PERSON_ID")
	private Person lock1Person;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date lock1TimeStamp;
	
	@ManyToOne
	@JoinColumn(name="HRX_UNLOCK1PERSON_ID")
	private Person unLock1Person;

	@Temporal(TemporalType.TIMESTAMP)
	private Date unLock1TimeStamp;
	
	@ManyToOne
	@JoinColumn(name="HRX_LOCK2PERSON_ID")
	private Person lock2Person;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date lock2TimeStamp;
	
	@ManyToOne
	@JoinColumn(name="HRX_UNLOCK2PERSON_ID")
	private Person unLock2Person;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date unLock2TimeStamp;

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

	public Person getLock1Person() {
		return lock1Person;
	}

	public void setLock1Person(Person lock1Person) {
		this.lock1Person = lock1Person;
	}

	public Date getLock1TimeStamp() {
		return lock1TimeStamp;
	}

	public void setLock1TimeStamp(Date lock1TimeStamp) {
		this.lock1TimeStamp = lock1TimeStamp;
	}

	public Person getUnLock1Person() {
		return unLock1Person;
	}

	public void setUnLock1Person(Person unLock1Person) {
		this.unLock1Person = unLock1Person;
	}

	public Date getUnLock1TimeStamp() {
		return unLock1TimeStamp;
	}

	public void setUnLock1TimeStamp(Date unLock1TimeStamp) {
		this.unLock1TimeStamp = unLock1TimeStamp;
	}

	public Person getLock2Person() {
		return lock2Person;
	}

	public void setLock2Person(Person lock2Person) {
		this.lock2Person = lock2Person;
	}

	public Date getLock2TimeStamp() {
		return lock2TimeStamp;
	}

	public void setLock2TimeStamp(Date lock2TimeStamp) {
		this.lock2TimeStamp = lock2TimeStamp;
	}

	public Person getUnLock2Person() {
		return unLock2Person;
	}

	public void setUnLock2Person(Person unLock2Person) {
		this.unLock2Person = unLock2Person;
	}

	public Date getUnLock2TimeStamp() {
		return unLock2TimeStamp;
	}

	public void setUnLock2TimeStamp(Date unLock2TimeStamp) {
		this.unLock2TimeStamp = unLock2TimeStamp;
	}
	
	
	
	
}

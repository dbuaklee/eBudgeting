package biz.thaicom.eBudgeting.models.hrx;

import java.io.Serializable;

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

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="HRX_PERSON")
@SequenceGenerator(name="HRX_PERSON_SEQ", sequenceName="HRX_PERSON_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Person implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7690080618617825358L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="HRX_PERSON_SEQ")
	private Long id;
	
	@Basic
	private String firstName;
	
	@Basic
	private String lastName;
	
	@ManyToOne
	@JoinColumn(name = "WORKAT_HRX_ORGANIZATION_ID")
	private Organization workAt;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Organization getWorkAt() {
		return workAt;
	}

	public void setWorkAt(Organization workAt) {
		this.workAt = workAt;
	}

	
	
}

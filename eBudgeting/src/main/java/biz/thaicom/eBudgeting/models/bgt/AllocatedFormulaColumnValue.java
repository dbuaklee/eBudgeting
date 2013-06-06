package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_ALLOCFMCOLVALUE")
@SequenceGenerator(name="BGT_ALLOCFMCOLVALUE_SEQ", sequenceName="BGT_ALLOCFMCOLVALUE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class AllocatedFormulaColumnValue implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5122596487246533585L;

	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_ALLOCFMCOLVALUE_SEQ")
	private Long id;
	
	@Column(name="idx")
	private Integer index;
	
	private Long allocatedValue;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public Long getAllocatedValue() {
		return allocatedValue;
	}

	public void setAllocatedValue(Long allocatedValue) {
		this.allocatedValue = allocatedValue;
	}
	
	
}

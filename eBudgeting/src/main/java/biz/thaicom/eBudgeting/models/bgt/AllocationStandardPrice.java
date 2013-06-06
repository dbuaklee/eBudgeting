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
@Table(name="BGT_ALLOCSTDPRICE")
@SequenceGenerator(name="BGT_ALLOCSTDPRICE_SEQ", sequenceName="BGT_ALLOCSTDPRICE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class AllocationStandardPrice implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 337012498487117413L;

	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_ALLOCSTDPRICE_SEQ")
	private Long id;
	
	@Column(name="idx")
	private Integer index;
	
	private Integer standardPrice;

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

	public Integer getStandardPrice() {
		return standardPrice;
	}

	public void setStandardPrice(Integer standardPrice) {
		this.standardPrice = standardPrice;
	}
	
	
	
}

package biz.thaicom.security.models;

import java.util.List;

import javax.persistence.Entity;

@Entity
public class Menu {

	Long id;
	
	List<Program> programList;
}

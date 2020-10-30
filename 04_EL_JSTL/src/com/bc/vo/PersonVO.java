package com.bc.vo;

public class PersonVO {
	private String name, age, gender;
	private String[] hobby;
	
	
	public PersonVO() {}
	public PersonVO(String name, String age) {
		this.name = name;
		this.age = age;
	}
	public PersonVO(String name, String age, String gender, String[] hobby) {
		super();
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.hobby = hobby;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String[] getHobby() {
		return hobby;
	}
	public void setHobby(String[] hobby) {
		this.hobby = hobby;
	}
	
	
}

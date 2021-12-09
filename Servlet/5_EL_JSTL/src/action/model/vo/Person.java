package action.model.vo;

public class Person {
	private String name;
	private char gender;
//	private int age;
	private int nai;
	
	public Person() {}

	public Person(String name, char gender, int age) {
		super();
		this.name = name;
		this.gender = gender;
//		this.age = age;
		nai = age;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public int getNai() { // getNai라고 하면 메소드를 찾을 수 없다고 나옴
//		return age;
		return nai;
	}

	public void setNai(int age) {
//		this.age = age;
		nai = age;
	}

	@Override
	public String toString() {
//		return "Person [name=" + name + ", gender=" + gender + ", age=" + age + "]";
		return "Person [name=" + name + ", gender=" + gender + ", age=" + nai + "]";
	}
	
}

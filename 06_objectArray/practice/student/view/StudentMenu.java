package com.kh.practice.student.view;

import com.kh.practice.student.controller.StudentController;
import com.kh.practice.student.model.vo.Student;

public class StudentMenu {
	private StudentController ssm = new StudentController();
	public StudentMenu() {
		System.out.println("========== �л� ���� ��� ==========");
		Student[] sArr = ssm.printStudent();
		for(int i = 0; i < sArr.length; i++) {
			System.out.println(sArr[i].inform());
		}
		System.out.println();
		System.out.println("========== �л� ���� ��� ==========");
		double[] result = ssm.avgScore();
		System.out.println("�л� ���� �հ� : " + (int)result[0]);
		System.out.println("�л� ���� ��� : " + result[1]);
		System.out.println();
		System.out.println("========== ���� ��� ��� ==========");
		for(int i = 0; i < sArr.length; i++) {
			if(sArr[i].getScore() < ssm.CUT_LINE) {
				System.out.println(sArr[i].getName() + "�л��� ����� ����Դϴ�.");
			} else {
				System.out.println(sArr[i].getName() + "�л��� ����Դϴ�.");
			}
		}

	}
	

}
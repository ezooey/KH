package com.kh.variable;

public class D_PrintMethod {
	public void printlnExample() {
		String str1 = "�ȳ��ϼ���";
		String str2 = "�ݰ����ϴ�";
		System.out.println(str1);
		System.out.println(); // �ٹٲ޸� ����, �ٹٲ��� �ʿ��� �� ���
		System.out.println(str2);
	}
	
	public void printExample() {
		String str1 = "�ȳ��ϼ���";
		String str2 = "�ݰ����ϴ�";
		System.out.print(str1 + "\n"); // ��𼭵� ��� ����, \n�� ���ڿ��� ���� ������ ""�ȿ��� ���
		System.out.print(str2 + "%n"); // %n�� printf �ȿ����� ��� ����
//		-> �ݰ����ϴ�%n���� ���
//		System.out.print(); // �̴�δ� ��� �Ұ�
	}
	
	public void printfExample() {
		String str1 = "�ȳ��ϼ���";
		String str2 = "�ݰ����ϴ�";
		
//		System.out.printf(format, args)
//			format : ����
//			args : ���Ŀ� �� ������
		
		// �ȳ��ϼ���, �ڽſ��Դϴ�. �ݰ����ϴ�.
		System.out.printf("%s, �ڽſ��Դϴ�. %s.\n", str1, str2);
		// �ݰ����ϴ�, ģ�ϰ� ������.
		System.out.printf("%s, ģ�ϰ� ������.", str2);
		
		System.out.println();
		
		int age = 20;
		String name = "�ڽſ�";
		String job = "����";
		// �ȳ��ϼ���, ���� 20�� �ڽſ� �����Դϴ�. ������ �ݰ����ϴ�.
		System.out.printf("%s, ���� %s�� %s %s�Դϴ�. ������ %s.%n", str1, age, name, job, str2);
//		System.out.println();
		System.out.printf("%s, ���� %d�� %s %s�Դϴ�. ������ %s.", str1, age, name, job, str2);
	}

}
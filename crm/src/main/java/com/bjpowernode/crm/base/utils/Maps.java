package com.bjpowernode.crm.base.utils; /**
	����㷨�� guava ����ʵ�֣�������ʱ�򣬿���ֱ��ͨ�� Maps �ഴ��һ��
	HashMap��
	
	��������ȷ֪�� HashMap ��Ԫ�صĸ�����ʱ�򣬰�Ĭ
	���������ó� expectedSize / 0.75F + 1.0F ��һ������������Ժõ�ѡ�񣬵�
	�ǣ�ͬʱҲ������Щ�ڴ档

	���룺<!-- https://mvnrepository.com/artifact/com.google.guava/guava -->
        <dependency>
            <groupId>com.google.guava</groupId>
            <artifactId>guava</artifactId>
            <version>22.0</version>
        </dependency>


	Map<String, String> map = Maps.newHashMapWithExpectedSize(7);
*/
USE [KB301_Kolmogortsev]
GO

--������, ������������ ����������� ����� �� ���� ���������
SELECT shopName as '�������', productName as '�������� ������', amount as '����������' 
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE productName = '��������'

--������, ������������ ����������� ����� � ���������� ��������
SELECT shopName as '�������', productName as '�������� ������', street as '�����'
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE shopName = '��������' and productName = '������'

--������, ������������ ����������� ����� �� ������������ ����
SELECT shopName as '�������', productName as '�������� ������', dateFormatted as '����' 
FROM Kolmogortsev.storage INNER JOIN 
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE date = '21.05.2022' and productName = '������'

--������, ������������ ����������� ���� ������������ ������ � ���������� ��������
SELECT shopName as '�������� ��������', productName as '�������� ������', min(price) as '����������� ����' 
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE price = (SELECT min(price) FROM Kolmogortsev.storage WHERE storage.productId = 11)
GROUP BY productName, shopName

--������, ������������ ������������ ���� ������������ ������ �� ���� ���������
SELECT max(price) as '������������ ����', productName as '�������� ������'
FROM Kolmogortsev.shop INNER JOIN
	Kolmogortsev.storage ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId 
GROUP BY productName

--������, ������������ ������� ���� ������������ ������ �� ���� ��������� � ������������� �� ��������
SELECT CONVERT(DECIMAL(16, 2), avg(price)) as 'C������ ����', productName as '�������� ������'
FROM Kolmogortsev.shop INNER JOIN
	Kolmogortsev.storage ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
GROUP BY productName
ORDER BY avg(price) DESC

--������, ������������ ������ ���� �������, � ������� ���� �� ��������� 16.05.2022
SELECT TOP 5 productName as '�������� ������', dateFormatted as '����' 
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.product.productId = Kolmogortsev.storage.productId
WHERE dateFormatted <= '16.05.2022'
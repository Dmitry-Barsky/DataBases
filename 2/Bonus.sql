USE [KB301_Kolmogortsev]
GO

CREATE PROCEDURE [dbo].[Dynamic_Pivot]
	AS BEGIN
		SELECT Currency, -- ������� (�������), �������� �� �������� ��������� ��������� �����
		* -- �������� �� �������, ������� ������ � ����������� type, 
		-- ����������� ��������� �������� 
		FROM [Debet].[Card] -- ����� ����� ���� ���������
		PIVOT -- ������������ �����-�������
		(COUNT(model) -- ���������� �������, ����������� ���������� ������� �������
		FOR type -- ����������� �������, 
		-- ���������� �������� � ������� ����� �������� ����������� ��������
		IN([pc], [laptop], [printer]) --����������� ���������� �������� � ������� type, 
		 -- ������� ������� ������������ � �������� ����������, 
		 -- �.�. ��� ����� ������������� �� ���
		) pvt ;-- ����� ��� ������� �������
	END
	
EXEC [dbo].[Dynamic_Pivot] @TableSRC = 'Debet.Card',  --������� �������� (�������������)
							@ColumnName = '',--�������, ���������� �������� ��� �������� � PIVOT
							@Field = 'Summa',         --�������, ��� ������� ��������� ���������
							@FieldRows = 'CategoryName',--������� ��� ����������� �� �������
							@FunctionType = 'SUM'     --���������� �������, �� ��������� SUM
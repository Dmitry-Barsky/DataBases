USE [KB301_Kolmogortsev]
GO


--�������� ������� ����� ������ �����
CREATE PROCEDURE [dbo].[Viewing_balance_of_card] 
	AS BEGIN
		SELECT * FROM [Debet].[Card]
		WHERE Balance > 0
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Viewing_balance_of_card];
GO


--��������� ������ ����� � ����������� ������
CREATE PROCEDURE [dbo].[Top_balance_of_card] 
	@currency varchar (3),
	@top decimal(10, 2)
	AS BEGIN 
		IF EXISTS(SELECT * FROM [Debet].[Card] WHERE [Card].[�urrency] = @currency) BEGIN
			UPDATE [Debet].[Card]
			SET Balance += @top
			WHERE [Card].[�urrency] = @currency
			END
		ELSE 
			INSERT INTO [Debet].[Card] VALUES
				(@currency, @top)
	END
GO


EXEC [KB301_Kolmogortsev].[dbo].[Top_balance_of_card] @currency = 'RUB', @top = 12;
EXEC [KB301_Kolmogortsev].[dbo].[Top_balance_of_card] @currency = 'EUR', @top = 24;
EXEC [KB301_Kolmogortsev].[dbo].[Top_balance_of_card] @currency = 'USD', @top = 0.38;
GO


--������ ����� �� �����
CREATE PROCEDURE [dbo].[Withdraw_money]
	@count decimal(10, 2),
	@currency varchar (3)
	AS BEGIN 
		DECLARE @value as decimal(10, 2) =  ( 
			SELECT [Balance] FROM [Debet].[Card] WHERE [Card].[�urrency] = @currency
			)
		IF (@value < @count) BEGIN
			--RAISERROR(msg, severity, state)
			RAISERROR('������������ ������� �� ����� � ������ ������', 0, @value) 
			RETURN
		END

		UPDATE [Debet].[Card]
		SET Balance -= @count
		WHERE [Card].[�urrency] = @currency

		IF (@value = @count) 
			DELETE FROM [Debet].[Card] WHERE [Card].[�urrency] = @currency
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Withdraw_money] @count = 4.12, @currency = 'USD';
GO


--������� �� ����� ������ � ������
CREATE PROCEDURE [dbo].[Transaction]
	@fromValue varchar(3),
	@toValue varchar(3),
	@count decimal(10, 2)
	AS BEGIN
		DECLARE @value as decimal(10, 2) =  ( 
				SELECT [Balance] FROM [Debet].[Card] WHERE [Card].�urrency = @fromValue
			)

		IF (@value < @count) BEGIN
			RAISERROR('������� �� ��������, �.�. �� ����� ������������ �������', 0, @value)
			RETURN
		END

		IF NOT EXISTS(SELECT * FROM [Debet].[Card] WHERE [Card].[�urrency] = @toValue) BEGIN
			INSERT INTO [Debet].[Card] 
			VALUES 
				(@toValue, 0)
		END

		UPDATE [Debet].[Card]
		SET Balance -= @count
		WHERE [Card].�urrency = @fromValue;

		UPDATE [Debet].[Card]
		SET Balance += (SELECT Rate * @count FROM [Debet].[Buy_currency] WHERE [Debet].[Buy_currency].From_currency = @fromValue AND [Debet].[Buy_currency].To_currency = @toValue)
		WHERE [Card].[�urrency]= @toValue;

		PRINT '������� ��������'
		DELETE FROM [Debet].[Card] WHERE Balance = 0
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Transaction] @fromValue = 'RUB', @toValue = 'USD', @count = 23;
EXEC [KB301_Kolmogortsev].[dbo].[Transaction] @fromValue = 'EUR', @toValue = 'USD', @count = 4;
GO

--������ � ����� ������
CREATE PROCEDURE [dbo].[Balance]
	@currency varchar(3)
	AS BEGIN
		SELECT CONVERT(DECIMAL(10,2), sum(Balance * Rate)) as '����� ������', @currency as '������'
		FROM [Debet].[Card] 
		INNER JOIN [Debet].[Sell_currency] ON [Debet].[Sell_currency].[To_currency] = @currency AND [Card].[�urrency] = [Debet].[Sell_currency].[From_currency]
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Balance] @currency = 'EUR';
EXEC [KB301_Kolmogortsev].[dbo].[Balance] @currency = 'RUB';
GO


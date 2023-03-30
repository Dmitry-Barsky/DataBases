USE [KB301_Kolmogortsev]
GO


--Просмотр баланса карты разных валют
CREATE PROCEDURE [dbo].[Viewing_balance_of_card] 
	AS BEGIN
		SELECT * FROM [Debet].[Card]
		WHERE Balance > 0
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Viewing_balance_of_card];
GO


--Пополнить баланс карты в определённой валюте
CREATE PROCEDURE [dbo].[Top_balance_of_card] 
	@currency varchar (3),
	@top decimal(10, 2)
	AS BEGIN 
		IF EXISTS(SELECT * FROM [Debet].[Card] WHERE [Card].[Сurrency] = @currency) BEGIN
			UPDATE [Debet].[Card]
			SET Balance += @top
			WHERE [Card].[Сurrency] = @currency
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


--Снятие денег со счёта
CREATE PROCEDURE [dbo].[Withdraw_money]
	@count decimal(10, 2),
	@currency varchar (3)
	AS BEGIN 
		DECLARE @value as decimal(10, 2) =  ( 
			SELECT [Balance] FROM [Debet].[Card] WHERE [Card].[Сurrency] = @currency
			)
		IF (@value < @count) BEGIN
			--RAISERROR(msg, severity, state)
			RAISERROR('Недостаточно средств на карте в данной валюте', 0, @value) 
			RETURN
		END

		UPDATE [Debet].[Card]
		SET Balance -= @count
		WHERE [Card].[Сurrency] = @currency

		IF (@value = @count) 
			DELETE FROM [Debet].[Card] WHERE [Card].[Сurrency] = @currency
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Withdraw_money] @count = 4.12, @currency = 'USD';
GO


--Перевод из одной валюты в другую
CREATE PROCEDURE [dbo].[Transaction]
	@fromValue varchar(3),
	@toValue varchar(3),
	@count decimal(10, 2)
	AS BEGIN
		DECLARE @value as decimal(10, 2) =  ( 
				SELECT [Balance] FROM [Debet].[Card] WHERE [Card].Сurrency = @fromValue
			)

		IF (@value < @count) BEGIN
			RAISERROR('Перевод не выполнен, т.к. на счету недостаточно средств', 0, @value)
			RETURN
		END

		IF NOT EXISTS(SELECT * FROM [Debet].[Card] WHERE [Card].[Сurrency] = @toValue) BEGIN
			INSERT INTO [Debet].[Card] 
			VALUES 
				(@toValue, 0)
		END

		UPDATE [Debet].[Card]
		SET Balance -= @count
		WHERE [Card].Сurrency = @fromValue;

		UPDATE [Debet].[Card]
		SET Balance += (SELECT Rate * @count FROM [Debet].[Buy_currency] WHERE [Debet].[Buy_currency].From_currency = @fromValue AND [Debet].[Buy_currency].To_currency = @toValue)
		WHERE [Card].[Сurrency]= @toValue;

		PRINT 'Перевод выполнен'
		DELETE FROM [Debet].[Card] WHERE Balance = 0
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Transaction] @fromValue = 'RUB', @toValue = 'USD', @count = 23;
EXEC [KB301_Kolmogortsev].[dbo].[Transaction] @fromValue = 'EUR', @toValue = 'USD', @count = 4;
GO

--Баланс в одной валюте
CREATE PROCEDURE [dbo].[Balance]
	@currency varchar(3)
	AS BEGIN
		SELECT CONVERT(DECIMAL(10,2), sum(Balance * Rate)) as 'Общий баланс', @currency as 'Валюта'
		FROM [Debet].[Card] 
		INNER JOIN [Debet].[Sell_currency] ON [Debet].[Sell_currency].[To_currency] = @currency AND [Card].[Сurrency] = [Debet].[Sell_currency].[From_currency]
	END
GO

EXEC [KB301_Kolmogortsev].[dbo].[Balance] @currency = 'EUR';
EXEC [KB301_Kolmogortsev].[dbo].[Balance] @currency = 'RUB';
GO


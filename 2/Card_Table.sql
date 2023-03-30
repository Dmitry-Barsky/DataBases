USE [KB301_Kolmogortsev]
GO

CREATE TABLE [Debet].[Card] (
	[Ñurrency] [varchar] (3) NOT NULL,
	[Balance] [decimal] (10, 2) NULL
	) 	
	ON [PRIMARY]
GO

CREATE TABLE [Debet].[Sell_currency] (
	[From_currency] [varchar] (3) NULL,
	[To_currency] [varchar] (3) NULL,
	[Rate] [decimal] (10, 4) NULL
) ON [PRIMARY]
GO

CREATE TABLE [Debet].[Buy_currency] (
	[From_currency] [varchar] (3) NULL,
	[To_currency] [varchar] (3) NULL,
	[Rate] [decimal] (10, 4) NULL
) ON [PRIMARY]
GO

INSERT INTO [KB301_Kolmogortsev].[Debet].[Card] VALUES 
	('RUB', 1000), 
	('USD', 55),
	('EUR', 0),
	('CHF', 112);
GO

INSERT INTO [Debet].[Buy_currency] VALUES 
	('RUB', 'USD', 0.0165),
	('RUB', 'EUR', 0.0167),
	('RUB', 'CHF', 0.0169),
	('RUB', 'GBR', 0.0143),
	('USD', 'RUB', 60.66),
	('USD', 'EUR', 0.973),
	('USD', 'CHF', 0.953),
	('USD', 'GBR', 0.842),
	('EUR', 'RUB', 62.18),
	('EUR', 'USD', 1.03),
	('EUR', 'GBR', 0.8643),
	('EUR', 'CHF', 0.9787),
	('CHF', 'RUB', 63.4712),
	('CHF', 'EUR', 1.0235),
	('CHF', 'USD', 1.05),
	('CHF', 'GBR', 0.888)
GO

INSERT INTO [Debet].[Sell_currency] VALUES
	('RUB', 'USD', 0.0175),
	('RUB', 'EUR', 0.0177),
	('RUB', 'CHF', 0.0189),
	('RUB', 'GBR', 0.0151),
	('USD', 'RUB', 64.2),
	('USD', 'EUR', 0.745),
	('USD', 'CHF', 0.808),
	('USD', 'GBR', 0.65),
	('EUR', 'RUB', 67.5),
	('EUR', 'USD', 1.39),
	('EUR', 'GBR', 0.8636),
	('EUR', 'CHF', 0.964),
	('CHF', 'RUB', 62.5223),
	('CHF', 'EUR', 1.01),
	('CHF', 'USD', 1.025),
	('CHF', 'GBR', 0.8876)
GO
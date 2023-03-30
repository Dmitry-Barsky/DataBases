USE [KB301_Kolmogortsev]
GO

--запрос, показывающий определённый товар во всех магазинах
SELECT shopName as 'Магазин', productName as 'Название товара', amount as 'Количество' 
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE productName = 'Пельмени'

--запрос, показывающий определённый товар в конкретном магазине
SELECT shopName as 'Магазин', productName as 'Название товара', street as 'Улица'
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE shopName = 'Пятёрочка' and productName = 'Молоко'

--запрос, показывающий определённый товар на определенную дату
SELECT shopName as 'Магазин', productName as 'Название товара', dateFormatted as 'Дата' 
FROM Kolmogortsev.storage INNER JOIN 
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE date = '21.05.2022' and productName = 'Минтай'

--запрос, показывающий минимальную цену определённого товара в конкретном магазине
SELECT shopName as 'Название магазина', productName as 'Название товара', min(price) as 'Минимальная цена' 
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.shop ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
WHERE price = (SELECT min(price) FROM Kolmogortsev.storage WHERE storage.productId = 11)
GROUP BY productName, shopName

--запрос, показывающий максимальную цену определённого товара во всех магазинах
SELECT max(price) as 'Максимальная цена', productName as 'Название товара'
FROM Kolmogortsev.shop INNER JOIN
	Kolmogortsev.storage ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId 
GROUP BY productName

--запрос, показывающий среднюю цену определённого товара во всех магазинах и упорядоченную по убыванию
SELECT CONVERT(DECIMAL(16, 2), avg(price)) as 'Cредняя цена', productName as 'Название товара'
FROM Kolmogortsev.shop INNER JOIN
	Kolmogortsev.storage ON Kolmogortsev.storage.shopId = Kolmogortsev.shop.shopId INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.storage.productId = Kolmogortsev.product.productId
GROUP BY productName
ORDER BY avg(price) DESC

--запрос, показывающий первых пяти товаров, в которых дата не превышает 16.05.2022
SELECT TOP 5 productName as 'Название товара', dateFormatted as 'Дата' 
FROM Kolmogortsev.storage INNER JOIN
	Kolmogortsev.product ON Kolmogortsev.product.productId = Kolmogortsev.storage.productId
WHERE dateFormatted <= '16.05.2022'
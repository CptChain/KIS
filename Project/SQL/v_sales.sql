CREATE VIEW v_sales as
SELECT s.OrderNumber, c.Name as Client, p.Name as Product, sp.Quantity * p.Price as Cost, s.SaleStatus, DATE(s.OrderDate) as Date from autoparts.tbl_sales as s
JOIN autoparts.tbl_salesproducts as sp ON s.SaleID = sp.SaleID
JOIN autoparts.tbl_products as p ON sp.ProductID = p.ProductID
JOIN autoparts.tbl_clients as c ON s.ClientID = c.ClientID
ORDER BY s.OrderNumber

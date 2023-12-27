CREATE VIEW v_verzendlijst
AS
SELECT DISTINCT mhl_suppliers.id AS ID, 
IF(ISNULL(mhl_suppliers.p_address) OR mhl_suppliers.p_address = '', CONCAT(mhl_suppliers.straat, ' ', mhl_suppliers.huisnr), mhl_suppliers.p_address) AS adres, 
IF(ISNULL(mhl_suppliers.p_address) OR mhl_suppliers.p_address = '', mhl_suppliers.postcode, mhl_suppliers.p_postcode) AS postcode, 
IF(ISNULL(mhl_suppliers.p_address) OR mhl_suppliers.p_address = '', city1.name, city2.name) AS city
FROM mhl_suppliers
LEFT JOIN mhl_contacts ON mhl_contacts.supplier_ID = mhl_suppliers.id
LEFT JOIN mhl_cities city1 ON city1.id = mhl_suppliers.city_ID
LEFT JOIN mhl_communes commune1 ON commune1.id = city1.commune_ID
LEFT JOIN mhl_districts district1 ON district1.id = commune1.district_ID
LEFT JOIN mhl_cities city2 ON city2.id = mhl_suppliers.p_city_ID
LEFT JOIN mhl_communes commune2 ON commune2.id = city2.commune_ID
LEFT JOIN mhl_districts district2 ON district2.id = commune2.district_ID
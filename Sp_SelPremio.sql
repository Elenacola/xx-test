USE gestgift;

DELIMITER //;
CREATE PROCEDURE Sp_SelPremio(
	Codice varchar(20)
)
BEGIN

SELECT
a.*
FROM premi a	
WHERE A.Codice = trim(Codice);

END
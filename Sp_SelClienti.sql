USE gestgift;

DELIMITER //;
CREATE PROCEDURE Sp_SelCliente(
	Filter varchar(60)
)
BEGIN

DECLARE test smallint;

SELECT COUNT(*) INTO test FROM cards WHERE CODFIDELITY  = trim(Filter);

IF (test > 0) THEN
	SELECT
	A.CodFidelity,
	B.Bollini,
	B.ULTIMASPESA,
	concat(A.Nome,' ',A.Cognome) AS Nominativo,
    concat(A.Indirizzo,' - ',A.Cap,' - ',A.Comune,' - ',A.Prov) AS Recapito,
	A.Telefono1,
	A.Telefono2,
	A.Mail1,
	A.Mail2
	FROM clienti A JOIN cards B
	ON A.CodFidelity = b.CodFidelity
	WHERE A.CodFidelity = trim(Filter);
ELSE
	SELECT
	A.CodFidelity,
	B.Bollini,
	B.ULTIMASPESA,
	concat(A.Nome,' ',A.Cognome) AS Nominativo,
    concat(A.Indirizzo,' - ',A.Cap,' - ',A.Comune,' - ',A.Prov) AS Recapito,
	A.Telefono1,
	A.Telefono2,
	A.Mail1,
	A.Mail2
	FROM clienti A JOIN cards B
	ON A.CodFidelity = b.CodFidelity
	WHERE A.Cognome LIKE concat(trim(Filter), '%');
END IF;

END
USE gestgift;

DELIMITER //;
CREATE PROCEDURE Sp_SelPrenotazione(
	Filter varchar(20)
)
BEGIN

DECLARE test smallint;

SELECT COUNT(*) INTO test FROM prenotazioni WHERE CodFidelity  = trim(Filter);

IF (test > 0) THEN
	SELECT
	A.*,
    CONCAT(C.Nome,' ', C.Cognome) AS Nominativo,
    B.Descrizione,
    B.Bollini,
    B.Contributo
    FROM prenotazioni A JOIN premi B
    ON A.CODPREMIO = B.CODICE
    JOIN CLIENTI C 
    ON A.CODFIDELITY = C.CODFIDELITY
	WHERE A.CodFidelity = trim(Filter);
ELSE
	SELECT
	A.*,
    CONCAT(C.Nome,' ', C.Cognome) AS Nominativo,
    B.Descrizione,
    B.Bollini,
    B.Contributo
    FROM prenotazioni A JOIN premi B
    ON A.CODPREMIO = B.CODICE
    JOIN CLIENTI C 
    ON A.CODFIDELITY = C.CODFIDELITY
	WHERE A.Id = Filter;
END IF;

END
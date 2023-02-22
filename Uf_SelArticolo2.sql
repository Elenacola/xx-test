CREATE OR REPLACE FUNCTION 
Uf_SelArticolo2(V_CodArt IN articoli.codart%TYPE)
RETURNS TABLE (articolo text, um articoli.um%type, pzcart articoli.pzcart%type, codstat articoli.codstat%type,
			  peso articoli.PESONETTO%type, iva articoli.idiva%type, stato text, famass text,
			  magazzino numeric)
AS
$Code$
BEGIN
	RETURN QUERY 
	(
	SELECT
	A.CODART || ' ' || A.DESCRIZIONE,
	A.UM,
	A.PZCART,
	A.CODSTAT,
	A.PESONETTO,
	A.IDIVA AS IVA,
	CASE WHEN A.IDSTATOART = '1' THEN 'ATTIVO' ELSE 'NON ATTIVO' END AS STATO,
	A.IDFAMASS || ' ' || TRIM(B.DESCRIZIONE) AS REPARTO,
	Uf_GetQtaMag(A.CODART) AS QtaMag
	FROM ARTICOLI A JOIN FAMASSORT B
	ON A.IDFAMASS = B.ID
	WHERE A.CODART = V_CodArt);
END;
$Code$
LANGUAGE plpgsql;

SELECT (Uf_SelArticolo2('000036301')).*;
SELECT Uf_GetQtaMag('000036301');
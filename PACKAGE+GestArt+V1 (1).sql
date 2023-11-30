--Package GestArt V001

CREATE OR REPLACE PACKAGE GestArt
AS

    TYPE articoli_type IS RECORD
    (CodArt ARTICOLI.CODART%TYPE,
    Descrizione ARTICOLI.DESCRIZIONE%TYPE,
    Um ARTICOLI.UM%TYPE,
    PzCart  ARTICOLI.PZCART%TYPE,
    CodStat ARTICOLI.CODSTAT%TYPE,
    PesoNetto  ARTICOLI.PESONETTO%TYPE,
    Iva  ARTICOLI.IDIVA%TYPE,
    Stato  ARTICOLI.IDSTATOART%TYPE,
    IdFamAss ARTICOLI.IDFAMASS%TYPE,
    Reparto FAMASSORT.DESCRIZIONE%TYPE,
    QtaMag NUMBER
    );
    
    TYPE Info_Articolo IS REF CURSOR RETURN articoli_type;
     
    PROCEDURE Sp_SelArticolo(CODART_I IN ARTICOLI.CODART%TYPE, 
        ARTICOLO_O OUT Info_Articolo);
              
    FUNCTION Uf_GetQtaMag(CODART_I IN ARTICOLI.CODART%TYPE)
        RETURN NUMBER;
         
END GestArt;

--CORPO PACKAGE GESTART V001

CREATE OR REPLACE PACKAGE BODY GestArt
AS

--CORPO DELLA FUNZIONE Uf_GetQtaMag  
FUNCTION Uf_GetQtaMag(CODART_I IN ARTICOLI.CODART%TYPE)
    RETURN NUMBER
AS
    V_RetVal NUMBER;
BEGIN
    SELECT (ACQUISTATO - RESO - VENDUTO - USCITE - SCADUTI) INTO V_RetVal
    FROM MOVIMENTI
    WHERE
    CODART = CODART_I;  
    
    RETURN V_RetVal;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR (-20001, 'Errore Calcolo Magazzino Articolo ' || CODART_I);
            RETURN 0;
            
END Uf_GetQtaMag;

 --CORPO DELLA PROCEDURA Sp_SelArticolo 
PROCEDURE Sp_SelArticolo(CODART_I IN ARTICOLI.CODART%TYPE, 
    ARTICOLO_O OUT Info_Articolo)
IS

BEGIN

OPEN ARTICOLO_O FOR 
        SELECT
        CODART,
        A.DESCRIZIONE,
        UM,
        PZCART,
        CODSTAT,
        PESONETTO,
        IDIVA,
        IDSTATOART,
        IDFAMASS,
        TRIM(B.DESCRIZIONE) AS REPARTO,
        Uf_GetQtaMag(CODART) AS QTAMAG
        FROM ARTICOLI A JOIN FAMASSORT B
        ON A.IDFAMASS = B.ID
        WHERE CODART = CODART_I;

END Sp_SelArticolo;

END GestArt;
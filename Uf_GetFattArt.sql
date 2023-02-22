-- Funzione Uf_GetFattArt V.1
CREATE OR REPLACE FUNCTION Uf_GetFattArt
(CodArt_I ARTICOLI.CODART%TYPE,
Tipo_Vend NUMBER) -- 1 = Totale; 2 = Normale; 3 = Promo 
RETURN NUMBER
AS
    v_RetVal NUMBER;
BEGIN

   IF Tipo_Vend = 3 THEN
        SELECT NVL(SUM(QTA * Prezzo),0) INTO v_RetVal
        FROM DETTSCONTRINI
        WHERE CODART = CodArt_I
        AND INPROMO = 'Si';
    ELSIF Tipo_Vend = 2 THEN
        SELECT NVL(SUM(QTA * Prezzo),0) INTO v_RetVal
        FROM DETTSCONTRINI
        WHERE CODART = CodArt_I
        AND INPROMO = 'No';
    ELSE
        SELECT NVL(SUM(QTA * Prezzo),0) INTO v_RetVal
        FROM DETTSCONTRINI
        WHERE CODART = CodArt_I;
    END IF;
    
    RETURN v_RetVal;
    
    EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        RETURN(0);
        DBMS_OUTPUT.PUT_LINE ('Articolo non trovato o non venduto');
    WHEN OTHERS
    THEN
         RETURN(-1);
         DBMS_OUTPUT.PUT_LINE ('Errore Esecuzione Uf_GetPrzArt');
         
END Uf_GetFattArt;
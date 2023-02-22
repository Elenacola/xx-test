-- Funzione GetPrzArt V.1
CREATE OR REPLACE FUNCTION Uf_GetPrzArt
(V_CodArt DETTLISTINI.CODART%TYPE, 
V_IdList DETTLISTINI.IDLIST%TYPE)
RETURN NUMBER
AS
    CURSOR C_PrzList(I_IdList IN DETTLISTINI.IDLIST%TYPE, I_CodArt IN DETTLISTINI.CODART%TYPE) IS
        SELECT PREZZO  
        FROM DETTLISTINI
        WHERE CODART = I_CodArt AND
        IDLIST = I_IdList;
        
    V_RetVal NUMBER;
    
BEGIN

    OPEN C_PrzList(V_IdList,V_CodArt);
    
    FETCH C_PrzList INTO V_RetVal;
    
    IF C_PrzList%NOTFOUND THEN
        CLOSE C_PrzList;
        RETURN NULL;
    ELSE
        CLOSE C_PrzList;
        RETURN v_RetVal;
    END IF;
    
    EXCEPTION
    WHEN OTHERS
    THEN
        IF C_PrzList%ISOPEN THEN
            CLOSE C_PrzList;
        END IF;

END Uf_GetPrzArt;
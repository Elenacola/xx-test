--Creazione Procedura PremioBollini
CREATE OR REPLACE PROCEDURE Sp_GenPremioBollini(Anno_I IN NUMERIC, Mese_I IN NUMERIC)
AS
$CODE$
    --Creazione del cursore
	DECLARE 
	rec_cli   RECORD;
    C_BestCli CURSOR(V_MeseRif NUMERIC, V_AnnoRif NUMERIC)
    FOR
    SELECT DISTINCT CODFID
    FROM SCONTRINI
    WHERE CODFID <> '-1'
    AND EXTRACT(YEAR FROM DATA) = V_AnnoRif
    AND EXTRACT(MONTH FROM DATA) = V_MeseRif
    GROUP BY CODFID
    HAVING SUM(TOTALE)::NUMERIC >= 500;
    
BEGIN
	RAISE INFO 'Apertura Cursore con Anno % e mese %',Anno_I,Mese_I; 
	
	OPEN C_BestCli(Mese_I::numeric,Anno_I::numeric);
	
	
    LOOP
		RAISE INFO 'FETCH Cursore';
		
		FETCH C_BestCli INTO rec_cli;
		EXIT WHEN NOT FOUND;
        
		UPDATE CARDS_TEMP
        SET BOLLINI = BOLLINI + 500
        WHERE CODFIDELITY = rec_cli.CODFID;
        
        RAISE INFO 'Aggiunti 500 Punti alla Fidelity: %',rec_cli.CODFID;
        
    END LOOP;
	
	CLOSE C_BestCli;
	
	--ROLLBACK;
    
    --commit;
    
END;
$CODE$  
LANGUAGE plpgsql;


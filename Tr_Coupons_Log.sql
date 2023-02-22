--Esempio Creazione Trigger AFTER
CREATE OR REPLACE TRIGGER Tr_Coupons_Log
AFTER UPDATE OR DELETE ON COUPONS
FOR EACH ROW
DECLARE 
    v_TipoModifica VARCHAR2(10);
BEGIN
    v_TipoModifica := CASE
                    WHEN UPDATING THEN 'UPDATE'
                    WHEN DELETING THEN 'DELETE'
                    END;
                    
    IF (v_TipoModifica = 'UPDATE') THEN                
        INSERT INTO LOG_COUPON(DATA,CODFID,QTA,TIPO)
        VALUES(SYSDATE,:OLD.CODFID,:NEW.QTA,v_TipoModifica);
    ELSE
        INSERT INTO LOG_COUPON(DATA,CODFID,QTA,TIPO)
        VALUES(SYSDATE,:OLD.CODFID,-1,v_TipoModifica);
    END IF;
END;
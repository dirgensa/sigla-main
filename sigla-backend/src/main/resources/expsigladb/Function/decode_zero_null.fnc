CREATE OR REPLACE FUNCTION DECODE_ZERO_NULL (INPUT NUMBER) RETURN NUMBER IS
  BEGIN
    IF INPUT = 0 THEN RETURN NULL;
      ELSE  RETURN INPUT;
    END IF;
      
  END;
/



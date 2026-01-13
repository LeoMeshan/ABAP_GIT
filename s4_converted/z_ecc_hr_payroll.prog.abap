REPORT Z_ECC_HR_PAYROLL.
START-OF-SELECTION.
  SELECT FROM pa0001
INTO @DATA(ls_pa0001)
WHERE persnr = '00000001'.
  
  IF sy-subrc = 0.
SELECT SINGLE FROM pa0001
  INTO @DATA(ls_pernr)
  WHERE persnr = '00000001'.
  
IF sy-subrc = 0.
  SELECT SINGLE FROM pypln
INTO @DATA(ls_pypln)
WHERE pernr = '00000001'
  AND bukrs = ls_pernr-bukrs.
  
  IF sy-subrc = 0.
WRITE: / 'Payroll data found:'.
WRITE: / 'Employee:', ls_pypln-pernr.
WRITE: / 'Company Code:', ls_pypln-bukrs.
WRITE: / 'Basic Pay:', ls_pypln-loekz.
  ELSE.
WRITE: / 'No payroll data found for employee'.
  ENDIF.
ELSE.
  WRITE: / 'Employee not found in PA0001'.
ENDIF.
  ELSE.
WRITE: / 'Employee not found in PA0001'.
  ENDIF.
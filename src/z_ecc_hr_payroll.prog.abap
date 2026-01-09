REPORT Z_ECC_HR_PAYROLL.

DATA: lt_rgdir TYPE TABLE OF pc261,
  ls_rgdir TYPE pc261.

CALL FUNCTION 'CU_READ_RGDIR'
  EXPORTING
persnr = '00000001'
  TABLES
in_rgdir = lt_rgdir.

READ TABLE lt_rgdir INTO ls_rgdir INDEX 1.

IF sy-subrc = 0.
  CALL FUNCTION 'PYXX_READ_PAYROLL_RESULT'
EXPORTING
  clusterid = 'RX'
  employeenumber = '00000001'
  sequencenumber = ls_rgdir-seqnr.
ENDIF.
//

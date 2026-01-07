*&---------------------------------------------------------------------*
*& Report ZITR_SHIFT_LC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZITR_SHIFT_LC.


DATA: lt_vbfa TYPE TABLE OF vbfa,
      ls_vbfa TYPE vbfa.

SELECT *
  FROM vbfa
  INTO TABLE lt_vbfa
  WHERE vbelv = '0080001234'.

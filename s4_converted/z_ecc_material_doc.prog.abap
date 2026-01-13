REPORT z_s4hana_material_doc.
SELECT-OPTIONS: s_mblnr FOR matdoc-mblnr,
   s_matnr FOR mseg-matnr.

SELECT FROM matdoc
   INNER JOIN mseg ON matdoc~mblnr = mseg~mblnr
   AND matdoc~mjahr = mseg~mjahr
   WHERE matdoc~mblnr IN @s_mblnr
 AND mseg~matnr IN @s_matnr
   INTO TABLE @DATA(lt_result).

LOOP AT lt_result INTO DATA(ls_result).
  WRITE: / ls_result-mblnr,
   ls_result-mjahr,
   ls_result-matnr,
   ls_result-menge,
   ls_result-dmbtr.
ENDLOOP.
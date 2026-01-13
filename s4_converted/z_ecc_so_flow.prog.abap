REPORT z_ecc_so_flow.
SELECT-OPTIONS: s_vbeln FOR vbak-vbeln, s_matnr FOR vbap-matnr.
TYPES: BEGIN OF ty_data, so_vbeln TYPE vbak-vbeln, so_posnr TYPE vbap-posnr, matnr TYPE vbap-matnr, kwmeng TYPE vbap-kwmeng, deliv TYPE likp-vbeln, lfimg TYPE lips-lfimg, bill TYPE vbrk-vbeln, fkimg TYPE vbrp-fkimg, menge TYPE mseg-menge, END OF ty_data.
DATA: lt_data TYPE TABLE OF ty_data, ls_data TYPE ty_data.
SELECT a~vbeln, b~posnr, b~matnr, b~kwmeng, c~vbeln, d~lfimg, e~vbeln, f~fkimg, g~menge
  FROM vbak AS a INNER JOIN vbap AS b ON a~vbeln = b~vbeln
  LEFT OUTER JOIN likp AS c ON b~vbeln = c~vbeln
  LEFT OUTER JOIN lips AS d ON b~vbeln = d~vgbel AND b~posnr = d~vgpos
  LEFT OUTER JOIN vbrk AS e ON d~vbeln = e~vbeln
  LEFT OUTER JOIN vbrp AS f ON b~vbeln = f~aubel AND b~posnr = f~aupos
  LEFT OUTER JOIN mseg AS g ON b~matnr = g~matnr
  WHERE a~vbeln IN @s_vbeln AND b~matnr IN @s_matnr
  INTO (@ls_data-so_vbeln,@ls_data-so_posnr,@ls_data-matnr,@ls_data-kwmeng,@ls_data-deliv,@ls_data-lfimg,@ls_data-bill,@ls_data-fkimg,@ls_data-menge).
  APPEND ls_data TO lt_data.
ENDSELECT.
LOOP AT lt_data INTO ls_data.
  WRITE: / ls_data-so_vbeln, ls_data-so_posnr, ls_data-matnr,
   ls_data-kwmeng, ls_data-deliv, ls_data-lfimg,
   ls_data-bill, ls_data-fkimg, ls_data-menge.
ENDLOOP.
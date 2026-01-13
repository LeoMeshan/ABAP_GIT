REPORT zsrpractice1.

TYPES: BEGIN OF ty_final,
vbeln TYPE vbak-vbeln,
posnr TYPE vbap-posnr,
erdat TYPE vbap-erdat,
ernam TYPE vbak-ernam,
mtart TYPE mara-mtart,
  END OF ty_final.

DATA: gt_final TYPE STANDARD TABLE OF ty_final WITH NON-UNIQUE KEY vbeln.

SELECT-OPTIONS: s_vbeln FOR vbak-vbeln.

INITIALIZATION.
  LOOP AT SCREEN.
CASE screen-group1.
  WHEN 'GRP1'.
screen-input = 1.
MODIFY SCREEN.
  WHEN 'GRP2'.
screen-input = 0.
MODIFY SCREEN.
ENDCASE.
  ENDLOOP.

START-OF-SELECTION.
  SELECT a~vbeln b~posnr b~erdat a~ernam c~mtart
INTO TABLE @gt_final
FROM vbak AS a INNER JOIN vbap AS b ON a~vbeln = b~vbeln
INNER JOIN mara AS c ON b~matnr = c~matnr
WHERE a~vbeln IN @s_vbeln.
REPORT Z_ECC_SO_BILLING.

SELECT-OPTIONS: s_vbeln FOR vbak-vbeln.

TYPES: BEGIN OF ty_data,
 vbeln   TYPE vbak-vbeln,
 posnr   TYPE vbap-posnr,
 matnr   TYPE vbap-matnr,
 kwmeng  TYPE vbap-kwmeng,
 fkimg   TYPE vbrp-fkimg,
   END OF ty_data.

DATA: lt_data TYPE TABLE OF ty_data,
  ls_data TYPE ty_data.

SELECT vbak~vbeln
   vbap~posnr
   vbap~matnr
   vbap~kwmeng
   vbrp~fkimg
  FROM vbak
  INNER JOIN vbap ON vbak~vbeln = vbap~vbeln
  LEFT JOIN vbrp ON vbap~vbeln = vbrp~aubel
 AND vbap~posnr = vbrp~aupos
  WHERE vbak~vbeln IN @s_vbeln
  INTO TABLE @lt_data.

LOOP AT lt_data INTO ls_data.
  WRITE: / ls_data-vbeln,
   ls_data-posnr,
   ls_data-matnr,
   ls_data-kwmeng,
   ls_data-fkimg.
ENDLOOP.
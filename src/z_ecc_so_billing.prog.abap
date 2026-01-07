*&---------------------------------------------------------------------*
*& Report Z_ECC_SO_BILLING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ECC_SO_BILLING.

TABLES: vbak, vbap, vbrp.

SELECT-OPTIONS: s_vbeln FOR vbak-vbeln.

DATA: BEGIN OF gs_data,
        vbeln   TYPE vbak-vbeln,
        posnr   TYPE vbap-posnr,
        matnr   TYPE vbap-matnr,
        kwmeng  TYPE vbap-kwmeng,
        fkimg   TYPE vbrp-fkimg,
      END OF gs_data.

SELECT vbak~vbeln
       vbap~posnr
       vbap~matnr
       vbap~kwmeng
       vbrp~fkimg
  INTO gs_data
  FROM vbak
  INNER JOIN vbap ON vbak~vbeln = vbap~vbeln
  LEFT JOIN vbrp ON vbap~vbeln = vbrp~aubel
                 AND vbap~posnr = vbrp~aupos
  WHERE vbak~vbeln IN s_vbeln.

  WRITE: / gs_data-vbeln,
           gs_data-posnr,
           gs_data-matnr,
           gs_data-kwmeng,
           gs_data-fkimg.
ENDSELECT.

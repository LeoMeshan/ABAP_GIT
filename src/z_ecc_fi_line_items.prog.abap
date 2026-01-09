*&---------------------------------------------------------------------*
*& Report Z_ECC_FI_LINE_ITEMS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ECC_FI_LINE_ITEMS.

TABLES: bkpf,
        bseg,
        bsis.

SELECT-OPTIONS:
  s_bukrs FOR bkpf-bukrs,
  s_gjahr FOR bkpf-gjahr,
  s_hkont FOR bseg-hkont.

DATA: BEGIN OF gs_fi,
        bukrs TYPE bkpf-bukrs,
        belnr TYPE bkpf-belnr,
        gjahr TYPE bkpf-gjahr,
        hkont TYPE bseg-hkont,
        dmbtr TYPE bseg-dmbtr,
      END OF gs_fi.

SELECT bkpf~bukrs
       bkpf~belnr
       bkpf~gjahr
       bseg~hkont
       bseg~dmbtr
  INTO gs_fi
  FROM bkpf
  INNER JOIN bseg
    ON bkpf~bukrs = bseg~bukrs
   AND bkpf~belnr = bseg~belnr
   AND bkpf~gjahr = bseg~gjahr
  LEFT JOIN bsis
    ON bseg~bukrs = bsis~bukrs
   AND bseg~belnr = bsis~belnr
   AND bseg~gjahr = bsis~gjahr
  WHERE bkpf~bukrs IN s_bukrs
    AND bkpf~gjahr IN s_gjahr
    AND bseg~hkont IN s_hkont.

  WRITE: / gs_fi-bukrs,
           gs_fi-belnr,
           gs_fi-gjahr,
           gs_fi-hkont,
           gs_fi-dmbtr.
ENDSELECT.

*&---------------------------------------------------------------------*
*& Report Z_S4HANA_FI_LINE_ITEMS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S4HANA_FI_LINE_ITEMS.

TABLES: acdoca,
        bseg,
        bsis.

SELECT-OPTIONS:
  s_bukrs FOR acdoca-bukrs,
  s_gjahr FOR acdoca-gjahr,
  s_hkont FOR bseg-hkont.

TYPES: BEGIN OF ty_fi,
 bukrsTYPE acdoca-bukrs,
 belnrTYPE acdoca-belnr,
 gjahrTYPE acdoca-gjahr,
 hkontTYPE bseg-hkont,
 dmbtrTYPE bseg-dmbtr,
   END OF ty_fi.

DATA: ls_fi TYPE ty_fi.

SELECT acdoca~bukrs
   acdoca~belnr
   acdoca~gjahr
   bseg~hkont
   bseg~dmbtr
  INTO @ls_fi-bukrs
@ls_fi-belnr
@ls_fi-gjahr
@ls_fi-hkont
@ls_fi-dmbtr
  FROM acdoca
  INNER JOIN bseg
ON acdoca~bukrs = bseg~bukrs
AND acdoca~belnr = bseg~belnr
AND acdoca~gjahr = bseg~gjahr
  LEFT JOIN bsis
ON bseg~bukrs = bsis~bukrs
AND bseg~belnr = bsis~belnr
AND bseg~gjahr = bsis~gjahr
  WHERE acdoca~bukrs IN @s_bukrs
AND acdoca~gjahr IN @s_gjahr
AND bseg~hkont IN @s_hkont.
  WRITE: / |{ ls_fi-bukrs } { ls_fi-belnr } { ls_fi-gjahr }
   { ls_fi-hkont } { ls_fi-dmbtr }|.
ENDSELECT.
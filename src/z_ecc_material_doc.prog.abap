*&---------------------------------------------------------------------*
*& Report Z_ECC_MATERIAL_DOC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ECC_MATERIAL_DOC.

TABLES: mkpf, mseg.

SELECT-OPTIONS: s_mblnr FOR mkpf-mblnr.
SELECT-OPTIONS: s_matnr FOR mseg-matnr.

SELECT mkpf~mblnr
       mkpf~mjahr
       mseg~matnr
       mseg~menge
       mseg~dmbtr
  INTO (mkpf-mblnr,
        mkpf-mjahr,
        mseg-matnr,
        mseg-menge,
        mseg-dmbtr)
  FROM mkpf
  INNER JOIN mseg
    ON mkpf~mblnr = mseg~mblnr
   AND mkpf~mjahr = mseg~mjahr
  WHERE mkpf~mblnr IN s_mblnr
    AND mseg~matnr IN s_matnr.

  WRITE: / mkpf-mblnr,
           mkpf-mjahr,
           mseg-matnr,
           mseg-menge,
           mseg-dmbtr.
ENDSELECT.

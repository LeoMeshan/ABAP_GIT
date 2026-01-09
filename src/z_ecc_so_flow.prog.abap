*&---------------------------------------------------------------------*
*& Program Name : Z_ECC_SO_FLOW
*& Title        : ECC Sales–Delivery–Billing–Material Flow Report
*&---------------------------------------------------------------------*
*& Description  :
*&   Custom ECC report to display Sales Order, Delivery, Billing and
*&   related Material Movement data. This program is used as an
*&   AS-IS reference for ECC → S/4HANA migration and AI fine-tuning.
*&
*& Key ECC Tables:
*&   VBAK, VBAP, LIKP, LIPS, VBRK, VBRP, MSEG
*&
*& S/4HANA Impact:
*&   - Direct MSEG access not allowed
*&   - Requires CDS-based redesign
*&   - SELECT-ENDSELECT performance issues
*&
*& Usage        : Migration / AI Training Dataset
*& Author       : <Abishek / ABAP>
*& Created On   : <09-01-2026>
*&---------------------------------------------------------------------*

REPORT z_ecc_so_flow.

TABLES: vbak,
        vbap,
        likp,
        lips,
        vbrk,
        vbrp,
        mseg.

SELECT-OPTIONS:
  s_vbeln FOR vbak-vbeln,
  s_matnr FOR vbap-matnr.

DATA: BEGIN OF gs_data,
        so_vbeln TYPE vbak-vbeln,
        so_posnr TYPE vbap-posnr,
        matnr    TYPE vbap-matnr,
        kwmeng   TYPE vbap-kwmeng,
        deliv    TYPE likp-vbeln,
        lfimg    TYPE lips-lfimg,
        bill     TYPE vbrk-vbeln,
        fkimg    TYPE vbrp-fkimg,
        menge    TYPE mseg-menge,
      END OF gs_data.

SELECT vbak~vbeln,
       vbap~posnr,
       vbap~matnr,
       vbap~kwmeng,
       likp~vbeln,
       lips~lfimg,
       vbrk~vbeln,
       vbrp~fkimg,
       mseg~menge
  INTO (gs_data-so_vbeln,
        gs_data-so_posnr,
        gs_data-matnr,
        gs_data-kwmeng,
        gs_data-deliv,
        gs_data-lfimg,
        gs_data-bill,
        gs_data-fkimg,
        gs_data-menge)
  FROM vbak
  INNER JOIN vbap
    ON vbak~vbeln = vbap~vbeln
  LEFT JOIN lips
    ON vbap~vbeln = lips~vgbel
   AND vbap~posnr = lips~vgpos
  LEFT JOIN likp
    ON lips~vbeln = likp~vbeln
  LEFT JOIN vbrp
    ON vbap~vbeln = vbrp~aubel
   AND vbap~posnr = vbrp~aupos
  LEFT JOIN vbrk
    ON vbrp~vbeln = vbrk~vbeln
  LEFT JOIN mseg
    ON vbap~matnr = mseg~matnr
  WHERE vbak~vbeln IN s_vbeln
    AND vbap~matnr IN s_matnr.
ENDSELECT.

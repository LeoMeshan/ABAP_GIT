*&---------------------------------------------------------------------*
*& Report Z_ECC_ASSET_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ECC_ASSET_REPORT.


TABLES: anla,
        anep,
        anlc.

SELECT-OPTIONS:
  s_anln1 FOR anla-anln1,
  s_bukrs FOR anla-bukrs.

DATA: BEGIN OF gs_asset,
        bukrs TYPE anla-bukrs,
        anln1 TYPE anla-anln1,
        txt50 TYPE anla-txt50,
        afabe TYPE anlc-afabe,
        nafav TYPE anlc-nafav,
      END OF gs_asset.

SELECT anla~bukrs
       anla~anln1
       anla~txt50
       anlc~afabe
       anlc~nafav
  INTO gs_asset
  FROM anla
  INNER JOIN anlc
    ON anla~bukrs = anlc~bukrs
   AND anla~anln1 = anlc~anln1
  WHERE anla~bukrs IN s_bukrs
    AND anla~anln1 IN s_anln1.

  WRITE: / gs_asset-bukrs,
           gs_asset-anln1,
           gs_asset-txt50,
           gs_asset-afabe,
           gs_asset-nafav.
ENDSELECT.
